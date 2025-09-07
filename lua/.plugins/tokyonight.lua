return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 3000,
  config = function()
    vim.cmd.colorscheme "tokyonight"
  end
}
