-- nvim-cmp
-- https://github.com/hrsh7th/nvim-cmp

local cmp = require 'cmp'
local luasnip = require 'luasnip'
local lspkind = require 'lspkind'

lspkind.init()
luasnip.filetype_extend('vue', { 'vue' })

local confirm_mapping = cmp.mapping.confirm {
  behavior = cmp.ConfirmBehavior.Replace,
  select = true,
}

cmp.setup {
  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ['<Down>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
    ['<Up>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = confirm_mapping,
    ['<C-Space>'] = confirm_mapping,
  },
  sources = {
    { name = 'nvim_lua' },
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'luasnip' },
    { name = 'treesitter' },
    { name = 'conjure' },
    { name = 'buffer', keyword_length = 5 },
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  formatting = {
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        buffer = '[buf]',
        nvim_lsp = '[LSP]',
        nvim_lua = '[api]',
        path = '[path]',
        luasnip = '[snip]',
        gh_issues = '[issues]',
      }
    }
  },
  experimental = {
    native_menu = false,
    ghost_text = true,
  }
}
