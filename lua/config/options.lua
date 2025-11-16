vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- ENV settings
vim.opt.breakindent = true
vim.opt.ignorecase = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.confirm = true
vim.opt.wrap = true
vim.opt.ai = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.foldmethod = 'marker'
vim.opt.showmode = true
vim.opt.wildmenu = true
vim.opt.showcmd = true
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.undofile = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.scrolloff = 10
vim.opt.termguicolors = true

-- Abbreviations
vim.cmd 'iab resutl result'
vim.cmd 'filetype plugin indent on'
vim.cmd 'iab slef self'
vim.cmd 'iab sefl self'
vim.cmd 'iab calss class'
vim.cmd 'iab retunr return'
vim.cmd 'iab flaot float'
vim.cmd 'iab REactance Reactance'
vim.cmd 'iab REsistance Resistance'
vim.cmd 'iab Resitance Resistance'
vim.cmd 'iab Resitor Resistor'
vim.cmd 'iab formbase from FormulaBase import *'
vim.cmd "iab degree_sign  '&#65042'"
vim.cmd 'iab titel title'
vim.cmd 'iab funciton function'
vim.cmd 'iab Totla Total'
vim.cmd 'iab Amsp Amps'
vim.cmd 'iab Votl Volt'
vim.cmd 'iab YMD <C-R>=strftime(" %Y-%m-%d: %H:%M")'
