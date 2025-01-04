-- config/variables.lua
-- Define global variables

local home = os.getenv("HOME")

-- Default terminal and editor
local M = {}
M.terminal = "x-terminal-emulator"
M.editor = os.getenv("EDITOR") or "nano"
M.editor_cmd = M.terminal .. " -e " .. M.editor

-- Default modkey
M.modkey = "Mod1" -- Mod4 is the super key, Mod1 is the alt key

-- Wallpaper path
M.wallpaper = home .. "/.config/awesome/wallpaper.jpeg"

return M
