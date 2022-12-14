local cmd = vim.cmd
local metals_config = require('metals').bare_config()

local M = {}

function M.setup(on_attach)
  -- TODO
  -- require('lspconfig').metals.setup(
  --   on_attach = on_attach
  -- )

  vim.opt_global.shortmess:remove("F")

  cmd([[augroup lsp]])
  cmd([[autocmd!]])
  cmd([[autocmd FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc]])
  cmd([[autocmd FileType scala,sbt lua require("metals").initialize_or_attach(metals_config)]])
  cmd([[augroup end]])

  -- Need for symbol highlights to work correctly
  vim.cmd([[hi! link LspReferenceText CursorColumn]])
  vim.cmd([[hi! link LspReferenceRead CursorColumn]])
  vim.cmd([[hi! link LspReferenceWrite CursorColumn]])

  -- TODO: add to status line
  -- metals_config.init_options.statusBarProvider = "on"
end

return M
