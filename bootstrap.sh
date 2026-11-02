#!/usr/bin/env bash
set -euo pipefail

HOST="${1:?usage: $0 <private|work>}"
DIR="$(cd "$(dirname "$0")" && pwd)"
NIX=/nix/var/nix/profiles/default/bin/nix
NIX_FLAGS=(--extra-experimental-features "nix-command flakes")

if ! xcode-select -p >/dev/null 2>&1; then
  xcode-select --install
  echo "Finish the Command Line Tools installer, then re-run this script."
  exit 1
fi

if [ ! -x "$NIX" ]; then
  curl -fsSL https://nixos.org/nix/install | sh -s -- --daemon --yes
fi

for f in /etc/nix/nix.conf /etc/bashrc /etc/zshrc /etc/zshenv /etc/zprofile; do
  if [ -e "$f" ] && [ ! -L "$f" ]; then
    sudo mv "$f" "$f.before-nix-darwin"
  fi
done

"$NIX" "${NIX_FLAGS[@]}" flake lock "$DIR"

if [ -x /run/current-system/sw/bin/darwin-rebuild ]; then
  sudo /run/current-system/sw/bin/darwin-rebuild switch --flake "$DIR#$HOST"
else
  sudo "$NIX" "${NIX_FLAGS[@]}" run github:nix-darwin/nix-darwin/master#darwin-rebuild -- \
    switch --flake "$DIR#$HOST"
fi

echo "Done. Open a new terminal."
