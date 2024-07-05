{ pkgs, config, ... }:

{
  home.username = "parallels";
  home.homeDirectory = "/home/parallels";
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    awscli2
    cargo
    fzf
    ghc
    keepassxc
    luarocks
    lua
    mesa-demos
    nextcloud-client
    nodejs
    mob
    python3
    ripgrep
    stack
    tldr
    tmux
  ];
  
  home.file = {
    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/parallels/dotfiles/config/nvim";
    };
    ".tmux.conf" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/parallels/dotfiles/.tmux.conf";
    };
    ".wezterm.lua" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/parallels/dotfiles/.wezterm.lua";
    };
  };

  xdg.desktopEntries.${"org.wezfurlong.wezterm"} = {
    name = "WezTerm";
    comment = "Wez's Terminal Emulator";
    icon = "org.wezfurlong.wezterm";
    exec = "nixGLMesa wezterm start --cwd .";
    type = "Application";
    categories = ["System" "TerminalEmulator" "Utility"];
    terminal = false;
  };

  programs.home-manager.enable = true;
  programs.firefox.enable = true;
  programs.git = {
    enable = true;
    userName = "Tobias Klug";
    userEmail = "tbs.klg@gmail.com";
  };
  programs.neovim.enable = true;
  programs.wezterm.enable = true;
}
