-- Main rc.lua file
-- Load modules
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local beautiful = require("beautiful")
local naughty = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Error handling
require("config.errors")

-- Variable definitions
require("config.variables")

-- Menu configuration
require("config.menu")

-- Wibar configuration
require("config.wibar")

-- Key bindings
require("config.keys")

-- Rules
require("config.rules")

-- Signals
require("config.signals")

-- Set theme
beautiful.init(require("config.theme"))
