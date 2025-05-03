local beautiful = require("beautiful")
local awful = require("awful")
local current_theme = "dark" -- bắt đầu từ dark theme

local function switch_theme()
    if current_theme == "dark" then
        beautiful.init("~/.config/awesome/theme_light.lua")
        awful.spawn.with_shell("feh --bg-scale ~/Documents/images/background_02.png")
        current_theme = "light"
    else
        beautiful.init("~/.config/awesome/theme.lua")
        awful.spawn.with_shell("feh --bg-scale ~/Documents/images/background.png")
        current_theme = "dark"
    end
end

return switch_theme
