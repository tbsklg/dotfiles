{ pkgs, lib, config, hostConfig, ... }:
  let
    dotfiles-update = pkgs.writeShellScriptBin "dotfiles-update" ''
      DIR="${config.home.homeDirectory}/dotfiles"
      HOST="${hostConfig.host}"
      ${builtins.readFile ./scripts/dotfiles-update}
    '';
    wallpaper = pkgs.runCommand "wallpaper-black.png" { nativeBuildInputs = [ pkgs.imagemagick ]; } ''
      magick -size 64x64 xc:black $out
    '';
  in
  {
    home.activation.wallpaper = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      run ${pkgs.desktoppr}/bin/desktoppr ${wallpaper} || true
    '';

    home.username = hostConfig.username;
    home.homeDirectory = hostConfig.homeDirectory;
    home.stateVersion = "24.05";

    home.packages = with pkgs; [
      awscli2
      ssm-session-manager-plugin
      colima
      docker-client
      docker-compose
      dig
      fd
      fzf
      glab
      htop
      jq
      tree
      nodejs_24
      fastfetch
      neovim
      tree-sitter
      luarocks
      lua
      prettier
      eslint
      eslint_d
      picocom
      ripgrep
      rustup
      scc
      tldr
      wget
      zig_0_17
      go
      gopls
      goimports-reviser
      golangci-lint
      maven
      exercism
      mob
      dotfiles-update
    ] ++ pkgs.lib.optionals (hostConfig.kopia or false) [
      kopia
    ];

    home.file = {
      ".config/nvim" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/nvim";
      };
      ".config/ghostty/config" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.ghostty.config";
      };
    } // pkgs.lib.optionalAttrs (hostConfig.kopia or false) {
      ".kopiaignore" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/kopiaignore";
      };
    } // pkgs.lib.optionalAttrs (hostConfig.opencode or false) {
      ".config/opencode/opencode.json" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/opencode/opencode.json";
      };
      ".config/opencode/tui.json" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/opencode/tui.json";
      };
    };

    home.sessionVariables = {
      LANG = "en_US.UTF-8";
      NPM_CONFIG_PREFIX = "${config.home.homeDirectory}/.npm-global";
    };
    home.sessionPath = [
      "$HOME/bin"
      "$HOME/.local/bin"
      "$HOME/.luarocks/bin"
      "$HOME/.npm-global/bin"
    ];

    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "";
        plugins = [ "git" "brew" "web-search" ];
      };
      shellAliases = {
        v = "nvim";
        sso-login = "$HOME/.aws/bin/sso-login";
        rebuild = "sudo darwin-rebuild switch --flake ~/dotfiles#${hostConfig.host}";
      };
      profileExtra = ''
        [ -x /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
      '';
      initContent = ''
        fpath+=(${pkgs.pure-prompt}/share/zsh/site-functions)
        PURE_PROMPT_SYMBOL=' λ'
        autoload -U promptinit; promptinit
        prompt pure
        prompt_newline=""

        [ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"
        [ -s "$HOME/.luaver/luaver" ] && . "$HOME/.luaver/luaver"
        [[ ! -r "$HOME/.opam/opam-init/init.zsh" ]] || source "$HOME/.opam/opam-init/init.zsh" > /dev/null 2> /dev/null

        zle-line-init() { echo -ne '\e[1 q' }
        zle -N zle-line-init
      '';
    };

    programs.home-manager.enable = true;
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = hostConfig.git_username;
          email = hostConfig.git_useremail;
        };
      };
      includes = [
        {
          condition = "gitdir:~/dotfiles/";
          contents.user = {
            name = "tbsklg";
            email = "tbs.klg@gmail.com";
          };
        }
      ];
    };
    programs.neovim.enable = false;
    programs.direnv.enable = true;
    programs.zoxide.enable = true;

    programs.firefox = {
      enable = true;
      package = null;
      profiles.default-release = {
        isDefault = true;
        search = {
          default = "ddg";
          force = true;
        };
        settings = {
          "sidebar.revamp" = true;
          "sidebar.verticalTabs" = true;
          "sidebar.main.tools" = "{3c078156-979c-498b-8990-85f7987dd929},bookmarks,passwords";
          "browser.toolbars.bookmarks.visibility" = "never";
          "browser.tabs.inTitlebar" = 1;
          "browser.theme.toolbar-theme" = 0;
          "browser.uiCustomization.state" = builtins.toJSON {
            placements = {
              widget-overflow-fixed-list = [ "fxa-toolbar-menu-button" ];
              unified-extensions-area = [
                "firefoxcolor_mozilla_com-browser-action"
                "_d634138d-c276-4fc8-924b-40a0ea21d284_-browser-action"
                "_20a9bb38-ed7c-4faf-9aaf-7c5d241fd747_-browser-action"
                "tranquility_ushnisha_com-browser-action"
                "_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action"
                "addon_darkreader_org-browser-action"
                "ublock0_raymondhill_net-browser-action"
                "_a9c2ad37-e940-4892-8dce-cd73c6cbbc0c_-browser-action"
              ];
              nav-bar = [
                "back-button"
                "forward-button"
                "stop-reload-button"
                "urlbar-container"
                "panic-button"
                "smartwindow-group-tabs-button"
                "unified-extensions-button"
                "downloads-button"
                "vertical-spacer"
                "_testpilot-containers-browser-action"
              ];
              TabsToolbar = [ ];
              vertical-tabs = [ "tabbrowser-tabs" ];
              PersonalToolbar = [ "personal-bookmarks" ];
            };
            seen = [
              "save-to-pocket-button"
              "developer-button"
              "firefoxcolor_mozilla_com-browser-action"
              "ublock0_raymondhill_net-browser-action"
              "_3c078156-979c-498b-8990-85f7987dd929_-browser-action"
              "_d634138d-c276-4fc8-924b-40a0ea21d284_-browser-action"
              "_20a9bb38-ed7c-4faf-9aaf-7c5d241fd747_-browser-action"
              "addon_darkreader_org-browser-action"
              "screenshot-button"
              "_a9c2ad37-e940-4892-8dce-cd73c6cbbc0c_-browser-action"
              "reset-pbm-toolbar-button"
              "ipprotection-button"
              "ai-window-toggle"
              "tranquility_ushnisha_com-browser-action"
              "smartwindow-group-tabs-button"
              "_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action"
              "_testpilot-containers-browser-action"
            ];
            dirtyAreaCache = [
              "nav-bar"
              "PersonalToolbar"
              "TabsToolbar"
              "unified-extensions-area"
              "vertical-tabs"
              "widget-overflow-fixed-list"
            ];
            currentVersion = 28;
            newElementCount = 8;
          };

          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.showSponsoredCheckboxes" = false;
          "browser.newtabpage.activity-stream.widgets.clocks.enabled" = false;
          "browser.newtabpage.activity-stream.widgets.lists.enabled" = false;
          "browser.newtabpage.activity-stream.widgets.weather.enabled" = false;
          "browser.newtabpage.activity-stream.newtabWallpapers.wallpaper" = "firefox-d-dark";

          "privacy.donottrackheader.enabled" = true;
          "privacy.globalprivacycontrol.enabled" = true;
          "network.dns.disablePrefetch" = true;
          "network.prefetch-next" = false;
          "network.http.speculative-parallel-limit" = 0;
          "signon.rememberSignons" = false;

          "font.name.serif.x-western" = "Hack Nerd Font";
          "font.size.variable.x-western" = 14;
          "browser.zoom.full" = false;
          "accessibility.typeaheadfind.flashBar" = 0;
          "browser.bookmarks.showMobileBookmarks" = false;
        };
      };
    };

    launchd.agents.dotfiles-update-check = {
      enable = true;
      config = {
        ProgramArguments = [ "${dotfiles-update}/bin/dotfiles-update" "check" ];
        StartCalendarInterval = [ { Hour = 9; Minute = 0; } ];
        StandardOutPath = "${config.home.homeDirectory}/Library/Logs/dotfiles-update.log";
        StandardErrorPath = "${config.home.homeDirectory}/Library/Logs/dotfiles-update.log";
      };
    };
  }
