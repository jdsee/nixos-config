-- gitsigns
-- https://github.com/lewis6991/gitsigns.nvim

local gitsigns = require('gitsigns')
local M = {}

gitsigns.setup()

function M.blame_full_line()
  gitsigns.blame_line {
    full = true,
  } 
end

function M.diffthis_home()
  gitsigns.diffthis('~')
end

-- Keybindings
vim.keymap.set('n', '<Leader>g?', M.blame_full_line)
vim.keymap.set('n', '<Leader>gs', gitsigns.stage_hunk)
vim.keymap.set('n', '<Leader>gu', gitsigns.reset_hunk)
vim.keymap.set('n', '<Leader>gn', gitsigns.next_hunk)
vim.keymap.set('n', '<Leader>gp', gitsigns.prev_hunk)
vim.keymap.set('n', '<Leader>gd', M.diffthis_home)

