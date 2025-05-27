{ config, pkgs, hyprpanelInput, ... }:

{
  imports = [
    ../common/hyprpanel.nix
    ../common/vscode.nix
    ../common/zsh.nix
  ];

  home = {
    stateVersion = "24.11";

    username = "mk";
    homeDirectory = "/home/mk";
  };

  programs.home-manager.enable = true;
}