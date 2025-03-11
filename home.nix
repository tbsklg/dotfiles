{ pkgs, config, ... }:

{
  home.username = "tbsklg";
  home.homeDirectory = "/users/tbsklg";
  home.stateVersion = "24.05";
  
  home.packages = with pkgs; [
    awscli
    fd
    fzf
    nodejs
    opam
    luarocks
    lua
    nodePackages.prettier
    nodePackages.eslint
    nodePackages.eslint_d
    ripgrep
    rustup
    sketchybar
    tldr
    wget
  ];
  
  home.file = {
    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "/users/tbsklg/dotfiles/config/nvim";
    };
    ".wezterm.lua" = {
      source = config.lib.file.mkOutOfStoreSymlink "/users/tbsklg/dotfiles/.wezterm.lua";
    };
    ".config/sketchybar" = {
      source = config.lib.file.mkOutOfStoreSymlink "/users/tbsklg/dotfiles/sketchybar";
    };
  };

  launchd.agents.sketchybar = {
    enable = true;
    config = {
      Label = "sketchybar";
      ProgramArguments = [
        "${pkgs.sketchybar}/bin/sketchybar"
      ];
      RunAtLoad = true;
      KeepAlive = true;
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
  programs.direnv.enable = true;
}
