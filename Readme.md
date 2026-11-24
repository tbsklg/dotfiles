# Dotfiles

nix-darwin + standalone home-manager configuration for macOS (aarch64-darwin).

- `flake.nix` – per machine (`private`, `work`):
  - `homeConfigurations.<host>` – user setup, applied without sudo (daily)
  - `darwinConfigurations.<host>` – system setup, needs sudo (bootstrap, rare changes)
  - `darwinConfigurations.<host>-macos` – system setup + macOS UI settings (manual)
- `home.nix` – user: CLI packages, zsh (oh-my-zsh + pure), git, Firefox, dotfile symlinks
- `darwin.nix` – system: Nix settings, fonts, Touch ID sudo, keyboard remap, Homebrew (via nix-homebrew) and the few brews/casks not in nixpkgs
- `macos.nix` – Dock, Finder, defaults, wallpaper; only applied via `<host>-macos`
- `hosts/*.nix` – per-host values (user, git identity, feature flags)

## New Mac

1. Install the Command Line Tools (provides git):
   ```bash
   xcode-select --install
   ```
2. Clone the repo (needs HTTPS credentials or an SSH key if it is private):
   ```bash
   git clone <this repo> ~/dotfiles
   ```
3. Run the bootstrap:
   ```bash
   cd ~/dotfiles
   ./bootstrap.sh work
   ```
4. Open a new terminal.
5. Optionally apply the macOS settings (see below).
6. Set up what is not managed here (see below).

`bootstrap.sh` installs Nix, runs the first nix-darwin switch (Homebrew, casks, fonts, `/etc` files)
and the first home-manager switch (packages, dotfiles). It is safe to re-run.

If the macOS username differs from the one in `hosts/<host>.nix`, update `username` and `homeDirectory` first.

## Migrating from the nix-darwin home-manager module

On a Mac where home-manager still runs inside `darwin-rebuild`, switch home first so packages never disappear:

```bash
cd ~/dotfiles
nix run .#home-manager -- switch --flake .#work -b before-home-manager
sudo darwin-rebuild switch --flake .#work
```

`-b before-home-manager` is only needed this once; it renames files the old setup created instead of failing.
Open a new terminal and check that `which jq` resolves to `~/.nix-profile/bin/jq`.

## Daily updates (no sudo)

```bash
nix flake update --flake ~/dotfiles
home-manager switch --flake ~/dotfiles#work
brew upgrade            # casks/brews are not upgraded by darwin-rebuild
nvim "+Lazy! sync" +qa  # Neovim plugins
```

Commit `flake.lock` and `config/nvim/lazy-lock.json` afterwards.

## System changes (sudo)

After editing `darwin.nix`:

```bash
sudo darwin-rebuild switch --flake ~/dotfiles#work
```

macOS settings (`macos.nix`) are only applied when you ask for them:

```bash
sudo darwin-rebuild switch --flake ~/dotfiles#work-macos
```

Note: flakes only see files tracked by git — `git add` new files before switching.

## Rollbacks

```bash
home-manager generations                # then run <path>/activate of an older one
sudo darwin-rebuild --list-generations
sudo darwin-rebuild --rollback
```

## Not managed here

- `~/.aws/bin/sso-login` (aliased in zsh), SSH/GPG keys
- ghcup, luaver, opam (sourced by zsh if present)
