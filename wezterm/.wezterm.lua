local wezterm = require("wezterm")
local mux = wezterm.mux
local config = wezterm.config_builder()

wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

config.window_padding = {
	left = 5,
	right = 0,
	top = 5,
	bottom = 0,
}

-- Disable tab bar and set initial window size for maximized window
config.enable_tab_bar = false
config.initial_rows = 100
config.initial_cols = 205
config.window_decorations = "NONE"

-- Font
config.font = wezterm.font_with_fallback({
	{ family = "JetBrains Mono", weight = "Medium" },
})
config.font_size = 16.0
config.line_height = 1.1
config.cell_width = 1.0
config.harfbuzz_features = { "calt=0", "liga=0" }

-- Window Appearance
config.window_background_opacity = 0.8
config.macos_window_background_blur = 20

config.adjust_window_size_when_changing_font_size = false
config.keys = {
	{ key = "+", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
	{ key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },
	{ key = "0", mods = "CTRL", action = wezterm.action.ResetFontSize },
}

return config
