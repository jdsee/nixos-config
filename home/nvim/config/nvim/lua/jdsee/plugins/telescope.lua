-- TELESCOPE SETUP

local telescope = require 'telescope'
local builtin = require 'telescope.builtin'
local themes = require 'telescope.themes'

telescope.setup {
  defaults = {
    prompt_prefix = ' ',
    defaults = {},
    mappings = {
      i = {
        ["<C-h>"] = "which_key",
      }
    },
  },
  pickers = {},
  extensions = {
    ['ui-select'] = {
      themes.get_dropdown(),
    },
    zoxide = {
      mappings = {
        ['<CR>'] = {
          keepinsert = true,
          action = function(selection)
            vim.cmd("cd " .. selection.path)
            vim.cmd("!cd " .. selection.path)
            builtin.find_files { cwd = selection.path }
          end,
        },
        ['<C-j>'] = {
          keepinsert = true,
          action = function(selection)
            builtin.find_files { cwd = selection.path }
          end,
        },
      }
    }
  }
}

telescope.load_extension 'fzf'
telescope.load_extension 'harpoon'
telescope.load_extension 'ui-select'
telescope.load_extension 'zoxide'

M = {}

function M.current_buffer_fuzzy_find()
  builtin.current_buffer_fuzzy_find(themes.get_dropdown())
end

function M.buffers()
  builtin.buffers {
    sort_lastused = true,
  }
end

function M.lsp_code_actions()
  builtin.lsp_code_actions(themes.get_cursor())
end

function M.lsp_find_references()
  builtin.lsp_references(themes.get_cursor())
end

function M.find_all_files()
  builtin.find_files {
    hidden = true,
    follow = true,
  }
end

function M.find_git_or_all_files()
  vim.cmd [[ silent! !git rev-parse --is-inside-work-tree ]]
  if vim.v.shell_error == 0
  then
    builtin.git_files()
  else
    M.find_all_files()
  end
end

function M.find_nvim_files()
  builtin.find_files {
    opt = { cwd = "$XDG_HOME/neovim" },
    hidden = true
  }
end

function M.spell_suggestions()
  builtin.spell_suggest(themes.get_cursor())
end

-- Keybindings
vim.keymap.set('n', '<C-p>', builtin.builtin) -- search telescope actions
vim.keymap.set('n', '<Leader>fj', telescope.extensions.zoxide.list) -- search autojump list
vim.keymap.set('n', '<Leader>ff', M.find_git_or_all_files) -- git_files if git repo, else all files
vim.keymap.set('n', '<Leader>fa', M.find_all_files) -- search all files
vim.keymap.set('n', '<Leader>fn', M.find_nvim_files) -- search files in neovim config
vim.keymap.set('n', '<Leader>fg', builtin.live_grep) -- grep everywhere
vim.keymap.set('n', '<Leader>fh', builtin.help_tags) -- search help tags
vim.keymap.set('n', '<Leader>fp', builtin.git_files) -- search files tracked by git
vim.keymap.set('n', '<Leader>gb', builtin.git_branches) -- search git branches
vim.keymap.set('n', '<Leader>gc', builtin.git_commits) -- search git commits
vim.keymap.set('n', '<Leader>fc', builtin.commands) -- search command history
vim.keymap.set('n', '<Leader>s', builtin.treesitter) -- search treesitter structure
vim.keymap.set('n', '<Leader>/', M.current_buffer_fuzzy_find) -- grep current buffer
vim.keymap.set('n', '<Leader>:', builtin.command_history) -- search command history
vim.keymap.set('n', '<Leader>fd', builtin.diagnostics) -- search errors from lsp
vim.keymap.set('n', '<Leader>a', M.lsp_code_actions) -- search code actions in telescope
vim.keymap.set('n', '<Leader><Tab>', M.buffers) -- search buffers
vim.keymap.set('n', 'z=', M.spell_suggestions) -- search spell suggestions
vim.keymap.set('n', 'gr', M.lsp_find_references) -- find references with lsp
