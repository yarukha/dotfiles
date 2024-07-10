-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.default_prog = { "/usr/local/bin/fish", "--login", "-c", "tmux" }

-- For example, changing the color scheme:
config.color_scheme = "Chalk"
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 13

-- hide tab bar
config.enable_tab_bar = false

-- and finally, return the configuration to wezterm
return config
