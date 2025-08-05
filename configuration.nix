# configuration.nix
{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./environment.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "larry-desktop";
  networking.networkmanager.enable = true;

  # Timezone and Locale
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  # Enable sound with Pipewire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define user and link to home-manager config
  users.users.lrabbets = {
    isNormalUser = true;
    description = "Lawrence Rabbets";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Home-Manager configuration
  home-manager.users.lrabbets = import ./home.nix;
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # Enable Hyprland and a lightweight greeter
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  services.greetd = {
    enable = true;
    settings.default_session.command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
  };

  # -- Graphics and Vulkan Driver Configuration --
  # This section is crucial for gaming.
  # CORRECTED: Using the modern 'hardware.graphics' options.
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Enable 32-bit support for Wine/Proton
  };

  # NVIDIA drivers
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    open = false; # Use the proprietary driver
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  system.stateVersion = "25.05";
}
