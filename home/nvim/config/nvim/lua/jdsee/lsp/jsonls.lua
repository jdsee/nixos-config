local M = {}

function M.setup()
  require 'lspconfig'.jsonls.setup {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
        end
      }
    }
  }
end

return M
