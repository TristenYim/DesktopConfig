{ config, lib, ... }: 
    let
        catppuccin = (import ../theme/catppuccin-colors.nix);
    in
{
    config = lib.mkIf config.wlogout-home.enable {
        programs.wlogout.style = ''
            * {
            	background-image: none;
            }

            window {
            	background-color: alpha(${catppuccin.mantle}, 0.5);
                font-family: "Merienda";
                font-size: 32px;
            }

            button {
                color: ${catppuccin.text};
            	background-color: ${catppuccin.base};
                border-color: ${catppuccin.surface0};
            	border-style: solid;
            	border-width: 3px;
                border-radius: 80px;
                margin: 24px;
            	background-repeat: no-repeat;
            	background-position: center;
            	background-size: 25%;
            }

            button:focus, button:active, button:hover {
            	background-color: alpha(${catppuccin.sapphire}, 0.6);
                border-color: ${catppuccin.lavender};
                border-width: 3px;
                outline-style: none;
                box-shadow: 0 0 4px 0.5px alpha(${catppuccin.lavender}, 0.8);
            }

                #lock {
                    background-image: image(url("./assets/lock.png"), url("/usr/share/wlogout/icons/lock.png"), url("/usr/local/share/wlogout/icons/lock.png"));
                }

                #logout {
                    background-image: image(url("./assets/logout.png"), url("/usr/share/wlogout/icons/logout.png"), url("/usr/local/share/wlogout/icons/logout.png"));
                }

                #suspend {
                    background-image: image(url("./assets/suspend.png"), url("/usr/share/wlogout/icons/suspend.png"), url("/usr/local/share/wlogout/icons/suspend.png"));
                }

                #hibernate {
                    background-image: image(url("./assets/hibernate.png"), url("/usr/share/wlogout/icons/hibernate.png"), url("/usr/local/share/wlogout/icons/hibernate.png"));
                }

                #shutdown {
                    background-image: image(url("./assets/shutdown.png"), url("/usr/share/wlogout/icons/shutdown.png"), url("/usr/local/share/wlogout/icons/shutdown.png"));
                }

                #reboot {
                    background-image: image(url("./assets/reboot.png"), url("/usr/share/wlogout/icons/reboot.png"), url("/usr/local/share/wlogout/icons/reboot.png"));
            }
        '';
    };
}
