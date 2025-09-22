pcall(require, "luarocks.loader")
local gears = require("gears")
local awful = require("awful")
local modkey = "Mod4" require("awful.autofocus")
local beautiful = require("beautiful")
require("core.erros")
beautiful.font = "JetBrainsMono Nerd Font 9"
beautiful.useless_gap = 2
awful.spawn.with_shell("picom --config ~/.config/picom/picom.conf")
awful.spawn.with_shell("clipmenud")
awful.layout.layouts = require("layout")
mainmenu = require("mainmenu")
require("signals")
require("ui.gui")
local global = require("keys.global")
awful.rules.rules = require("rules").rules
awful.spawn.with_shell("fcitx5 -d")
awful.spawn.with_shell("feh --bg-scale /home/khat/.config/awesome/images/background.jpg")
root.keys(global)
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
awful.spawn.with_shell("xset s off -dpms")
