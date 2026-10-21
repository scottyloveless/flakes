{
  description = "Multi-host NixOS + macOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lazyvim.url = "github:pfassina/lazyvim-nix";
    # noctalia = {
    # url = "github:noctalia-dev/noctalia-shell";
    # inputs.nixpkgs.follows = "nixpkgs";
    # };
    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    acsandmann-tap = {
      url = "github:acsandmann/homebrew-tap";
      flake = false;
    };
    barutsrb-tap = {
      url = "github:BarutSRB/homebrew-tap";
      flake = false;
    };
    apple-silicon.url = "github:nix-community/nixos-apple-silicon";

    _1password-shell-plugins.url = "github:1Password/shell-plugins";

    textfox.url = "github:adriankarlen/textfox";

    nixos-hardware.url = "github:NixOS/nixos-hardware";
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      lazyvim,
      nix-darwin,
      nix-homebrew,
      homebrew-core,
      homebrew-cask,
      apple-silicon,
      nixos-hardware,
      niri,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        nixos-fusion = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";

          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/nixos-fusion/configuration.nix
            home-manager.nixosModules.home-manager
            inputs.niri.nixosModules.niri
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.mox = {
                imports = [ ./home/linux.nix ];
                home.username = "mox";
                home.homeDirectory = "/home/mox";
                home.stateVersion = "26.05";
              };
            }
          ];
        };
        beau = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";

          specialArgs = { inherit inputs; };
          modules = [
            apple-silicon.nixosModules.default
            ./hosts/beau/configuration.nix
            home-manager.nixosModules.home-manager
            inputs.niri.nixosModules.niri
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.mox = {
                imports = [
                  ./home/linux.nix
                ];
                home.username = "mox";
                home.homeDirectory = "/home/mox";
                home.stateVersion = "26.05";
              };
            }
          ];
        };
        intel-mac = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/intel-mac/configuration.nix
            nixos-hardware.nixosModules.apple-t2
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.mox = {
                imports = [
                  ./home/linux.nix
                ];
                home.username = "mox";
                home.homeDirectory = "/home/mox";
                home.stateVersion = "26.05";
              };
            }
          ];
        };

        nox = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/nox/configuration.nix
            home-manager.nixosModules.home-manager
            inputs.niri.nixosModules.niri
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.mox = {
                imports = [
                  ./home/linux.nix
                ];
                home.username = "mox";
                home.homeDirectory = "/home/mox";
                home.stateVersion = "26.05";
              };
            }
          ];
        };
        vm-workstation = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/vm-workstation/configuration.nix
            home-manager.nixosModules.home-manager
            inputs.niri.nixosModules.niri
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.mox = {
                imports = [
                  ./home/linux.nix
                ];
                home.username = "mox";
                home.homeDirectory = "/home/mox";
                home.stateVersion = "26.05";
              };
            }
          ];
        };
      };
      darwinConfigurations = {

        sandy = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/sandy/configuration.nix
            home-manager.darwinModules.home-manager
            nix-homebrew.darwinModules.nix-homebrew
            {
            }
            (
              { config, ... }:
              {
                homebrew.taps = builtins.attrNames config.nix-homebrew.taps;
              }
            )
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.mox = {
                imports = [ ./home/darwin.nix ];
                home.username = "mox";
                home.homeDirectory = "/Users/mox";
                home.stateVersion = "26.05";
              };
            }
          ];
        };

      };
    };
}
