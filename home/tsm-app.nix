{ pkgs, lib, ... }:

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
      zstd               # libzstd.so.1 (Qt compression)
      openssl            # libssl/libcrypto (Qt networking/TLS)
      libxkbcommon       # libxkbcommon.so.0 (Qt input/Wayland)
      wayland            # libwayland-*.so (Qt Wayland backend)
      xorg.libX11
      xorg.libXext
      xorg.libxcb
      xorg.libXrender
      dbus
      expat
      libgcrypt
      libgpg-error
    ];

    runScript = pkgs.writeShellScript "tsm-app-run" ''
      # The Nix glibc linker doesn't search /usr/lib inside the FHS sandbox —
      # it only follows RPATH and LD_LIBRARY_PATH. Set it explicitly so PySide6
      # manylinux .so files can find their system lib dependencies.
      export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath (with pkgs; [
        stdenv.cc.cc.lib
        libGL
        glib
        fontconfig
        freetype
        zlib
        zstd
        openssl
        libxkbcommon
        wayland
        xorg.libX11
        xorg.libXext
        xorg.libxcb
        xorg.libXrender
        dbus
        expat
        libgcrypt
        libgpg-error
      ])}''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"

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
  # Redirect uv tool executables away from ~/.local/bin so they don't clobber
  # the FHS wrapper below. The actual venv stays at ~/.local/share/uv/tools/tsm-app/.
  home.sessionVariables.UV_TOOL_BIN_DIR = "$HOME/.local/share/uv-tools-bin";

  # Force the FHS wrapper into ~/.local/bin/tsm-app on every rebuild.
  # home.file cannot be used here because uv also writes to this path and would
  # overwrite a static symlink on reinstall. home.activation runs last and wins.
  home.activation.tsm-app-wrapper = lib.hm.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD ln -sf "${tsm-app-fhs}/bin/tsm-app-fhs" "$HOME/.local/bin/tsm-app"
  '';
}
