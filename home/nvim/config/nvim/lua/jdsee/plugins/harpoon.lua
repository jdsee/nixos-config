-- harpoon
-- https://github.com/ThePrimeagen/harpoon

Mark = require('harpoon.mark')
Ui = require('harpoon.ui')

-- Keybindings
vim.keymap.set('n', '<C-h>', Ui.nav_prev)
vim.keymap.set('n', '<C-l>', Ui.nav_next)
vim.keymap.set('n', '<Leader>hh', Ui.toggle_quick_menu)
vim.keymap.set('n', '<Leader>ha', Mark.add_file)
vim.keymap.set('n', '<Leader>hr', Mark.rm_file)
vim.keymap.set('n', '<Leader>hf', Mark.toggle_file)

