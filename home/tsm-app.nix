{ pkgs, ... }:

let
  tsm-app-fhs = pkgs.buildFHSEnv {
    name = "tsm-app-fhs";

    # Provide the system libraries that PySide6 (manylinux wheel from PyPI)
    # expects at standard FHS paths. The Nix-managed Python uses the Nix store
    # linker directly, so nix-ld cannot help — buildFHSEnv is the right tool.
    targetPkgs = pkgs: with pkgs; [
      stdenv.cc.cc.lib   # libstdc++.so.6, libgcc_s.so.1
      libGL              # libGL.so.1 (libglvnd dispatch → NVIDIA)
      glib               # libglib-2.0.so.0
      fontconfig         # libfontconfig.so.1
      freetype           # libfreetype.so.6
      zlib               # libz.so.1
      libxkbcommon       # libxkbcommon.so.0 (Qt input/Wayland)
      wayland            # libwayland-*.so (Qt Wayland backend)
      xorg.libX11
      xorg.libXext
      xorg.libxcb
      xorg.libXrender
      dbus
      expat
    ];

    runScript = pkgs.writeShellScript "tsm-app-run" ''
      bin="$HOME/.local/share/uv/tools/tsm-app/bin/tsm-app"
      if [ ! -x "$bin" ]; then
        echo "tsm-app is not installed."
        echo "Run: uv tool install git+https://github.com/exceptionptr/tsm-app-linux"
        exit 1
      fi
      exec "$bin" "$@"
    '';
  };
in {
  # ~/.local/bin comes before ~/.nix-profile/bin in PATH on this system, so we
  # place the FHS wrapper directly there as the user-facing tsm-app entry point.
  home.file.".local/bin/tsm-app" = {
    source = "${tsm-app-fhs}/bin/tsm-app-fhs";
  };

  # Redirect uv tool executables away from ~/.local/bin so they don't clobber
  # the Home Manager-managed wrapper above. The actual venv stays at the default
  # ~/.local/share/uv/tools/tsm-app/ — only the CLI shim moves.
  home.sessionVariables.UV_TOOL_BIN_DIR = "$HOME/.local/share/uv-tools-bin";
}
