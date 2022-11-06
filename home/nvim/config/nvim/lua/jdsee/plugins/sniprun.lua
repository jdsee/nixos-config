-- sniprun
-- https://github.com/michaelb/sniprun

local sniprun = require('sniprun')
local display = require('sniprun.display')

-- Keymappings
vim.keymap.set('n', '<Leader>el', sniprun.run)
vim.keymap.set('n', '<Leader>e', '<Plug>SnipRunOperator')
vim.keymap.set('v', '<Leader>e', function() sniprun.run('v') end)
vim.keymap.set('n', '<Leader>ex', sniprun.reset)
vim.keymap.set('n', '<Leader>ed', display.close_all)
-- vim.keymap.set('n', '<Leader>ee', '%<Plug>SnipRun<CR>', { silent = false })

