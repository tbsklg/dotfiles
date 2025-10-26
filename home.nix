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
      cargo-lambda
      docker
      fd
      fzf
      htop
      jq
      nodejs_24
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
    programs.neovim.enable = true;
    programs.direnv.enable = true;
    programs.zoxide.enable = true;
  }
