local opt = vim.opt
local cmd = vim.cmd
local g = vim.g 
opt.guifont = "JetBrainsMonoNL Nerd Font Mono:h14"
opt.buftype = ""

opt.swapfile = false
vim.api.nvim_command('filetype plugin indent on')
opt.termguicolors = true
g.python_highlight_all = 1
opt.background = dark
cmd "set nu rnu"
opt.undofile = true
cmd "set undodir=$HOME/.undodir/nvim"
cmd "set clipboard=unnamed"
cmd "set clipboard+=unnamedplus"
-- vim.api.nvim_buf_set_option(0, 'buftype', 'nofile')
vim.api.nvim_buf_set_option(0, 'modifiable', true)
opt.wrap = true
opt.fileformat = unix
opt.textwidth = 200    
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.autoindent = true

opt.ruler  = true
opt.showcmd = true
opt.showmatch = true
opt.scrolloff=12

cmd("set backspace=indent,eol,start")
cmd("set mouse=a")
cmd("set selection=exclusive")
cmd("set selectmode =mouse,key")
opt.matchtime=0
opt.ignorecase = true
opt.incsearch = true
opt.hlsearch = true
opt.expandtab = true
opt.autoread = true
opt.cursorline = true 
cmd ("set buftype=")
opt.modifiable=true
g.completeopt = "menu,menuone,noselect"

cmd ([[au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif]])






