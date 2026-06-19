# Dotfiles

Nix flake + home-manager configuration for macOS (aarch64-darwin).

## Requirements

Install Nix:
```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```

Enable flakes in `~/.config/nix/nix.conf` or `/etc/nix/nix.conf`:
```
experimental-features = nix-command flakes
```

## Usage

Clone this repository and create a host config in `hosts/` (see `hosts/example.nix`).
Then add a matching `homeConfigurations.<name>` entry in `flake.nix` that imports your host config via `extraSpecialArgs`.

```bash
home-manager switch --flake .#<name>
```

## Updates

```bash
nix flake update
home-manager switch --flake .#work
```

## Rollbacks

```bash
home-manager generations
/nix/store/<generation-path>/activate
```
