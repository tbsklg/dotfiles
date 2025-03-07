{ pkgs, config, ... }:

{
  home.username = "tbsklg";
  home.homeDirectory = "/users/tbsklg";
  home.stateVersion = "24.05";
  
  home.packages = with pkgs; [
    awscli
    cargo
    fd
    fzf
    go
    nodejs
    opam
    luarocks
    lua
    nodePackages.prettier
    nodePackages.eslint
    nodePackages.eslint_d
    ripgrep
    tldr
    tmux
    wget
  ];
  
  home.file = {
    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "/users/tbsklg/dotfiles/config/nvim";
    };
    ".tmux.conf" = {
      source = config.lib.file.mkOutOfStoreSymlink "/users/tbsklg/dotfiles/.tmux.conf";
    };
    ".wezterm.lua" = {
      source = config.lib.file.mkOutOfStoreSymlink "/users/tbsklg/dotfiles/.wezterm.lua";
    };
    ".config/sketchybar" = {
      source = config.lib.file.mkOutOfStoreSymlink "/users/tbsklg/dotfiles/sketchybar";
    };
  };

  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "Tobias Klug";
    userEmail = "tbs.klg@gmail.com";
  };
  programs.neovim.enable = true;
  programs.wezterm.enable = true;
}
