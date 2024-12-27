local wezterm = require("wezterm")
local mux = wezterm.mux
local config = wezterm.config_builder()

wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

config.color_scheme = "Dracula"

config.window_padding = {
	left = 2,
	right = 2,
	top = 0,
	bottom = 0,
}

config.enable_tab_bar = false
config.initial_rows = 100
config.initial_cols = 205
config.window_decorations = "NONE"

config.window_background_opacity = 0.75
config.font_size = 18.0

--config.default_prog = { '/usr/bin/fish', '-l' }

return config
