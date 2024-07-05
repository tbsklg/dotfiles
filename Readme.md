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
To use these dotfiles, clone this repository and run the following command:
```bash
home-manager switch -f home.nix
```

