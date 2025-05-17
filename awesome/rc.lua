-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")
-- CUSTOM
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local modkey = "Mod4" require("awful.autofocus") -- make focus screen when switch tag
local beautiful = require("beautiful")
-- {{{ Error handling
require("core.erros")
-- Themes define colours, icons, font and wallpapers.
beautiful.init("/home/" .. os.getenv("USER") .. "/.config/awesome/theme.lua")
beautiful.border_radius = 4
beautiful.get().wallpaper = "/home/" .. os.getenv("USER") .. "/.config/awesome/images/background.jpg"
--beautiful.useless_gap = 2
beautiful.font = "JetBrainsMono Nerd Font 12"
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
--mainmenu = require("mainmenu")
require("signals")
require("ui.wibar")
local global = require("keys.global")
awful.rules.rules = require("rules").rules
root.keys(global)
--root.buttons(gears.table.join(
--    awful.button({ }, 3, function () mainmenu:toggle() end),
--    awful.button({ }, 4, awful.tag.viewnext),
--    awful.button({ }, 5, awful.tag.viewprev)
--))
