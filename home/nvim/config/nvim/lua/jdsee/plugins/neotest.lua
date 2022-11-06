-- neotest
-- https://github.com/nvim-neotest/neotest

local neotest = require('neotest')
local M = {}

neotest.setup {
  adapters = {
    require('neotest-python'),
    require('neotest-plenary'),
    require('neotest-vim-test')({
      ignore_file_types = { 'python', 'vim', 'lua' },
    }),
  },
  summary = {
    mappings = {
      output = 'O',
      short = 'o',
    }
  },
  icons = {
    running = '',
  },
}

M.run_all = function ()
  neotest.run.run(vim.fn.expand('%'))
end

M.run_all_in_file = function ()
  neotest.run.run(vim.fn.getcwd())
end

M.debug = function ()
  neotest.run.run { strategy = 'dap' }
end

M.toggle_summary = function ()
  neotest.summary.toggle { short = true }
end

-- Keybindings
vim.keymap.set('n', '<Leader>tf', M.run_all_in_file)
vim.keymap.set('n', '<Leader>ta', M.run_all)
vim.keymap.set('n', '<Leader>tj', neotest.run.run)
vim.keymap.set('n', '<Leader>tt', neotest.run.run_last)
vim.keymap.set('n', '<Leader>tu', neotest.run.stop)
vim.keymap.set('n', '<Leader>to', neotest.output.open)
vim.keymap.set('n', '<Leader>ts', M.toggle_summary)
vim.keymap.set('n', '<Leader>dt', M.debug)

