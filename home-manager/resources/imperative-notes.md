# Nix is Imperative!

Although __NixOS__ is a mostly __declarative__ language, __Nix__ the package manager, is __imperative__. This goes against the goals of this repo and is a real bummer. Luckily, __Home Manager__, which can manage configuration files and package versions, is __declarative__ like NixOS. However, its control of the OS is limited. Some operations will have to be managed imperatively outside of NixOS machines because of this. Even in NixOS, some options may not make sense to declare (such as __logging into accounts__ and __setting passwords__)

In any case, here is a list operations I have yet to implement declaratively. Imperative options specific to NixOS will be listed in another file.

# Outside NixOS:
 - Install Nix. This should be self-evident. See https://nixos.org
 - Initially install Home Manager. This can be done declaratively in NixOS, but not with Nix. However, Home Manager can declaratively manage itself __after__ install. See https://nix-community.github.io/home-manager/
 - Install and manage hyprland (if the Home Manager module is broken) Currently, installing hyprland using home-manager breaks outside of NixOS
 - Install NerdFonts. These glyphs are used all throughout my DE
 - Install swaylock-effects. This is impossible to do inside Home Manager since it require password authentication
 - Install Thunar. This must be configured using a NixOS module, so it is not installed with home manager

# Only NixOS
 - Declare user passwords (locally)

# Everywhere
 - Download Merienda. This is required to make my DE work and cannot be easily declared
 - Login to accounts. Declaring this would defeat the point of having login protection
 - Configure apps which must be persisted. Generally, if an app is persisted, it's because it stores data that cannot be easily configured with Nix
