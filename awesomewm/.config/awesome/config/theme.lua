-- config/theme.lua
-- Manage theme and appearance

local gears = require("gears")
local beautiful = require("beautiful")
local variables = require("config.variables")

beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")
beautiful.wallpaper = variables.wallpaper

return beautiful
