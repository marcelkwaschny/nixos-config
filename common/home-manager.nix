{ config, pkgs, ... }:

{
  # imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];

  home.stateVersion = "24.11";
  
  targets.genericLinux.enable = true;

  home.username = "mk";
  home.homeDirectory = "/home/mk";

  programs.git.enable = true;
  programs.zsh.enable = true;

  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
    ];
  };

  # programs.hyprpanel = {
    # enable = true;
    # systemd.enable = true;
  # };

  home.packages = with pkgs; [
    pkgs.obsidian
    pkgs.nextcloud-client
  ];
  
  services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  };
  
  systemd.user.services.nextcloud-client = {
    Unit = {
      After = pkgs.lib.mkForce "graphical-session.target"; 
    };
  };
}