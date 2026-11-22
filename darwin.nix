{ pkgs, hostConfig, ... }:
{
  imports = [ ./macos.nix ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = 6;
  system.primaryUser = hostConfig.username;
  users.users.${hostConfig.username}.home = hostConfig.homeDirectory;

  security.pam.services.sudo_local.touchIdAuth = true;

  environment.systemPackages = [ pkgs.utm ];

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
    brews = [
      "mingw-w64"
    ];
    casks = [
      "firefox"
      "ghostty"
      "lulu"
      "mullvad-vpn"
      "proton-pass"
      "rode-connect"
    ];
  };
}
