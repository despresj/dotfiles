-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.hide_tab_bar_if_only_one_tab = true
-- This is where you actually apply your config choices

config.font_size = 18.0
-- For example, changing the color scheme:
-- config.color_scheme = 'Atelierseaside (dark) (terminal.sexy)'
-- config.color_scheme = 'Blue Matrix'
-- config.color_scheme = 'Bright Lights'
-- config.color_scheme = 'Brogrammer'
-- config.color_scheme = 'Builtin Pastel Dark'
-- config.color_scheme = 'Ciapre'
-- config.color_scheme = 'DimmedMonokai'
config.color_scheme = 'Kibble'
check_for_updates = false

-- and finally, return the configuration to wezterm
return config
