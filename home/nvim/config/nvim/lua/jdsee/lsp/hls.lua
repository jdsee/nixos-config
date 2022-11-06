local M = {}

function M.setup()
  require('lspconfig').hls.setup {
    root_dir = vim.loop.cwd,
    settings = {
      haskell = {
        hlintOn = true,
        formattingProvider = "stylish-haskell"
      }
    }
  }
end

return M
