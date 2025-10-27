{ config, pkgs, ... }:

{
  imports = [
    ../common/git.nix
    ../common/vscode.nix
    ../common/nextcloud-client.nix
    ../common/zsh.nix
  ];

  home = {
    stateVersion = "25.05";

    username = "mk";
    homeDirectory = "/home/mk";

    packages = with pkgs; [
      firefox
      kdePackages.kate
      nextcloud-client
    ];
  };

  programs.home-manager.enable = true;
}