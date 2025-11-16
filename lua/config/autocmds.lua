-- Autocommands that are not tied to a specific plugin live here.
local group = vim.api.nvim_create_augroup('config-highlight-yank', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  group = group,
  desc = 'Briefly highlight on yank',
  callback = function()
    vim.highlight.on_yank()
  end,
})

local theme_group = vim.api.nvim_create_augroup('config-theme', { clear = true })

vim.api.nvim_create_autocmd('User', {
  group = theme_group,
  pattern = 'LazyDone',
  desc = 'Apply the configured theme after plugins load',
  callback = function()
    require('config.theme').setup()
  end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
  group = theme_group,
  desc = 'Persist theme changes',
  callback = function(event)
    require('config.theme').handle_colorscheme(event.match)
  end,
})
