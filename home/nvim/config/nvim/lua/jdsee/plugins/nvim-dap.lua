-- nvim-dap
-- https://github.com/mfussenegger/nvim-dap/wiki

local dap, dapui = require('dap'), require('dapui')

require('telescope').load_extension('dap')
require('dap-python').setup('~/.pyenv/versions/debugpy/bin/python')
require('nvim-dap-virtual-text').setup()
dapui.setup {
  layouts = {
    {
      elements = {
        'scopes',
        'watches',
      },
      size = 20,
      position = 'bottom',
    }
  }
}

-- open/close UI on dap events
dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

-- customize signs
vim.fn.sign_define('DapBreakpoint', { text = '', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapLogPoint', { text = '', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '', texthl = '', linehl = '', numhl = '' })

Fn = {}
function Fn.set_conditional_breakpoint()
  dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end
function Fn.set_log_point()
  dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
end

-- Keybindings
vim.keymap.set('n', '<Leader>b', dap.toggle_breakpoint)
vim.keymap.set('n', '<Leader><leader>b?', Fn.set_conditional_breakpoint)
vim.keymap.set('n', '<Leader><leader>bl', Fn.set_log_point)
vim.keymap.set('n', '<Leader><leader>bd', dap.clear_breakpoints)

vim.keymap.set('n', '<A-h>', dap.continue)
vim.keymap.set('n', '<A-j>', dap.step_over)
vim.keymap.set('n', '<A-k>', dap.step_out)
vim.keymap.set('n', '<A-l>', dap.step_into)

vim.keymap.set('n', '<Leader>dn', dap.continue)
vim.keymap.set('n', '<Leader>dd', dap.run_last)
vim.keymap.set('n', '<Leader>du', dap.terminate)
vim.keymap.set('n', '<Leader>d>', dap.run_to_cursor)

vim.keymap.set('n', '<Leader>di', dap.repl.toggle)
vim.keymap.set('n', '<Leader>dk', dap.up)
vim.keymap.set('n', '<Leader>dj', dap.down)

vim.keymap.set('n', '<Leader>ds', dapui.toggle)
-- vim.keymap.set('n', '<Leader>dv', dapui.float_element('scopes', {}))

-- Lua setup
dap.adapters.nlua = function(callback, config)
  callback({ type = 'server', host = config.host, port = config.port })
end
dap.configurations.lua = {
  {
    type = 'nlua',
    request = 'attach',
    name = "Attach to running Neovim instance",
    host = function()
      local value = vim.fn.input('Host [127.0.0.1]: ')
      if value ~= "" then
        return value
      end
      return '127.0.0.1'
    end,
    port = function()
      local val = tonumber(vim.fn.input('Port: '))
      assert(val, "Please provide a port number")
      return val
    end,
  }
}

