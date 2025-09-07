vim.g.mapleader = ' '

-- ENV settings
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

-- Keymaps
vim.keymap.set('n', '<F4>', ':!ispell %<Esc>')
vim.keymap.set('n', '<F3>', ':!runme2.py -f $HOME/bin/runme.conf %<Cr>')
vim.keymap.set('n', '<F8>', ':!shellcheck -x %<Esc>')
vim.keymap.set('n', '<F9>', ':read !whoami<Esc>')
vim.keymap.set('n', '<leader>L', '1G/Last [uU]pdate:s*/e+1<CR><backspace>CYMD<ESC>')
vim.keymap.set('n', '<leader><leader>L', '1G/Last [cC]hange:s*/e+1<CR>CYMD<ESC>')
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<C-s>', ':w<CR>:source %<CR>', { desc = 'Saves and sources current file' })
