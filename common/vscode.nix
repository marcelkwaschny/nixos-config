{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    profiles.default = {
      extensions = with pkgs.vscode-marketplace; [
        jnoortheen.nix-ide
        ms-python.python
        njpwerner.autodocstring
        ms-azuretools.vscode-containers
      ];

      userSettings = {
        "workbench.colorTheme" = "Tomorrow Night Blue";
      };

      keybindings = [
        {
          key = "strg+[Semicolon]";
          command = "workbench.action.terminal.new";
        }
      ];
    };
  };
}