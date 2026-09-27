# dotdot

My tmux + Neovim setup (Tokyo Night, lazy.nvim).

## Install

```sh
git clone https://github.com/EmreOzdemiroglu/dotdot ~/code/dotdot
~/code/dotdot/install.sh
```

Existing files are backed up as `*.bak.<timestamp>`.

## Contents

- `tmux/tmux.conf`: prefix `C-a`, vi copy mode, `prefix f` project picker, `prefix D` scratchpad
- `nvim/`: Neovim config (lazy.nvim, LSP, telescope, harpoon, obsidian, ...)
- `bin/tmux-projects`: fzf session/project picker (needs `fzf`)
