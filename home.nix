{ pkgs, config, hostConfig, ... }:
  {
    home.username = hostConfig.username;
    home.homeDirectory = hostConfig.homeDirectory;
    home.stateVersion = "24.05";
    
    home.packages = with pkgs; [
      awscli2
      colima
      docker-client
      docker-compose
      dig
      fd
      fzf
      htop
      jq
      nodejs_24
      fastfetch
      neovim
      luarocks
      lua
      prettier
      eslint
      eslint_d
      ripgrep
      rustup
      scc
      skhd
      tldr
      wget
      yabai
      zoxide
    ];
    
    home.file = {
      ".config/nvim" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/nvim";
      };
      ".wezterm.lua" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.wezterm.lua";
      };
      ".zshrc".source = ./zshrc;
      ".config/skhd/skhdrc".source = ./skhdrc;
      ".config/ghostty/config" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.ghostty.config";
      };
    } // pkgs.lib.optionalAttrs (hostConfig.opencode or false) {
      # Requires `opencode = true;` in the host config (e.g. hosts/private.nix)
      ".config/opencode/opencode.json" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/opencode/opencode.json";
      };
      ".config/opencode/tui.json" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/opencode/tui.json";
      };
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
  }
