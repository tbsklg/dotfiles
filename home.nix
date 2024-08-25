{ pkgs, config, ... }:

{
  home.username = "<USERNAME>";
  home.homeDirectory = "/home/<USERNAME>";
  home.stateVersion = "24.05";
  
  home.packages = with pkgs; [
    awscli
    cargo
    fd
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
    ".zshrc" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/<USERNAME>/dotfiles/config/nvim";
    };
    ".tmux.conf" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/<USERNAME>/dotfiles/.tmux.conf";
    };
    ".wezterm.lua" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/<USERNAME>/dotfiles/.wezterm.lua";
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
