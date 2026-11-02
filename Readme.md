# Dotfiles

nix-darwin + home-manager configuration for macOS (aarch64-darwin).

- `flake.nix` – one `darwinConfigurations.<host>` per machine (`private`, `work`)
- `darwin.nix` – system: Nix settings, fonts, Homebrew (installed via nix-homebrew) and the few brews/casks not in nixpkgs
- `home.nix` – user: CLI packages, zsh (oh-my-zsh + pure), git, dotfile symlinks
- `hosts/*.nix` – per-host values (user, git identity, feature flags)

## New Mac

```bash
xcode-select --install          # provides git
git clone <this repo> ~/dotfiles
cd ~/dotfiles
./bootstrap.sh private          # or: work
```

`bootstrap.sh` installs Nix, then nix-darwin, which installs Homebrew, all packages, casks, fonts
and links the dotfiles. It is safe to re-run.

## Updates

```bash
nix flake update
sudo darwin-rebuild switch --flake ~/dotfiles#private
```

Note: flakes only see files tracked by git — `git add` new files before switching.

## Rollbacks

```bash
sudo darwin-rebuild --list-generations
sudo darwin-rebuild --rollback
```

## Not managed here

- `~/.aws/bin/sso-login` (aliased in zsh), SSH/GPG keys
- ghcup, luaver, opam (sourced by zsh if present)
