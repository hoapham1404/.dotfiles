-- config/variables.lua
-- Define global variables

local home = os.getenv("HOME")

-- Default terminal and editor
local M = {}
M.terminal = "x-terminal-emulator"
M.editor = os.getenv("EDITOR") or "nano"
M.editor_cmd = M.terminal .. " -e " .. M.editor

-- Default modkey
M.modkey = "Mod4"

-- Wallpaper path
M.wallpaper = home .. "/.config/awesome/wallpaper.jpeg"

return M
