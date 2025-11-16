-- Autocommands that are not tied to a specific plugin live here.
local group = vim.api.nvim_create_augroup('config-highlight-yank', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  group = group,
  desc = 'Briefly highlight on yank',
  callback = function()
    vim.highlight.on_yank()
  end,
})
