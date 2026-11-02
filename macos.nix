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

      "com.apple.HIToolbox" = {
        AppleCurrentKeyboardLayoutInputSourceID = "com.apple.keylayout.ABC";
        AppleEnabledInputSources = [
          { InputSourceKind = "Keyboard Layout"; "KeyboardLayout ID" = 0; "KeyboardLayout Name" = "U.S."; }
          { InputSourceKind = "Keyboard Layout"; "KeyboardLayout ID" = 252; "KeyboardLayout Name" = "ABC"; }
          { InputSourceKind = "Non Keyboard Input Method"; "Bundle ID" = "com.apple.CharacterPaletteIM"; }
          { InputSourceKind = "Non Keyboard Input Method"; "Bundle ID" = "com.apple.PressAndHold"; }
        ];
        AppleSelectedInputSources = [
          { InputSourceKind = "Non Keyboard Input Method"; "Bundle ID" = "com.apple.PressAndHold"; }
          { InputSourceKind = "Keyboard Layout"; "KeyboardLayout ID" = 252; "KeyboardLayout Name" = "ABC"; }
        ];
      };

      "com.apple.symbolichotkeys".AppleSymbolicHotKeys =
        let
          off = { enabled = false; };
          on = { enabled = true; };
        in
        {
          "15" = off; "16" = off; "17" = off; "18" = off; "19" = off; "20" = off;
          "21" = off; "22" = off; "23" = off; "24" = off; "25" = off; "26" = off;
          "164" = off // { value = { parameters = [ 65535 65535 0 ]; type = "standard"; }; };
          "60" = on // { value = { parameters = [ 32 49 262144 ]; type = "standard"; }; };
          "61" = on // { value = { parameters = [ 32 49 786432 ]; type = "standard"; }; };
          "79" = on; "80" = on; "81" = on; "82" = on;
        };

      "eu.exelban.Stats" = {
        LaunchAtLoginNext = true;
        "update-interval" = "Silent";
      };
    };
  };

  system.keyboard = {
    enableKeyMapping = true;
    userKeyMapping = [
      { HIDKeyboardModifierMappingSrc = 30064771296; HIDKeyboardModifierMappingDst = 30064771129; }
      { HIDKeyboardModifierMappingSrc = 30064771129; HIDKeyboardModifierMappingDst = 30064771300; }
      { HIDKeyboardModifierMappingSrc = 30064771300; HIDKeyboardModifierMappingDst = 30064771129; }
    ];
  };
}
