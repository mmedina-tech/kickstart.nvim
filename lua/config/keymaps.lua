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
-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Theme helpers
vim.keymap.set('n', '<leader>up', function()
  require('config.theme').open_picker()
end, { desc = '[U]I Theme [P]icker' })

vim.keymap.set('n', '<leader>ut', function()
  require('config.theme').toggle()
end, { desc = '[U]I Theme [T]oggle' })

vim.keymap.set('n', '<leader>us', function()
  require('config.theme').sync_with_system()
end, { desc = '[U]I [S]ync theme to system' })
