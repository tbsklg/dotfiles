{ pkgs, hostConfig, ... }:
{
  nixpkgs.hostPlatform = "aarch64-darwin";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = 6;
  system.primaryUser = hostConfig.username;

  system.keyboard = {
    enableKeyMapping = true;
    userKeyMapping = [
      { HIDKeyboardModifierMappingSrc = 30064771296; HIDKeyboardModifierMappingDst = 30064771129; }
      { HIDKeyboardModifierMappingSrc = 30064771129; HIDKeyboardModifierMappingDst = 30064771300; }
      { HIDKeyboardModifierMappingSrc = 30064771300; HIDKeyboardModifierMappingDst = 30064771129; }
    ];
  };

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
