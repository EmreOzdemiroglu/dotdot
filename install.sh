#!/usr/bin/env bash
# Symlink dotdot configs into place, backing up anything already there.
set -eu
DIR="$(cd "$(dirname "$0")" && pwd)"
link() {
    mkdir -p "$(dirname "$2")"
    if [[ -e "$2" && ! -L "$2" ]]; then mv "$2" "$2.bak.$(date +%s)"; fi
    ln -sfn "$1" "$2"
    echo "linked $2 -> $1"
}
link "$DIR/tmux/tmux.conf"       "$HOME/.tmux.conf"
link "$DIR/nvim"                 "$HOME/.config/nvim"
link "$DIR/bin/tmux-projects"    "$HOME/.local/bin/tmux-projects"
