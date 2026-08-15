# configuration.nix
{ config, pkgs, pkgs-unstable, theme, ... }:

{
  imports = [
    ./hardware-configuration.nix # Auto-generated hardware config
    ./system-packages.nix # System-wide packages
    ./mounts.nix # Filesystem mount configuration
    ./home.nix # Home-manager configuration
    ./sddm.nix # SDDM display manager with Catppuccin theme
    # ./ollama.nix # Local AI model server (heavy build!)
  ];

  # Bootloader - systemd-boot is simpler than GRUB
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "larry-desktop";
  networking.networkmanager.enable = true; # GUI network management
  networking.networkmanager.plugins = with pkgs; [
    networkmanager-openvpn
    networkmanager-openconnect
  ];
  
  # Disable IPv6 to prevent VPN leaks
  networking.enableIPv6 = false;
  # Force-disable at the default level so any new interface inherits this.
  # Per-interface sysctl entries are skipped as the interface may not exist at sysctl time.
  boot.kernel.sysctl = {
    "net.ipv6.conf.default.disable_ipv6" = 1;
  };

  # Firewall configuration for Minecraft server
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 25565 ]; # Minecraft server
    allowedUDPPorts = [ 25565 ]; # Minecraft server
  };

  # DNS resolution service for caching and security
  services.resolved = {
    enable = true;
    # Disable resolved's built-in mDNS to avoid conflicting with avahi,
    # which handles mDNS + DNS-SD (needed for printer discovery)
    extraConfig = "MulticastDNS=no";
  };

  # irqbalance disabled - read-only /proc/irq on this system makes it ineffective,
  # and single-socket gaming desktops don't benefit from it anyway
  services.irqbalance.enable = false;
  
  # Enable UPower for power management information
  services.upower.enable = true;

  # Printing services - CUPS with Brother printer support
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      brlaser              # Brother laser printer driver (open source)
      brgenml1lpr          # Brother generic LPR driver
      brgenml1cupswrapper  # Brother generic CUPS wrapper
    ];
    # Only listen on IPv4 since IPv6 is disabled
    listenAddresses = [ "localhost:631" ];
  };

  # Enable color management for printers (fixes ColorManager DBus warnings)
  services.colord.enable = true;
  
  # Enable network printer discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Timezone and Locale
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  # Sound via Pipewire (modern replacement for PulseAudio)
  services.pulseaudio.enable = false; # Disable old audio system
  security.rtkit.enable = true; # Real-time scheduling for audio
  services.pipewire = {
    enable = true;
    alsa.enable = true; # ALSA compatibility
    alsa.support32Bit = true; # 32-bit app support
    pulse.enable = true; # PulseAudio compatibility

    # Raise min-quantum from the default of 32 to 512.
    # Adding filter-chain nodes lowers the negotiated graph quantum, causing
    # xruns on output nodes. 512 is the recommended floor when running LADSPA
    # filter-chains (per PipeWire GitLab issue #3852).
    extraConfig.pipewire."92-quantum" = {
      "context.properties" = {
        "default.clock.min-quantum" = 512;
      };
    };

    # Discord's WebRTC stack negotiates an unusual quantum of 360 samples which
    # doesn't align with ALSA period boundaries, causing xruns and crackling.
    # Force Discord's PulseAudio client to use 1024/48000 (~21ms) instead.
    extraConfig.pipewire-pulse."30-discord-quantum" = {
      "pulse.rules" = [
        {
          matches = [ { "application.name" = "Discord"; } ];
          actions = {
            "update-props" = {
              "pulse.min.quantum" = "1024/48000";
            };
          };
        }
      ];
    };

    # DeepFilterNet noise suppression as a PipeWire filter-chain virtual mic.
    # Wraps the raw H390 mic in the DeepFilterNet LADSPA plugin and exposes the
    # result as "DeepFilter Noise Cancellation". priority.session=1010 makes
    # WirePlumber prefer it over the raw H390 (default priority ~1000).
    extraConfig.pipewire."99-deepfilter" = {
      "context.modules" = [
        {
          name = "libpipewire-module-filter-chain";
          args = {
            "node.description" = "DeepFilter Noise Cancellation";
            "media.name"       = "DeepFilter Noise Cancellation";
            "filter.graph" = {
              nodes = [
                {
                  type    = "ladspa";
                  name    = "DeepFilter Mono";
                  plugin  = "${pkgs.deepfilternet}/lib/ladspa/libdeep_filter_ladspa.so";
                  label   = "deep_filter_mono";
                  control = { "Attenuation Limit (dB)" = 100; };
                }
              ];
            };
            "node.latency"   = "512/48000";
            "audio.rate"     = 48000;
            "audio.channels" = 1;
            "audio.position" = [ "MONO" ];
            "capture.props" = {
              "node.name"    = "capture.DeepFilter_Noise_Cancellation";
              "node.passive" = true;
              "audio.rate"   = 48000;
            };
            "playback.props" = {
              "node.name"        = "DeepFilter_Noise_Cancellation";
              "media.class"      = "Audio/Source";
              "audio.rate"       = 48000;
              "priority.session" = 1010;
            };
          };
        }
      ];
    };

  };

  # User account configuration
  users.users.lrabbets = {
    isNormalUser = true;
    description = "Lawrence Rabbets";
    extraGroups = [ "networkmanager" "wheel" ]; # wheel = sudo access
  };

  programs.zsh.enable = true; # Enable Zsh system-wide

  # SSH agent disabled - using 1Password SSH agent instead
  programs.ssh.startAgent = false;

  # Home-Manager configuration - manages user environment
  home-manager = {
    useGlobalPkgs = true; # Use system nixpkgs
    useUserPackages = true; # Install to user profile
    backupFileExtension = "backup"; # Backup existing files instead of failing
    extraSpecialArgs = { inherit pkgs-unstable theme; }; # Pass variables to home config
    users.lrabbets = { ... }: {
      # User configuration defined in home.nix
    };
  };

  # Nix configuration
  nix.settings.trusted-users = [ "root" "lrabbets" ]; # Users who can configure Nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ]; # Enable new Nix CLI
  nix.settings.download-buffer-size = 134217728; # 128MB download buffer (default: 64MB)
  
  # Development environment optimization
  nix.settings.keep-outputs = true; # Keep build outputs for development shells
  nix.settings.keep-derivations = true; # Keep derivations for development shells
  
  nixpkgs.config.allowUnfree = true; # Allow proprietary software

  # Automatic garbage collection - runs daily and keeps only last 3 days
  nix.gc = {
    automatic = true;
    dates = "daily"; # Run every day at 03:15
    options = "--delete-older-than 3d"; # Keep only last 3 days (very aggressive)
  };
  
  # Run user garbage collection alongside system cleanup
  systemd.user.services.nix-gc-user = {
    description = "Nix Garbage Collector (User)";
    script = "${pkgs.nix}/bin/nix-collect-garbage --delete-older-than 3d";
    serviceConfig = {
      Type = "oneshot";
      User = "lrabbets";
    };
  };
  
  systemd.user.timers.nix-gc-user = {
    description = "Nix Garbage Collection Timer (User)";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      RandomizedDelaySec = "1800"; # 30min random delay
      Persistent = true;
    };
  };

  # Automatic store optimization to reduce disk usage
  nix.settings.auto-optimise-store = true;

  # Automatic system updates disabled - manual updates on Sundays
  system.autoUpgrade.enable = false;

  # Hyprland window manager (Wayland-based)
  # Note: Package version is managed in home/hyprland.nix via home-manager
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true; # X11 app compatibility

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # Steam with GE-Proton support
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Allow Steam Remote Play
    dedicatedServer.openFirewall = true; # Allow dedicated servers
    gamescopeSession.enable = true; # Enable gamescope session
    extraCompatPackages = [
      pkgs-unstable.proton-ge-bin # GE-Proton for better game compatibility
    ];
  };

  # XDG Desktop Portal for proper Wayland app integration
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    # Explicit per-desktop config avoids the deprecated UseIn key fallback
    config.hyprland = {
      default = [ "hyprland" "gtk" ];
    };
  };

  # Enable PAM authentication for screen locking
  security.pam.services.hyprlock = {};

  # Enable gnome-keyring for 1Password secret storage
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  # Enable automatic trim
  services.fstrim.enable = true;

  # Graphics configuration for gaming and GPU acceleration
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Required for Wine/Steam Proton games
  };

  # Enable NVIDIA driver loading
  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.screenSection = ''
    Option "Coolbits" "28"
  '';

  # NVIDIA driver configuration
  hardware.nvidia = {
    modesetting.enable = true; # Required for Wayland
    open = false; # Use proprietary driver (better gaming performance)
    nvidiaSettings = true; # Include nvidia-settings GUI
    package = config.boot.kernelPackages.nvidiaPackages.stable; # Stable driver version
    
    # Power management disabled - known to cause shutdown hangs on NVIDIA + Wayland
    # (driver tries to save GPU memory state on shutdown, which stalls kernel poweroff)
    # Re-enable only if you need suspend/hibernate support
    powerManagement.enable = false;
    powerManagement.finegrained = false;
  };

  # Cap shutdown wait time so a stuck process can't hang forever
  systemd.extraConfig = "DefaultTimeoutStopSec=15s";

  # CPU governor - performance mode for gaming
  powerManagement.cpuFreqGovernor = "performance";

  # Enable swap for better memory pressure handling
  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 8*1024; # 8GB swap file
  } ];

  # Fix NVIDIA device node creation
  services.udev.extraRules = ''
    KERNEL=="nvidia_uvm", OWNER="root", GROUP="video", MODE="0660"
    KERNEL=="nvidia*", OWNER="root", GROUP="video", MODE="0660"
    KERNEL=="nvidiactl", OWNER="root", GROUP="video", MODE="0660"
  '';

  # Ensure NFS state directories exist
  systemd.tmpfiles.rules = [
    "d /var/lib/nfs 0755 root root"
    "d /var/lib/nfs/sm 0755 root root"
    "d /var/lib/nfs/sm.bak 0755 root root"
  ];

  # GPU clock speed configuration via systemd service
  systemd.services.gpu-undervolt = {
    description = "GPU Undervolting Service";
    after = [ "graphical-session.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "/run/current-system/sw/bin/nvidia-smi -lgc 1830";
      User = "root";
    };
  };

  system.stateVersion = "25.05";
}
