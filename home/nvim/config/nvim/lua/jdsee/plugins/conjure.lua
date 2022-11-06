vim.g['conjure#mapping#doc_word'] = false
vim.g['g:sexp_enable_insert_mode_mappings'] = false

-- Keymappings
vim.keymap.set('n', '<leader>tt', '<cmd>ConjureCljRunCurrentTest<cr>')
vim.keymap.set('n', '<leader>tn', '<cmd>ConjureCljRunCurrentNsTests<cr>')
vim.keymap.set('n', '<leader>ta', '<cmd>ConjureCljRunAllTests<cr>')
