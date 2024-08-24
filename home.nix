{ pkgs, config, ... }:

{
  home.username = "<USERNAME>";
  home.homeDirectory = "/users/<USERNAME>";
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
      source = config.lib.file.mkOutOfStoreSymlink "/users/<USERNAME>/dotfiles/config/nvim";
    };
    ".tmux.conf" = {
      source = config.lib.file.mkOutOfStoreSymlink "/users/<USERNAME>/dotfiles/.tmux.conf";
    };
    ".wezterm.lua" = {
      source = config.lib.file.mkOutOfStoreSymlink "/users/<USERNAME>/dotfiles/.wezterm.lua";
    };
  };

  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "Tobias Klug";
    userEmail = "<GIT-EMAIL>";
  };
  programs.neovim.enable = true;
  programs.wezterm.enable = true;
}
