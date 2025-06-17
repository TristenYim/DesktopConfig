{ pkgs, ... }: pkgs.writeShellScriptBin 
    "nix-shell-from-nixpkgs"
    ''
        #!/run/current-system/sw/bin/bash
        flake=$1
        shift
        packages=""
        for package in "$@"; do
            packages+=" nixpkgs#$package"
        done
        eval nix shell --inputs-from $flake $packages
    ''
