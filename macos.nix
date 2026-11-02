{ ... }:
{
  system.defaults = {
    dock = {
      autohide = true;
      orientation = "right";
      tilesize = 43;
      magnification = false;
      launchanim = false;
      mineffect = "genie";
      persistent-apps = [
        "/System/Applications/System Settings.app"
        "/Applications/Firefox.app"
      ];
      wvous-br-corner = 14;
    };

    finder = {
      FXPreferredViewStyle = "Nlsv";
      ShowExternalHardDrivesOnDesktop = true;
      ShowHardDrivesOnDesktop = false;
      ShowRemovableMediaOnDesktop = true;
    };

    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleShowScrollBars = "Automatic";
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      "com.apple.keyboard.fnState" = true;
      "com.apple.swipescrolldirection" = false;
      _HIHideMenuBar = false;
    };

    ".GlobalPreferences"."com.apple.mouse.scaling" = 1.5;

    trackpad = {
      Clicking = false;
      TrackpadRightClick = true;
      TrackpadThreeFingerDrag = false;
    };

    menuExtraClock = {
      ShowAMPM = true;
      ShowDate = 0;
      ShowDayOfWeek = true;
    };

    screencapture.target = "file";

    WindowManager = {
      EnableTiledWindowMargins = false;
      HideDesktop = true;
    };

    CustomUserPreferences = {
      NSGlobalDomain = {
        AppleAccentColor = -1;
        AppleAquaColorVariant = 6;
        AppleIconAppearanceTintColor = "Graphite";
      };
      "com.apple.controlcenter".AutoHideMenuBarOption = 3;
    };
  };
}
