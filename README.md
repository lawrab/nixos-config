# NixOS & Hyprland Configuration: A Declarative Desktop

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![NixOS Channel: Unstable](https://img.shields.io/badge/NixOS-unstable-blue.svg)](https://nixos.org/channels/nixos-unstable)
[![Built with Nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

This repository contains my personal NixOS configuration for a modern desktop environment, centered around the Hyprland Wayland compositor. I'm by no means an expert, and this configuration is very much a work in progress as I learn more about NixOS. I'm sharing it in the hope that it might be useful to others who are also on their Nix journey.

This configuration is a practical example of how to build a fully reproducible desktop system using NixOS and Nix Flakes, making it an ideal starting point for both new and experienced Nix users.

![Screenshot of the Hyprland desktop with Waybar and Kitty terminal.](screenshots/hyprlan-layout.png)

## Core Philosophy

- **Declarative & Reproducible**: Every aspect of the system, from the window manager to application settings, is defined in code. This allows for perfect reproducibility and easy system rollbacks.
- **Clean & Minimalist Aesthetic**: The theme is designed to be easy on the eyes, with a consistent dark palette and a focus on clarity.
- **Pragmatic & Productive**: The chosen tools and keybindings are optimized for a fast and efficient development workflow.

## Key Features

- **Operating System**: [NixOS](https://nixos.org/) (Unstable channel for the latest packages)
- **Window Manager**: [Hyprland](https://hyprland.org/) - A dynamic tiling Wayland compositor with fluid animations and extensive customization.
- **Terminal**: [Kitty](https://sw.kovidgoyal.net/kitty/) - A fast, feature-rich, GPU-accelerated terminal emulator.
- **Shell**: [Zsh](https://www.zsh.org/) with [Oh My Zsh](https://ohmyz.sh/) for plugin management and the [Starship](https://starship.rs/) prompt for a rich, context-aware command line.
- **Application Launcher**: [Wofi](https://hg.sr.ht/~scoopta/wofi) - A versatile and speedy launcher for Wayland.
- **Status Bar**: [Waybar](https://github.com/Alexays/Waybar) - A highly customizable status bar for Wayland compositors.
- **Text Editor**: [Visual Studio Code](https://code.visualstudio.com/) with settings managed declaratively.
- **Theming**: A unified, centrally-managed dark theme (`theme.nix`) ensures a consistent look and feel across GTK applications, Kitty, and Waybar.

## Getting Started: A Fresh Installation Guide

This guide will walk you through deploying this configuration on a new NixOS system.

### Prerequisites

- A machine with a fresh installation of NixOS. You can find the official installation instructions on the [NixOS website](https://nixos.org/download.html).
- Git installed (`nix-shell -p git`).
- A stable internet connection.

### Installation

There are two primary methods for applying this configuration. The first is recommended for its convenience.

#### Option 1: Symlinking the Configuration (Recommended)

This method involves cloning the repository and creating a symbolic link from `/etc/nixos` to your cloned directory. This makes your cloned repository the system's source of truth, allowing you to run `nixos-rebuild` without any extra flags.

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/lrabbets/nixos-config.git ~/nixos-config
    ```

2.  **Backup your existing configuration:**

    It's always a good practice to back up the default configuration generated during installation.

    ```bash
    sudo mv /etc/nixos /etc/nixos.bak
    ```

3.  **Create the symbolic link:**

    ```bash
    sudo ln -s ~/nixos-config /etc/nixos
    ```

4.  **Rebuild the system:**

    This command will evaluate your new configuration and build the new system generation.

    ```bash
    sudo nixos-rebuild switch
    ```

#### Option 2: Using the `--flake` Flag

If you prefer to keep your configuration in a different location without symlinking, you can use the `--flake` flag to point the rebuild command to your configuration's location.

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/lrabbets/nixos-config.git ~/nixos-config
    ```

2.  **Rebuild the system:**

    The `#larry-desktop` at the end specifies which `nixosConfiguration` to build from your `flake.nix` file.

    ```bash
    sudo nixos-rebuild switch --flake ~/nixos-config#larry-desktop
    ```

### Post-Installation

After the rebuild is complete, you will be greeted by a textual login prompt (greetd). Simply enter your username and password to log in to your new Hyprland desktop.

## Configuration Structure

The repository is organized to promote modularity and separation of concerns:

```
.
├── flake.nix         # Main entry point for the Nix flake
├── configuration.nix   # System-level configuration
├── home.nix            # Home-Manager entry point
├── theme/              # Centralized theme definition
├── home/               # User-level package and application configs
└── ...
```

-   `flake.nix`: Defines the flake's inputs (Nixpkgs, Home-Manager) and outputs (the NixOS configuration).
-   `configuration.nix`: Manages system-wide settings like the bootloader, networking, users, and system services.
-   `home.nix`: The central hub for [Home-Manager](https://github.com/nix-community/home-manager), which manages user-level packages and dotfiles.
-   `home/`: Contains individual modules for configuring specific applications and tools (e.g., `kitty.nix`, `waybar.nix`).
-   `theme/theme.nix`: A central file defining the color palette used throughout the entire system.

## Customization

One of the key benefits of this setup is the ease of customization.

-   **Changing Colors**: To change the entire system's color scheme, you only need to edit the values in `theme/theme.nix`. All other configuration files reference this single source of truth.
-   **Adding Packages**: To install new packages for your user, simply add them to the list in `home/packages.nix`.
-   **Modifying Keybindings**: Hyprland's keybindings are defined in `home/hyprland.nix`. You can easily add or change them there.

## License

This configuration is released under the MIT License. See the [LICENSE](LICENSE) file for more details.