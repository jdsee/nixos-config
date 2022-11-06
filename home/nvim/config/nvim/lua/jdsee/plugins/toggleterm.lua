-- TOGGLETERM SETUP

local Terminal = require'toggleterm.terminal'.Terminal
local f = require'util.functions'
local map = f.map
local bmap = f.bmap
local cmd = vim.cmd

require('toggleterm').setup{
  -- open_mapping = [[<C-G>]],
  shading_factor = '3',
  size = 23,
  shade_terminals = true
}

function _G.set_terminal_keymaps()
  bmap('t', '<esc>', [[<C-\><C-n>]])
  bmap('t', '<C-S-h>', [[<C-\><C-n><C-W>h]])
  bmap('t', '<C-S-j>', [[<C-\><C-n><C-W>j]])
  bmap('t', '<C-S-k>', [[<C-\><C-n><C-W>k]])
  bmap('t', '<C-S-l>', [[<C-\><C-n><C-W>l]])
  bmap('t', '<C-S-G>', [[<C-\><C-n>:ToggleTermToggleAll<CR>]])
  map('n', '<C-S-G>', ':ToggleTermToggleAll<CR>')
end

cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- CUSTOM TERMINALS
local function create_floating_term(cmd, id)
  local terminal = Terminal:new {
    cmd = cmd,
    direction = 'float',
    float_opts = { border = 'curved' },
    count = id
  }
  return terminal
end

-- LAZYGIT
Lazygit = create_floating_term('lazygit', 10)
map('n', '<Leader>k', '<cmd>lua Lazygit:toggle()<CR>')

-- HTOP
Htop = create_floating_term('htop', 12)
vim.cmd [[ command! Htop execute 'lua Htop:toggle()' ]]

-- CTOP
Ctop = create_floating_term('ctop', 11)
vim.cmd [[ command! Ctop execute 'lua Ctop:toggle()' ]]

