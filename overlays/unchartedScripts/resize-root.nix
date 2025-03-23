{ pkgs, ... }: pkgs.writeShellScriptBin 
    "resize-root"
    ''
        #!/run/current-system/sw/bin/bash
        mount -o remount,size="$1" /
    ''
