-- config/menu.lua
-- Create main menu and launcher widget

local awful = require("awful")
local beautiful = require("beautiful")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

local M = {}

M.awesomemenu = {
	{
		"Hotkeys",
		function()
			hotkeys_popup.show_help(nil, awful.screen.focused())
		end,
	},
	{ "Manual", M.terminal .. " -e man awesome" },
	{ "Edit Config", M.editor_cmd .. " " .. awesome.conffile },
	{ "Restart", awesome.restart },
	{
		"Quit",
		function()
			awesome.quit()
		end,
	},
}

M.mainmenu =
	awful.menu({ items = { { "Awesome", M.awesomemenu, beautiful.awesome_icon }, { "Open Terminal", M.terminal } } })
M.launcher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = M.mainmenu })

menubar.utils.terminal = M.terminal

return M
