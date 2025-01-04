-- config/rules.lua
-- Define client rules

local awful = require("awful")
local beautiful = require("beautiful")
local variables = require("config.variables")

local M = {}

M.rules = {
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
		},
	},
	{
		rule_any = {
			instance = { "DTA", "copyq", "pinentry" },
			class = { "Arandr", "Blueman-manager", "Gpick" },
			name = { "Event Tester" },
			role = { "pop-up" },
		},
		properties = { floating = true },
	},
	{ rule_any = { type = { "normal", "dialog" } }, properties = { titlebars_enabled = true } },
}

awful.rules.rules = M.rules

return M
