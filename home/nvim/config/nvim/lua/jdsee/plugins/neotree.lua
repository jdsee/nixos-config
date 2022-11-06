-- neotree
-- https://github.com/nvim-neo-tree/neo-tree.nvim

local neotree = require('neo-tree')

neotree.setup {
  filesystem = {
    filtered_items = {
      hide_dotfiles = false,
    }
  },
  window = {
    mappings = {
      ['o'] = 'open',
      ['<cr>'] = 'open',
      ['v'] = 'open_vsplit',
    }
  }
}

vim.fn.sign_define("DiagnosticSignError",
  { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn",
  { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo",
  { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint",
  { text = "", texthl = "DiagnosticSignHint" })

vim.g.neo_tree_remove_legacy_commands = 1

vim.keymap.set('n', '<C-i>', '<C-i>') -- necessary to use <Tab> and <C-i> separately
vim.keymap.set('n', '<Tab>', '<CMD>Neotree toggle<CR>')
vim.keymap.set('n', '<S-Tab>', '<CMD>Neotree reveal toggle<CR>')
vim.keymap.set('n', '<C-Tab', '<CMD>Neotree float toggle<CR>')
