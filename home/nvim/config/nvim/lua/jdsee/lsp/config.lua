local M = {}

---@diagnostic disable-next-line: unused-local
function M.on_attach(client, bufnr)
  local map = function(mode, lhs, rhs)
    local opts = {
      silent = true,
    }
    -- TODO: this should probably done local to buffer
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  -- Keybindings
  map('n', 'gD', vim.lsp.buf.declaration)
  map('n', 'gd', vim.lsp.buf.definition)
  map('n', 'gi', vim.lsp.buf.implementation)
  map('n', 'gt', vim.lsp.buf.type_definition)
  map('n', 'K', vim.lsp.buf.hover)
  map('n', '<C-K>', vim.lsp.buf.signature_help)
  map('n', '<leader>a', vim.lsp.buf.code_action)
  map('n', '<Leader>rr', vim.lsp.buf.rename)
  map('n', '<Leader>rn', vim.lsp.buf.rename)
  map('n', '<Leader>rf', vim.lsp.buf.format)
  map('n', '[d', vim.diagnostic.goto_prev)
  map('n', ']d', vim.diagnostic.goto_next)
  map('n', 'gh', vim.diagnostic.open_float)

  -- TODO: map function to gd that first tries to goto_definition
  -------- and uses find_references else.

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  vim.api.nvim_create_user_command("Format", vim.lsp.buf.format, {})


  if client.server_capabilities.documentHighlightProvider then
    local group = vim.api.nvim_create_augroup("LSPDocumentHighlight", {})

    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      buffer = bufnr,
      group = group,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved" }, {
      buffer = bufnr,
      group = group,
      callback = vim.lsp.buf.clear_references,
    })
  end


end

return M
