local server = {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
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

return server
