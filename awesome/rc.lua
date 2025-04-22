-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- CUSTOM
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
-- Theme handling library
local beautiful = require("beautiful")
-- {{{ Error handling
require("core.erros")
-- Themes define colours, icons, font and wallpapers.
beautiful.init("/home/" .. os.getenv("USER") .. "/.config/awesome/theme.lua")
beautiful.get().wallpaper = "/home/" .. os.getenv("USER") .. "/.config/awesome/images/background.png"
beautiful.border_radius = 12 
beautiful.useless_gap = 10
beautiful.font = "JetBrainsMono Nerd Font 12"
awful.spawn.with_shell("picom --config ~/.config/picom/picom.conf")
awful.layout.layouts = require("layout")
-- Create a launcher widget and a main menu
local mainmenu = require("mainmenu")
require("ui.wibar")
require("keys.global")
-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
local rules = require("rules")
awful.rules.rules = rules.rules
-- {{{ Signals
-- Signal function to execute when a new client appears.
require("signals")
-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

