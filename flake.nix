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
  };

  outputs = { self, nixpkgs, home-manager, hyprpanel, ... }@inputs: {
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

    };
  };
}
