-- | VIM-FLOATERM |
--- https://github.com/voldikss/vim-floaterm#get-started

local map = require('util.functions').map

vim.g.floaterm_wintype = 'split'
vim.g.floaterm_height = 0.4

vim.cmd [[ hi Floaterm guibg=#1d2021 ]]
-- vim.cmd [[ hi FloatermNC guibg=#282828 ]]

-- Keymappings
vim.g.floaterm_keymap_new    = '<C-t>n'
vim.g.floaterm_keymap_kill   = '<C-t>k'
vim.g.floaterm_keymap_toggle = '<C-G>'
-- vim.g.floaterm_keymap_next   = '<C-N>'
-- vim.g.floaterm_keymap_prev   = '<C-P>'

map('n', '<Leader>rs', '<cmd>FloatermSend<CR>')

-- Custom Terminals
local function createFloatTerm(name, command, mapping)
  vim.api.nvim_create_user_command(
    name,
    "FloatermNew --wintype=float --height=0.9 --width=0.9 --name="..command.." --autoclose=2 "..command.."<CR>",
    {}
  )
  if mapping ~= nil then
    map('n', mapping, '<cmd>'..name..'<CR>')
  end
end

-- Lazygit
createFloatTerm('Lg', 'lazygit', '<Leader>k')

-- Lazydocker
createFloatTerm('Docker', 'lazydocker')

-- BTM
createFloatTerm('Btm', 'btm')

