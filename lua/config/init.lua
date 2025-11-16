-- Entrypoint for core configuration modules.
-- Loading happens in sequence to guarantee leader keys/options are set
-- before keymaps or autocommands depend on them.
require 'config.options'
require 'config.keymaps'
require 'config.autocmds'
