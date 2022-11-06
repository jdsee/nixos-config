-- git-worktree
-- https://github.com/ThePrimeagen/git-worktree.nvim

local telescope = require('telescope')
telescope.load_extension('git_worktree')

-- Keybindings
vim.keymap.set('n', '<Leader>gw', telescope.extensions.git_worktree.git_worktrees)
