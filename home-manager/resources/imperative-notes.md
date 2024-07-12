# Nix is Imperative!

Although __NixOS__ is a mostly __declarative__ language, __Nix__ the package manager, is __imperative__. This goes against the goals of this repo and is a real bummer. Luckily, __Home Manager__, which can manage configuration files and package versions, is __declarative__ like NixOS. However, its control of the OS is limited. Some operations will have to be managed imperatively outside of NixOS machines because of this. There are also some operations that may be possible to manage declaratively that I have not learned how to do yet (For example, creating additional symlinks to my CSS color pallete).

In any case, here is a list operations I have yet to implement declaratively. Imperative options specific to NixOS will be listed in another file.

# Imperative List:
 - Install Nix. This should be self-evident. See https://nixos.org
 - Initially install Home Manager. This can be done declaratively in NixOS, but not with Nix. However, Home Manager can declaratively manage itself __after__ install. See https://nix-community.github.io/home-manager/
 - Install and manage hyprland. Currently, installing hyprland using home-manager breaks outside of NixOS
 - Install swaylock-effects. This is impossible to do inside Home Manager since it require password authentication
