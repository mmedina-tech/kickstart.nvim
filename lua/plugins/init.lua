local M = {}

local function bootstrap_lazy()
  local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable',
      lazypath,
    }
  end

  vim.opt.rtp:prepend(lazypath)
end

function M.setup()
  bootstrap_lazy()

  local ok, lazy = pcall(require, 'lazy')
  if not ok then
    vim.notify('lazy.nvim failed to load', vim.log.levels.ERROR)
    return
  end

  lazy.setup({
    'tpope/vim-sleuth',
    { import = 'plugins.specs' },
    { import = 'custom.plugins' },
  }, {
    change_detection = { notify = false },
    performance = {
      rtp = {
        disabled_plugins = {
          'gzip',
          'netrwPlugin',
          'tarPlugin',
          'tohtml',
          'tutor',
          'zipPlugin',
        },
      },
    },
  })
end

return M
