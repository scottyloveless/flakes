{
    description = "Multi-host NixOS + macOS config";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
          };

        hyprland.url = "github:hyprwm/Hyprland";
      };

      outputs = { self, nixpkgs, home-manager, hyprland, ... }: {
        nixosConfigurations = {
          nixos-fusion = nixpkgs.lib.nixosSystem {
            system = "aarch64-linux";
            modules = [
              ./hosts/nixos-fusion/configuration.nix
              home-manager.nixosModules.homeManager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.mox = import ./home;
              }
            ];
            };
          };
      };
  }
