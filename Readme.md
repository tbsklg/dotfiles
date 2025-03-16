# Dotfiles
This repository contains my dotfiles. It uses nix and home-manager to manage these.

# Requirements
Install nix package manager
```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```

Install home-manager
```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

If you are not using NixOS, add the following to nix.conf (located at ~/.config/nix/ or /etc/nix/nix.conf)
```bash
experimental-features = nix-command flakes
```
Install nixGL on aarch64
```bash
nix-channel --add https://github.com/guibou/nixGL/archive/main.tar.gz nixgl
nix-channel --update
nix-env -i -E '(_: with import <nixgl> { enable32bits = false; }; nixGLMesa)'
```

# Usage
Clone this repository to the home directory.
Install oh-my-zsh:
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Create a host config file in the hosts directory (see hosts/example.nix) and run:

```bash
HOSTNAME=example home-manager switch -f home.nix
```

# Brew installs
Some packages are installed using brew. To install brew, run the following command:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Packages installed using brew:
```bash
brew install --cask wezterm
brew install fzf
```
