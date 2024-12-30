local wezterm = require("wezterm")
local mux = wezterm.mux
local config = wezterm.config_builder()

wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Disable tab bar and set initial window size for maximized window
config.enable_tab_bar = false
config.initial_rows = 100
config.initial_cols = 205
config.window_decorations = "NONE"

-- Color scheme
config.color_scheme = "Dracula"

-- Font
config.font = wezterm.font_with_fallback({
	"JetBrains Mono",
	"Cascadia Code",
	"DejaVu Sans Mono",
	"monospace",
})
config.font_size = 14.0

return config
