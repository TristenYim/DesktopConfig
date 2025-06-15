{ config, pkgs, lib, optnix, ... }: {

    # Set a toggle to enable alias config 
    options.apeiron.terminal = {
        alias.enable = lib.mkEnableOption "alias configuration";
    };
 
    config = lib.mkIf config.apeiron.terminal.alias.enable 
    {
        home.shellAliases = let
            # Prevents annoying git flake errors by copying the entire
            # flake (minus git files and the result symlink) to a build 
            # directory outside the repo before building.

            # $FLAKE specifies the root directory of the configuration,
            # with $FLAKE/source containing the repo for this flake and
            # $FLAKE/build containing the temporary build files
            wrapBuild = buildCommand: "rm -rf $FLAKE/build && mkdir $FLAKE/build && find $FLAKE/source -maxdepth 1 ! -name \".*\" ! -name result -exec cp -r {} $FLAKE/build \\; && ${buildCommand} --flake $FLAKE/build";
        in {
            sudo = "sudo ";
            hms = wrapBuild "home-manager switch --impure";
            nrb = wrapBuild "sudo nixos-rebuild boot";
            nrs = wrapBuild "sudo nixos-rebuild switch";
            nrt = wrapBuild "sudo nixos-rebuild test";
            ngl = "nix-env --list-generations --profile /nix/var/nix/profiles/system";
            ngd = "nix-env --delete-generations --profile /nix/var/nix/profiles/system";
            nf = "${pkgs.unchartedScripts}/bin/nix-find-impermanent";
            noh = "${optnix.packages.${pkgs.system}.optnix}/bin/optnix -i -s home";
            non = "${optnix.packages.${pkgs.system}.optnix}/bin/optnix -i -s nixos";
            rr = "${pkgs.unchartedScripts}/bin/resize-root";
        };
        programs.zsh = {
            initContent = 
            ''
                function nixShellPackages() {
                    packages=""
                    for package in "$@"; do
                        packages+=" nixpkgs#$package"
                    done
                    eval nix shell --inputs-from $FLAKE $packages
                }
            '';
            shellAliases = {
                ns = "nixShellPackages";
            };
        };
    };
}
