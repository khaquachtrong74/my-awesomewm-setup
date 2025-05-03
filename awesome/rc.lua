-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")
-- CUSTOM
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local switch_theme = require("theme_switcher")
local modkey = "Mod4" require("awful.autofocus")
local mainmenu
local rules
-- Widget and layout library
-- Theme handling library
local beautiful = require("beautiful")
-- {{{ Error handling
require("core.erros")
-- Themes define colours, icons, font and wallpapers.
beautiful.init("/home/" .. os.getenv("USER") .. "/.config/awesome/theme_light.lua")
beautiful.border_radius = 4
beautiful.get().wallpaper = "/home/" .. os.getenv("USER") .. "/.config/awesome/images/background_03.jpg"
beautiful.useless_gap = 2
beautiful.font = "JetBrainsMono Nerd Font 9"
awful.spawn.with_shell("picom --config ~/.config/picom/picom.conf")
gears.timer {
    timeout = 60, -- check every 60 seconds
    autostart = true,
    callback = function()
        local time = tonumber(os.date("%H%M"))
        if time == 1900 then
            awful.spawn.with_shell("redshift -O 4000")
        elseif time == 700 then
            awful.spawn.with_shell("redshift -x")
        end
    end
}
awful.layout.layouts = require("layout")
mainmenu = require("mainmenu")
require("signals")
require("ui.wibar")
require("keys.global")
awful.rules.rules = require("rules").rules
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
