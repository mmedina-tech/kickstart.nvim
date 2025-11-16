local uv = vim.uv or vim.loop

local M = {}

local state = {
  persist_file = vim.fn.stdpath 'state' .. '/theme.json',
  defaults = {
    dark = 'tokyonight-night',
    light = 'tokyonight-night', -- Light detections fall back to dark since this setup is dark-only
  },
}

local function read_file(path)
  local fd = uv.fs_open(path, 'r', 438)
  if not fd then
    return nil
  end

  local stat = uv.fs_fstat(fd)
  if not stat then
    uv.fs_close(fd)
    return nil
  end

  local data = uv.fs_read(fd, stat.size, 0)
  uv.fs_close(fd)
  return data
end

local function parse_ini_value(paths, key)
  for _, path in ipairs(paths) do
    local contents = read_file(vim.fn.expand(path))
    if contents then
      for line in contents:gmatch '[^\n]+' do
        local k, value = line:match '^%s*([%w%._%-]+)%s*=%s*(.+)%s*$'
        if k == key and value then
          value = value:gsub('^%s*"', ''):gsub('"%s*$', '')
          return value
        end
      end
    end
  end
end

local function read_gsettings(key)
  if vim.fn.executable 'gsettings' == 0 then
    return nil
  end

  local ok, result = pcall(vim.fn.system, { 'gsettings', 'get', 'org.gnome.desktop.interface', key })
  if not ok or vim.v.shell_error ~= 0 then
    return nil
  end

  result = vim.trim(result)
  if result:sub(1, 1) == "'" and result:sub(-1) == "'" then
    result = result:sub(2, -2)
  end
  return #result > 0 and result or nil
end

local function detect_style_from_string(value)
  if not value or value == '' then
    return nil
  end

  value = value:lower()
  local dark_tokens = { 'dark', 'night', 'mocha', 'storm', 'moon', 'black', 'midnight' }
  local light_tokens = { 'light', 'day', 'latte', 'dawn', 'morning', 'dusk', 'sun' }

  for _, token in ipairs(dark_tokens) do
    if value:find(token, 1, true) then
      return 'dark'
    end
  end
  for _, token in ipairs(light_tokens) do
    if value:find(token, 1, true) then
      return 'light'
    end
  end

  return nil
end

local function parse_boolean(value)
  if not value then
    return nil
  end

  value = value:lower()
  return value == '1' or value == 'true' or value == 'yes' or value == 'on'
end

local function detect_system_preference()
  local env_theme = vim.env.GTK_THEME or vim.env.SYSTEM_THEME
  local style = detect_style_from_string(env_theme)
  if style then
    return style
  end

  local color_scheme = read_gsettings 'color-scheme'
  style = detect_style_from_string(color_scheme)
  if style then
    return style
  end

  local gtk_theme = read_gsettings 'gtk-theme'
  style = detect_style_from_string(gtk_theme)
  if style then
    return style
  end

  local gtk_paths = {
    '~/.config/gtk-4.0/settings.ini',
    '~/.config/gtk-3.0/settings.ini',
  }

  local prefer_dark = parse_boolean(parse_ini_value(gtk_paths, 'gtk-application-prefer-dark-theme'))
  if prefer_dark ~= nil then
    return prefer_dark and 'dark' or 'light'
  end

  local gtk_name = parse_ini_value(gtk_paths, 'gtk-theme-name')
  style = detect_style_from_string(gtk_name)
  if style then
    return style
  end

  local kde_scheme = parse_ini_value({ '~/.config/kdeglobals' }, 'ColorScheme')
  style = detect_style_from_string(kde_scheme)
  if style then
    return style
  end
end

state.available = {
  {
    id = 'tokyonight-night',
    label = 'Tokyo Night',
    style = 'dark',
    setup = function()
      local ok, theme = pcall(require, 'tokyonight')
      if ok then
        theme.setup {
          styles = { comments = { italic = true } },
        }
      end
    end,
  },
  {
    id = 'onedark_dark',
    label = 'One Dark (classic)',
    style = 'dark',
    setup = function()
      local ok, theme = pcall(require, 'onedarkpro')
      if ok then
        theme.setup {
          caching = false,
          options = {
            cursorline = true,
            transparency = false,
          },
        }
      end
    end,
  },
  {
    id = 'onedark_vivid',
    label = 'One Dark (vivid)',
    style = 'dark',
    setup = function()
      local ok, theme = pcall(require, 'onedarkpro')
      if ok then
        theme.setup {
          caching = false,
          options = {
            cursorline = true,
          },
        }
      end
    end,
  },
  {
    id = 'catppuccin-mocha',
    label = 'Catppuccin Mocha',
    style = 'dark',
    setup = function()
      local ok, theme = pcall(require, 'catppuccin')
      if ok then
        theme.setup {
          flavour = 'mocha',
          integrations = {
            gitsigns = true,
            treesitter = true,
            telescope = true,
            cmp = true,
          },
        }
      end
    end,
  },
  {
    id = 'rose-pine',
    label = 'Rose Pine',
    style = 'dark',
    setup = function()
      local ok, theme = pcall(require, 'rose-pine')
      if ok then
        theme.setup {
          styles = {
            transparency = false,
          },
        }
      end
    end,
  },
  {
    id = 'nightfox',
    label = 'Nightfox',
    style = 'dark',
    setup = function()
      local ok, theme = pcall(require, 'nightfox')
      if ok then
        theme.setup {}
      end
    end,
  },
  {
    id = 'kanagawa',
    label = 'Kanagawa',
    style = 'dark',
    setup = function()
      local ok, theme = pcall(require, 'kanagawa')
      if ok then
        theme.setup {
          compile = false,
          background = {
            dark = 'dragon',
          },
        }
      end
    end,
  },
  {
    id = 'gruvbox',
    label = 'Gruvbox',
    style = 'dark',
    setup = function()
      local ok, theme = pcall(require, 'gruvbox')
      if ok then
        theme.setup {
          contrast = 'hard',
          overrides = {},
        }
      end
    end,
  },
  {
    id = 'dracula',
    label = 'Dracula',
    style = 'dark',
    setup = function()
      local ok, theme = pcall(require, 'dracula')
      if ok then
        theme.setup {
          italic_comment = true,
        }
      end
    end,
  },
  {
    id = 'everforest',
    label = 'Everforest',
    style = 'dark',
    setup = function()
      local ok, theme = pcall(require, 'everforest')
      if ok then
        theme.setup {
          background = 'hard',
          italics = true,
          disable_italic_comments = false,
        }
      end
    end,
  },
  {
    id = 'nordic',
    label = 'Nordic',
    style = 'dark',
    setup = function()
      local ok, theme = pcall(require, 'nordic')
      if ok then
        theme.setup {
          cursorline = {
            bold = true,
            theme = 'dark',
          },
        }
      end
    end,
  },
  {
    id = 'github_dark',
    label = 'GitHub Dark',
    style = 'dark',
    setup = function()
      local ok, theme = pcall(require, 'github-theme')
      if ok then
        theme.setup {
          options = {
            dim_inactive = true,
            styles = {
              comments = 'italic',
            },
          },
        }
      end
    end,
  },
  {
    id = 'monokai-pro',
    label = 'Monokai Pro',
    style = 'dark',
    setup = function()
      local ok, theme = pcall(require, 'monokai-pro')
      if ok then
        theme.setup {
          filter = 'pro',
          transparent_background = false,
        }
      end
    end,
  },
  {
    id = 'oxocarbon',
    label = 'Oxocarbon',
    style = 'dark',
    setup = function()
      vim.opt.background = 'dark'
    end,
  },
  {
    id = 'material-darker',
    label = 'Material Darker',
    style = 'dark',
    setup = function()
      local ok, theme = pcall(require, 'material')
      if ok then
        theme.setup {
          plugins = {
            'gitsigns',
            'telescope',
            'nvim-cmp',
          },
          italics = {
            comments = true,
          },
        }
      end
    end,
  },
}

state.by_id = {}
for _, theme in ipairs(state.available) do
  state.by_id[theme.id] = theme
end

local function persist(theme)
  local ok, encoded = pcall(vim.json.encode, { theme = theme })
  if not ok then
    vim.notify(string.format('Failed to encode theme info for %s', theme), vim.log.levels.WARN)
    return
  end

  local dir = vim.fn.fnamemodify(state.persist_file, ':h')
  vim.fn.mkdir(dir, 'p')

  ok, encoded = pcall(vim.fn.writefile, { encoded }, state.persist_file)
  if not ok then
    vim.notify('Failed to persist theme selection', vim.log.levels.WARN)
  end
end

local function read_persisted()
  local contents = read_file(state.persist_file)
  if not contents then
    return nil
  end

  local ok, decoded = pcall(vim.json.decode, contents)
  if not ok or type(decoded) ~= 'table' then
    return nil
  end

  return decoded.theme
end

local function theme_style(theme_id)
  local theme = state.by_id[theme_id]
  if theme then
    return theme.style
  end
  return detect_style_from_string(theme_id) or 'dark'
end

local function theme_for_style(style)
  for _, theme in ipairs(state.available) do
    if theme.style == style then
      return theme.id
    end
  end
end

local function run_setup(theme)
  if theme.setup and not theme._configured then
    local ok, err = pcall(theme.setup)
    theme._configured = ok
    if not ok then
      vim.notify('Failed to configure theme ' .. theme.id .. ': ' .. err, vim.log.levels.WARN)
    end
  end
end

local function apply(theme_id, opts)
  opts = opts or {}
  local theme = state.by_id[theme_id] or { id = theme_id }

  run_setup(theme)

  if theme.style == 'light' then
    vim.o.background = 'light'
  elseif theme.style == 'dark' then
    vim.o.background = 'dark'
  end

  M._suppress_next_persist = opts.preview == true

  local ok, err = pcall(vim.cmd.colorscheme, theme.id)
  if not ok then
    vim.notify('Unable to load colorscheme ' .. theme_id .. ': ' .. err, vim.log.levels.ERROR)
    M._suppress_next_persist = false
    return false
  end

  if not opts.preview then
    state.current_theme = theme_id
    if opts.persist ~= false then
      persist(theme_id)
    end
  end

  return true
end

function M.setup()
  if state.initialized then
    return
  end

  state.initialized = true

  local last_theme = read_persisted()
  local should_persist = last_theme == nil
  local target = last_theme or theme_for_style(detect_system_preference() or '') or state.defaults.dark

  if not apply(target, { persist = should_persist }) and target ~= state.defaults.dark then
    apply(state.defaults.dark, { persist = true })
  end

  M.register_commands()
end

function M.register_commands()
  if state.commands_registered then
    return
  end
  state.commands_registered = true

  vim.api.nvim_create_user_command('ThemePicker', function()
    M.open_picker()
  end, { desc = 'Pick a colorscheme with live previews' })

  vim.api.nvim_create_user_command('ThemeToggle', function()
    M.toggle()
  end, { desc = 'Cycle through the curated themes' })

  vim.api.nvim_create_user_command('ThemeSync', function()
    M.sync_with_system()
  end, { desc = 'Apply the system theme preference' })
end

function M.current()
  return state.current_theme
end

function M.apply(theme_id)
  return apply(theme_id, { persist = true })
end

function M.toggle()
  if vim.tbl_isempty(state.available) then
    return
  end

  local current_index = 0
  if state.current_theme then
    for i, theme in ipairs(state.available) do
      if theme.id == state.current_theme then
        current_index = i
        break
      end
    end
  end

  local next_index = current_index % #state.available + 1
  apply(state.available[next_index].id, { persist = true })
end

function M.sync_with_system()
  local style = detect_system_preference()
  if not style then
    vim.notify('Unable to detect a system theme preference', vim.log.levels.INFO)
    return
  end

  local target = theme_for_style(style) or state.defaults[style]
  if not target then
    vim.notify('No ' .. style .. ' theme registered', vim.log.levels.WARN)
    return
  end

  apply(target, { persist = true })
  vim.notify('Applied ' .. style .. ' theme (' .. target .. ')')
end

local function picker_entries()
  return vim.tbl_map(function(theme)
    return {
      id = theme.id,
      display = string.format('%s [%s]', theme.label, theme.style),
      ordinal = theme.label .. ' ' .. theme.style,
    }
  end, state.available)
end

local function picker_fallback()
  vim.ui.select(picker_entries(), {
    prompt = 'Select a theme',
    format_item = function(item)
      return item.display
    end,
  }, function(choice)
    if choice then
      apply(choice.id, { persist = true })
    end
  end)
end

function M.open_picker()
  local ok, pickers = pcall(require, 'telescope.pickers')
  if not ok then
    picker_fallback()
    return
  end

  local finders = require 'telescope.finders'
  local conf = require('telescope.config').values
  local actions = require 'telescope.actions'
  local action_state = require 'telescope.actions.state'

  local entries = picker_entries()
  local previous = state.current_theme

  pickers
    .new({}, {
      prompt_title = 'Theme Picker',
      finder = finders.new_table {
        results = entries,
        entry_maker = function(item)
          return {
            value = item,
            display = item.display,
            ordinal = item.ordinal,
          }
        end,
      },
      sorter = conf.generic_sorter {},
      attach_mappings = function(prompt_bufnr, map)
        local function preview_current()
          local selection = action_state.get_selected_entry()
          if selection and selection.value then
            apply(selection.value.id, { preview = true, persist = false })
          end
        end

        local function close_with_restore()
          actions.close(prompt_bufnr)
          if previous then
            apply(previous, { preview = true, persist = false })
          end
        end

        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          if selection and selection.value then
            apply(selection.value.id, { persist = true })
          elseif previous then
            apply(previous, { preview = true, persist = false })
          end
        end)

        map('i', '<Esc>', close_with_restore)
        map('n', '<Esc>', close_with_restore)
        map('i', '<C-c>', close_with_restore)
        map('n', '<C-c>', close_with_restore)

        local function move(delta)
          return function()
            if delta > 0 then
              actions.move_selection_next(prompt_bufnr)
            else
              actions.move_selection_previous(prompt_bufnr)
            end
            preview_current()
          end
        end

        map('i', '<C-j>', move(1))
        map('n', 'j', move(1))
        map('i', '<Down>', move(1))
        map('n', '<Down>', move(1))
        map('i', '<C-k>', move(-1))
        map('n', 'k', move(-1))
        map('i', '<Up>', move(-1))
        map('n', '<Up>', move(-1))

        vim.defer_fn(preview_current, 0)

        return true
      end,
    })
    :find()
end

function M.handle_colorscheme(name)
  if M._suppress_next_persist then
    M._suppress_next_persist = false
    return
  end
  state.current_theme = name
  persist(name)
end

return M
