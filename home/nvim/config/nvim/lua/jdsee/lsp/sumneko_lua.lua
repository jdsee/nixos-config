local M = {}

function M.setup()
  require('lspconfig').sumneko_lua.setup {
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' }
        }
      },
      workspace = {
        -- neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false
      },
      telemetry = {
        enable = false,
      },
    }
  }
end

return M
