{ config, pkgs, hyprpanelInput, ... }:

{
  imports = [ hyprpanelInput.homeManagerModules.hyprpanel ];

  programs.hyprpanel = {
    enable = true;
    systemd.enable = true;

    settings = {
      theme.font.size = "0.9rem";
      theme.bar.floating = true;

      layout = {
        "bar.layouts" = {
          "*" = {
            "left" = [ "dashboard" "workspaces" "windowtitle"];
            "middle" = [ "media" ];
            "right" = [ "systray" "volume" "network" "clock" "notifications" ]; 
          };
        };
      };
    };
  };
}