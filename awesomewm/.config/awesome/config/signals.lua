-- config/signals.lua
-- Manage client signals

local beautiful = require("beautiful")
local awful = require("awful")
local gears = require("gears")

client.connect_signal("manage", function(c)
	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		awful.placement.no_offscreen(c)
	end
end)

client.connect_signal("request::titlebars", function(c)
	local buttons = gears.table.join(
		awful.button({}, 1, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.move(c)
		end),
		awful.button({}, 3, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.resize(c)
		end)
	)

	awful.titlebar(c):setup({
		{ awful.titlebar.widget.iconwidget(c), buttons = buttons, layout = wibox.layout.fixed.horizontal },
		{
			{ align = "center", widget = awful.titlebar.widget.titlewidget(c) },
			buttons = buttons,
			layout = wibox.layout.flex.horizontal,
		},
		{ awful.titlebar.widget.closebutton(c), layout = wibox.layout.fixed.horizontal },
		layout = wibox.layout.align.horizontal,
	})
end)

client.connect_signal("focus", function(c)
	c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
end)
