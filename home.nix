{ pkgs, config, ... }:

let
  hostname = builtins.getEnv "HOSTNAME";
  hostConfig = import ./hosts/${hostname}.nix;
in
  {
    home.username = hostConfig.username;
    home.homeDirectory = hostConfig.homeDirectory;
    home.stateVersion = "24.05";
    
    home.packages = with pkgs; [
      awscli2
      fd
      fzf
      htop
      jq
      nodejs
      neofetch
      opam
      luarocks
      lua
      nodePackages.prettier
      nodePackages.eslint
      nodePackages.eslint_d
      ripgrep
      rustup
      scc
      skhd
      tldr
      thefuck
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
      ".config/sketchybar" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/sketchybar";
      };
      ".zshrc".source = ./zshrc;
      ".config/skhd/skhdrc".source = ./skhdrc;
    };
  
    programs.home-manager.enable = true;
    programs.git = {
      enable = true;
      userName = hostConfig.git_username;
      userEmail = hostConfig.git_useremail;
    };
    programs.neovim.enable = true;
    programs.wezterm.enable = true;
    programs.direnv.enable = true;
    programs.zoxide.enable = true;
  }
