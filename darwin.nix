{ pkgs, hostConfig, ... }:
{
  imports = [ ./macos.nix ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = 6;
  system.primaryUser = hostConfig.username;
  users.users.${hostConfig.username}.home = hostConfig.homeDirectory;

  fonts.packages = [ pkgs.nerd-fonts.hack pkgs.jetbrains-mono ];

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
      "1password"
      "babeledit"
      "burp-suite"
      "firefox"
      "ghostty"
      "google-chrome"
      "google-drive"
      "kicad"
      "logitech-g-hub"
      "lulu"
      "microsoft-teams"
      "miro"
      "mullvad-vpn"
      "quarto"
      "rnote"
      "rode-connect"
      "snapmaker-luban"
      "stats"
      "utm"
      "zoom"
    ];
  };
}
