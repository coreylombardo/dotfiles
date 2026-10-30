#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

# install homebrew
if ! command -v brew >/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew bundle --file="$DOTFILES/Brewfile"

# back up .zshrc
if [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
    mv "$HOME/.zshrc" "$HOME/.zshrc.backup"
fi

cd "$DOTFILES"
stow zsh

# install terminal theme
open "$DOTFILES/macos/catppuccin-mocha.terminal"
defaults write com.apple.Terminal "Default Window Settings" -string "catppuccin-mocha"
defaults write com.apple.Terminal "Startup Window Settings" -string "catppuccin-mocha"