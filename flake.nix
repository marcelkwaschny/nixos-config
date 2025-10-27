{
  description = "My NixOS configuration using flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprpanel = {
      url = "github:jas-singhfsu/hyprpanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, hyprpanel, nix-vscode-extensions, ... }@inputs: {

    nixosConfigurations = {
      vm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        # specialArgs = { hyprpanelInput = inputs.hyprpanel; };
        modules = [
          {
            nixpkgs.overlays = [inputs.hyprpanel.overlay ];
          }
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = {
              hyprpanelInput = inputs.hyprpanel;
            };
            home-manager.users.mk = import ./vm/home.nix;
          }
          ./vm/configuration.nix
        ];
      };

      # Available through 'nixos-rebuild switch --flake .#work-vm'
      work-vm = nixpkgs.lib.nixosSystem {
        modules = [
          {
            nixpkgs.overlays = [inputs.nix-vscode-extensions.overlays.default];
          }
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.mk = import work-vm/home.nix;
          }
          work-vm/configuration.nix
        ];
      };

    };
  };
}
