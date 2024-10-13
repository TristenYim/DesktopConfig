# Not Everything Can Be Declared!

Although __NixOS__ is based on a __declarative__ package manager, not everything makes sense to declare, such as passwords. Additionally, outside __NixOS__, many programs cannot be installed or configured using __Home Manager__.

Here is a list operations I cannot or I have yet to implement declaratively:

# Outside NixOS
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
 - Install neovim spellcheck files. This should happen automatically on first launch, so there's no need to worry about it afterwords
 - Login to accounts. Declaring this would defeat the point of having login protection
 - Configure apps which must be persisted. Generally, if an app is persisted, it's because it stores data that cannot be easily configured with Nix
