local hotkeys_popup = require("awful.hotkeys_popup")
local awful = require("awful")
local beautiful = require("beautiful")
local terminal = "alacritty"
local editor = os.getenv("EDITOR") or "nano"
local editor_cmd = terminal .. " -e " .. editor
local menubar = require("menubar")

local theme = require('theme')
local xresources = require("beautiful.xresources")
-- 2. lấy hàm apply_dpi về biến dpi
local dpi = xresources.apply_dpi
beautiful.menu_heght = dpi(400)
beautiful.menu_width = dpi(200)
local myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
      { "quit", function() awesome.quit() end },
}
local myoptions = {
    {"open terminal", terminal},
    {"neofetch", terminal .. " -e neofetch"},
    { "vesktop-discord", "vesktop"},
    { "obs","obs"},
    {"snap", "flameshot gui"},
}
local mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.theme_assets.awesome_icon(dpi(2048),theme.fg_focus,theme.bg_focus)
},{ "optional", myoptions}}})

menubar.utils.terminal = terminal -- Set the terminal for applications that require it
return mymainmenu
