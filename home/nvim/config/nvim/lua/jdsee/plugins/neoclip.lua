local neoclip = require 'neoclip'
local telescope = require 'telescope'

neoclip.setup {
  history = 500,
  enable_persistent_history = false,
  keys = {
    telescope = {
      i = {
        paste = '<c-j>',
      }
    }
  }
}

telescope.load_extension 'neoclip'

-- Keybindings
vim.keymap.set('n', '<Leader>fy', telescope.extensions.neoclip.default) -- search yank history
vim.keymap.set('n', '<Leader>fq', telescope.extensions.macroscope.default) -- search macro history
