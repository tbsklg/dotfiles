{ pkgs, hostConfig, ... }:
{
  nixpkgs.hostPlatform = "aarch64-darwin";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = 6;
  system.primaryUser = hostConfig.username;
  users.users.${hostConfig.username}.home = hostConfig.homeDirectory;

  fonts.packages = [ pkgs.nerd-fonts.hack ];

  nix-homebrew = {
    enable = true;
    user = hostConfig.username;
    autoMigrate = true;
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "none";
    };
    taps = [ "tbsklg/tap" ];
    brews = [
      "mingw-w64"
      "tbsklg/tap/zandy"
      "tbsklg/tap/zoidc"
    ];
    casks = [
      "ghostty"
      "google-chrome"
      "quarto"
    ];
  };
}
