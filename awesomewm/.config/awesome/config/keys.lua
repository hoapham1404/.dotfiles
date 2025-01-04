-- config/keys.lua
-- Define key bindings

local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local variables = require("config.variables")

local M = {}

M.globalkeys = gears.table.join(
	awful.key({ variables.modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
	awful.key({ variables.modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
	awful.key({ variables.modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
	awful.key({ variables.modkey }, "Return", function()
		awful.spawn(variables.terminal)
	end, { description = "open terminal", group = "launcher" }),
	awful.key(
		{ variables.modkey, "Control" },
		"r",
		awesome.restart,
		{ description = "reload awesome", group = "awesome" }
	),
	awful.key({ variables.modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" })
)

root.keys(M.globalkeys)

return M
