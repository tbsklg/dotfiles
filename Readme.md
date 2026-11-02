# Dotfiles

nix-darwin + home-manager configuration for macOS (aarch64-darwin).

- `flake.nix` – one `darwinConfigurations.<host>` per machine (`private`, `work`)
- `darwin.nix` – system: Nix settings, fonts, Homebrew (installed via nix-homebrew) and the few brews/casks not in nixpkgs
- `home.nix` – user: CLI packages, zsh (oh-my-zsh + pure), git, dotfile symlinks
- `hosts/*.nix` – per-host values (user, git identity, feature flags)

## Migrating an existing Mac (standalone home-manager + Brewfile)

1. Test-build without changing anything:
   ```bash
   cd ~/dotfiles
   nix build .#darwinConfigurations.work.system
   ```
2. Apply (Nix is already installed, so this moves the `/etc` shell/nix files aside, updates `flake.lock` and runs the first nix-darwin switch):
   ```bash
   ./bootstrap.sh work
   ```
3. Open a new terminal and check: pure prompt shows, `which jq zig mvn` resolve to `/etc/profiles/per-user/$USER/bin/...`, `brew list` works.
4. Clean up the old setup:
   ```bash
   nix profile remove home-manager-path
   brew uninstall exercism jq maven mob pure tree zig@0.15
   brew uninstall --cask font-hack-nerd-font session-manager-plugin
   ```
5. Commit and push, including the updated `flake.lock`.

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
5. Set up what is not managed here (see below).

`bootstrap.sh` installs Nix, then nix-darwin, which installs Homebrew, all packages, casks, fonts
and links the dotfiles. It is safe to re-run.

If the macOS username differs from the one in `hosts/<host>.nix`, update `username` and `homeDirectory` first.

## Updates

```bash
nix flake update
sudo darwin-rebuild switch --flake ~/dotfiles#work
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
