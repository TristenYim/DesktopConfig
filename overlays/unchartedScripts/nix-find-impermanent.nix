{ pkgs, ... }: pkgs.writeShellScriptBin 
    "nix-find-impermanent"
    ''
        #!/run/current-system/sw/bin/bash
        fd --one-file-system --base-directory / --type f --hidden --exclude "{tmp,.cache,$@}"
    ''
