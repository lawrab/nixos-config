{...}:

{
    environment.sessionVariables = {
        MOZ_ENABLE_WAYLAND = 1; # Hint firefox to use wayland
        NIXOS_OZONE_WL = 1;     # Hint electron apps to use wayland
    };
}