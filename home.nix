{ pkgs, config, hostConfig, ... }:
  let
    dotfiles-update = pkgs.writeShellScriptBin "dotfiles-update" ''
      DIR="${config.home.homeDirectory}/dotfiles"
      HOST="${hostConfig.host}"
      ${builtins.readFile ./scripts/dotfiles-update}
    '';
  in
  {
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
    };
    programs.neovim.enable = false;
    programs.direnv.enable = true;
    programs.zoxide.enable = true;

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
