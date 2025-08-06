# My NixOS & Hyprland Dotfiles

Welcome to my personal NixOS configuration repository. This is my ongoing adventure into the world of declarative system configuration, with the goal of creating a lightweight, keyboard-driven desktop environment using Hyprland.

### A Note for Visitors

**Heads up: I am a novice learning NixOS and Linux customisation.** The configurations you find here are a work in progress, often held together with digital sticky tape and optimism. They might not always follow best practices, and there are almost certainly more efficient or elegant ways to achieve the same results.

This repository serves as my personal learning log. Feel free to browse, but please be aware that this is not a polished, expert-level setup. Here be dragons (and probably a few syntax errors).

---

## Desktop Overview

This configuration builds a complete desktop environment using the following key components:

* **OS:** [NixOS](https://nixos.org/) (Unstable Channel)
* **Window Manager:** [Hyprland](https://hyprland.org/) (a dynamic tiling Wayland compositor)
* **System Management:** [Home Manager](https://github.com/nix-community/home-manager)
* **Bar:** [Waybar](https://github.com/Alexays/Waybar)
* **Launcher:** [Wofi](https://hg.sr.ht/~scoopta/wofi)
* **Lock Screen:** [Hyprlock](https://github.com/hyprwm/hyprlock)
* **Terminal:** [Kitty](https://sw.kovidgoyal.net/kitty/)
* **Shell:** [Zsh](https://www.zsh.org/) with [Oh My Zsh](https://ohmyz.sh/) and [Starship](https://starship.rs/) prompt
* **Notification Daemon:** [Mako](https://github.com/emersion/mako)
* **Wallpaper Manager:** [Hyprpaper](https://github.com/hyprwm/hyprpaper)
* **File Manager:** [Thunar](https://docs.xfce.org/xfce/thunar/start)
* **Image Viewer:** [Loupe](https://gitlab.gnome.org/GNOME/loupe)
* **Audio:** [PipeWire](https://pipewire.org/)

This setup also includes a custom screenshot script that saves files, copies to the clipboard, and sends a notification, as well as a selection of packages for gaming, such as `Steam`, `ProtonUp-Qt`, `GameMode`, and `Gamescope`.

## File Structure

The configuration is managed using Nix Flakes and has been modularised to keep things organised and (mostly) sane.

```
.
├── flake.nix
├── flake.lock
├── README.md
├── configuration.nix
├── hardware-configuration.nix
├── home.nix
├── environment.nix
|
├── home/
│   ├── 1password.nix
│   ├── default-apps.nix
│   ├── firefox.nix
│   ├── git.nix
│   ├── hyprland.nix
│   ├── kitty.nix
│   ├── packages.nix
│   ├── scripts.nix
│   ├── shell.nix
│   ├── vscode.nix
│   ├── waybar.nix
│   └── wofi.nix
│
├── hyprlock/
│   ├── hyprlock.conf
│   └── hyprlock.nix
│
├── hyprpaper/
│   ├── hyprpaper.conf
│   └── hyprpaper.nix
│
├── theme/
│   └── theme.nix
│
└── wallpapers/
└── f1.png
```
## Theming

To maintain a consistent look and feel, all colours are defined in a central `theme/theme.nix` file. This file is passed as a special argument to all modules, allowing applications like Hyprland, Waybar, and Kitty to share the same colour palette. To change the entire desktop theme, you only need to edit this one file.

## Installation

This configuration is managed by Nix Flakes. To apply it to a new or existing NixOS system:

1.  Clone this repository to your machine (e.g., into `~/nixos-config`).
2.  Navigate into the directory.
3.  Run the rebuild command, pointing it to the correct flake output:

```bash
sudo nixos-rebuild switch --flake .#larry-desktop

## Acknowledgements

This configuration would not be possible without the incredible documentation and community support from:

* The [NixOS Wiki](https://nixos.wiki/)
* The [Hyprland Wiki](https://wiki.hyprland.org/)
* The amazing people on various Nix and Linux subreddits who have unknowingly answered my frantic search queries.
