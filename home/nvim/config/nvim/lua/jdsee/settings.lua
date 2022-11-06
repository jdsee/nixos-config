local opt = vim.opt

-- General
opt.number = true -- line numbers
opt.relativenumber = true -- line number relative to position
opt.wrap = false -- don't wrap lines
opt.mouse = 'a' -- mouse support in all modes
opt.hidden = true -- hide buffers without saving
opt.spell = true
opt.spelllang = 'en_us,de_de'
opt.linebreak = true -- wrap whole lines if line wrap active
-- Windows
opt.equalalways = false -- no window resize

-- Formatting
opt.formatoptions = opt.formatoptions
    - 'a' -- no autoformat
    - 'o' -- don't continue comments with o
opt.formatoptions:remove 'o'

-- Completion
opt.wildmode = 'longest:full'
opt.wildoptions = 'pum'
opt.completeopt = { 'menu', 'menuone', 'noselect' }
-- TODO: opt.shortmess:append 'a'                -- use all message abbreviations

-- Scrolling
opt.scrolloff = 2 -- keep cursor away from vertical borders
opt.sidescrolloff = 2 -- keep cursor away from horizontal borders

-- Tabs and Spaces
local indent = 2
opt.tabstop = indent
opt.softtabstop = indent
opt.shiftwidth = indent
opt.backspace = { 'indent', 'eol', 'nostop' }
opt.smarttab = true
opt.expandtab = true -- use spaces as tab
opt.smartindent = true -- auto indent on insert
opt.autoindent = true -- "
opt.filetype.indent = true -- "
opt.splitright = true -- open new vertical splits on the right
opt.splitbelow = true -- open new horizontal splits on the bottom
opt.joinspaces = false -- prevent some weird extra spaces

-- Style
vim.cmd [[ colorscheme tokyonight-night ]] -- theme
vim.cmd [[ highlight Normal guibg=none]] -- make background transparent
opt.termguicolors = true -- true color support
opt.syntax = 'on' -- basic syntax highlighting
opt.showmatch = true -- show matching brackets
opt.cursorline = true -- highlight current line
opt.cmdheight = 0 -- hide command line when not used

-- Search and Command
opt.ignorecase = true -- case insensitive matching
opt.inccommand = 'nosplit' -- visualize command while typing
opt.hlsearch = false -- don't highlight search results
