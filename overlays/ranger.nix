# Updates ranger to a commit on master since a bug which prevents 
# trashing files has been fixed on master but not any released 
# version.

{ ... }: { 
    nixpkgs.overlays = [(
        final: prev: {
            ranger = prev.ranger.overrideAttrs {
                version = "master-b31db0f";
                src = final.fetchFromGitHub {
                    owner = "ranger";
                    repo = "ranger";
                    rev = "b31db0f638118c103a35be5a57d1a0f3609838d6";
                    hash = "sha256-ksWlopkqD/98hwVspIRIEGCN/L/OuVlVyXftfza4LhI=";
                };
            };
        }
    )];
}
