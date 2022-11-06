local packer_bootstraped = require('jdsee.util.bootstrap').installPacker()
local packer = require 'packer'

return packer.startup(
  function(use)
    use { 'wbthomason/packer.nvim', opt = true }

    use 'tpope/vim-repeat' -- repeat plugin commands with .
    use 'tpope/vim-surround' -- work on surrounding characters like [({"'...
    use 'wellle/targets.vim' -- inner style text objects
    use 'dhruvasagar/vim-table-mode' -- markdown table support
    use 'ThePrimeagen/vim-be-good' -- game to practice vim movements

    -- Git Integration ---
    use {
      'tpope/vim-fugitive',
      config = function() require('jdsee.plugins.fugitive') end,
    }

    -- Git Worktree support ---
    use {
      'ThePrimeagen/git-worktree.nvim',
      config = function() require 'jdsee.plugins.git-worktree' end
    }

    --- Autopair Brackets ---
    use {
      'windwp/nvim-autopairs',
      config = function() require 'jdsee.plugins.nvim-autopairs' end,
    }

    --- Comment out Code with gc[motion] ---
    use {
      'numToStr/Comment.nvim',
      config = function() require('Comment').setup() end,
    }

    --- Visualize Colorcodes ---
    use {
      'norcalli/nvim-colorizer.lua',
      config = function() require('colorizer').setup() end,
    }

    --- Smooth Scrolling ---
    use {
      'karb94/neoscroll.nvim',
      config = function() require('neoscroll').setup() end,
    }

    --- Treesitter ---
    use {
      'nvim-treesitter/nvim-treesitter',
      requires = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/nvim-treesitter-context',
      },
      config = function() require 'jdsee.plugins.nvim-treesitter' end,
      run = ':TSUpdate'
      ,
    }

    --- Refactoring Tool ---
    use {
      'ThePrimeagen/refactoring.nvim',
      config = function() require 'jdsee.plugins.refactoring' end,
      requires = {
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-treesitter' }
      }
    }

    use {
      'ThePrimeagen/harpoon',
      requires = 'nvim-lua/plenary.nvim',
      config = function() require 'jdsee.plugins.harpoon' end
    }

    use {
      'pwntester/octo.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
        'kyazdani42/nvim-web-devicons',
      },
      config = function() require('octo').setup() end,
      diable = true,
    }

    --- Nvim Build Tool ---
    use {
      'pianocomposer321/yabs.nvim',
      config = function() require 'jdsee.plugins.yabs' end,
      requires = { 'nvim-lua/plenary.nvim' },
      disable = true,
    }

    --- Code Runner ---
    use {
      'michaelb/sniprun',
      config = function() require 'jdsee.plugins.sniprun' end,
      run = 'bash ./install.sh',
      disable = true,
    }

    --- GIT Marker ---
    use {
      'lewis6991/gitsigns.nvim',
      config = function() require 'jdsee.plugins.gitsigns' end,
      requires = { 'nvim-lua/plenary.nvim' }
    }

    --- Tab View for Buffers ---
    use {
      'romgrk/barbar.nvim',
      requires = { 'kyazdani42/nvim-web-devicons' }
    }

    --- Colorschemes ---
    use {
      { 'ellisonleao/gruvbox.nvim' },
      { 'sainnhe/gruvbox-material' },
      { 'sainnhe/everforest' },
      { 'Mofiqul/adwaita.nvim' },
      { 'rebelot/kanagawa.nvim' },
      { 'folke/tokyonight.nvim' },
      { 'EdenEast/nightfox.nvim' },
      { 'catppuccin/catppuccin' },
      { 'shaunsingh/oxocarbon.nvim' },
      use {
        'mcchrish/zenbones.nvim',
        requires = 'rktjmp/lush.nvim'
      }
    }

    use {
      "smjonas/live-command.nvim",
      config = function() require 'jdsee.plugins.live-command' end,
    }

    --- File Tree ---
    use {
      'nvim-neo-tree/neo-tree.nvim',
      config = function() require 'jdsee.plugins.neotree' end,
      branch = "v2.x",
      requires = {
        'nvim-lua/plenary.nvim',
        'kyazdani42/nvim-web-devicons',
        'MunifTanjim/nui.nvim',
      },
    }

    --- Indentation Visualizer ---
    use {
      'lukas-reineke/indent-blankline.nvim',
      config = function() require 'jdsee.plugins.indent-blankline' end,
    }

    --- Statusbar ---
    use {
      'nvim-lualine/lualine.nvim',
      config = function() require 'jdsee.plugins.lualine' end,
    }

    --- Telescope Fuzzy Finder ---
    use {
      {
        'nvim-telescope/telescope.nvim',
        config = function() require 'jdsee.plugins.telescope' end,
        requires = {
          'nvim-lua/plenary.nvim',
          'jvgrootveld/telescope-zoxide',
          'nvim-lua/popup.nvim',
          'nvim-telescope/telescope-ui-select.nvim',
        },
      },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
      },
      {
        'nvim-telescope/telescope-frecency.nvim',
        after = 'telescope.nvim',
        requires = 'tami5/sqlite.lua',
      },
    }

    use {
      'AckslD/nvim-neoclip.lua',
      after = 'telescope.nvim',
      config = function() require 'jdsee.plugins.neoclip' end,
    }

    --- LSP ---
    use {
      'neovim/nvim-lspconfig',
      requires = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
      },
      config = function() require 'jdsee.lsp' end,
    }

    --- LSP Completion ---
    use {
      'hrsh7th/nvim-cmp',
      config = function() require 'jdsee.plugins.nvim-cmp' end,
      requires = {
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-cmdline' },
        { 'hrsh7th/cmp-nvim-lua' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'PaterJason/cmp-conjure' },
        { 'rafamadriz/friendly-snippets' },
        { 'onsails/lspkind-nvim' }, -- LSP pictograms
      }
    }

    --- Snippets ---
    use {
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    }

    --- Java LSP ---
    use { 'mfussenegger/nvim-jdtls' }

    --- Scala LSP ---
    use {
      'scalameta/nvim-metals',
      requires = { "nvim-lua/plenary.nvim" }
    }

    --- Latex Integration ---
    use {
      'lervag/vimtex',
      config = function() require 'jdsee.plugins.vimtex' end
    }

    --- Clojure Integration ---
    use {
      {
        'Olical/conjure',
        config = function() require 'jdsee.plugins.conjure' end
      },
      {
        'tpope/vim-sexp-mappings-for-regular-people',
        requires = 'guns/vim-sexp'
      }
    }

    --- Testrunner ---
    use {
      'nvim-neotest/neotest',
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
        'antoinemadec/FixCursorHold.nvim',
        'vim-test/vim-test',
        'nvim-neotest/neotest-python',
        'nvim-neotest/neotest-plenary',
        'nvim-neotest/neotest-vim-test',
      },
      config = function() require 'jdsee.plugins.neotest' end
    }

    use {
      'mfussenegger/nvim-dap',
      config = function() require 'jdsee.plugins.nvim-dap' end,
      requires = {
        { 'nvim-telescope/telescope-dap.nvim' },
        { 'theHamsta/nvim-dap-virtual-text' },
        { 'rcarriga/nvim-dap-ui' },
        { 'jbyuki/one-small-step-for-vimkind' },
        { 'mfussenegger/nvim-dap-python' },
      }
    }

    -- Automatically set up configuration after cloning packer.nvim
    if packer_bootstraped then
      packer.sync()
    end

  end)
