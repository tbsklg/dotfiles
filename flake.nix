{
  description = "nix-darwin + home-manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nix-darwin, home-manager, nix-homebrew, firefox-addons, ... }:
    let
      mkDarwin = hostConfig: nix-darwin.lib.darwinSystem {
        specialArgs = { inherit hostConfig; };
        modules = [
          ./darwin.nix
          nix-homebrew.darwinModules.nix-homebrew
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "before-home-manager";
              extraSpecialArgs = { inherit hostConfig firefox-addons; };
              users.${hostConfig.username} = import ./home.nix;
            };
          }
        ];
      };
    in {
      darwinConfigurations.private = mkDarwin (import ./hosts/private.nix);
      darwinConfigurations.work = mkDarwin (import ./hosts/work.nix);
    };
}
