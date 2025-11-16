return {
  'nvim-lualine/lualine.nvim',
  config = function()
    local mode = {
      'mode',
      fmt = function(str)
        return 'Vim' .. str:sub(1, 1)
      end,
    }

    local filename = {
      'filename',
      file_status = true,
      path = 1,
    }

    local hide_in_width = function()
      return vim.fn.winwidth(0) > 100
    end

    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'auto',
      },
      sections = {
        lualine_a = {
          {
            'datetime',
            -- options: default, us, uk, iso, or your own format string ("%H:%M", etc..)
            style = 'default',
          },
        },
        lualine_b = { 'branch' },
        lualine_c = { filename },
        lualine_x = { { 'encoding', cond = hide_in_width }, { 'filetype', cond = hide_in_width } },
        lualine_y = { 'location' },
        lualine_z = { 'progress' },
      },

      tabline = {},
      extensions = { 'lazy' },
    }
  end,
}
