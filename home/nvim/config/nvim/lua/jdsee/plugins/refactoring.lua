-- REFACTORING.NVIM
---- https://github.com/ThePrimeagen/refactoring.nvim#configuration

local refactoring = require 'refactoring'
local telescope = require 'telescope'

refactoring.setup()
telescope.load_extension('refactoring')

local M = {}

function M.extract_function()
  refactoring.refactor('Extract Function')
end

function M.extract_function_to_file()
  refactoring.refactor('Extract Function To File')
end

function M.inline_variable()
  refactoring.refactor('Inline Variable')
end

function M.debug_print()
  refactoring.debug.printf { below = false }
end

-- Keybindings
vim.keymap.set('v', '<Leader>re', M.extract_function)
vim.keymap.set('v', '<Leader>ref', M.extract_function_to_file)
vim.keymap.set('v', '<Leader>ri', M.inline_variable)
vim.keymap.set( 'n', '<Leader>rp', M.debug_print)
vim.keymap.set("v", "<Leader>rv",refactoring.debug.print_var)
vim.keymap.set("n", "<Leader>rc",refactoring.debug.cleanup)

vim.keymap.set( "v", "<Leader>rm", telescope.extensions.refactoring.refactors)

