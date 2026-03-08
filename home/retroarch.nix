# RetroArch - Emulation Frontend
{ pkgs-unstable, ... }:

{
  home.packages = [
    (pkgs-unstable.retroarch.withCores (cores: with cores; [
      # Nintendo
      bsnes           # SNES (accuracy-focused)
      snes9x          # SNES (performance-focused)
      nestopia        # NES
      mupen64plus     # N64
      mgba            # GBA/GB/GBC
      dolphin         # GameCube/Wii

      # Sega
      genesis-plus-gx # Genesis/Mega Drive/CD/Master System/Game Gear
      beetle-saturn   # Saturn

      # Sony
      pcsx2           # PS2
      swanstation     # PS1 (performance-focused, formerly duckstation)
      ppsspp          # PSP

      # Arcade
      fbneo           # Final Burn Neo (arcade)
      mame            # MAME (arcade)

      # Other
      dosbox-pure     # DOS games
    ]))
  ];
}
