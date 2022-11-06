-- treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter

require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
  },
  textobjects = {
    swap = {
      enable = true,
      swap_next = {
        ['ia'] = "@parameter.inner",
      },
      swap_previous = {
        ['aa'] = "@parameter.inner",
      },
      ["af"] = "@function.outer",
      ["if"] = "@function.inner",
    },
  },
}

