local menubar = require("../menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local terminal = "alacritty"
local editor = os.getenv("EDITOR") or "nano"
local editor_cmd = terminal .. " -e " .. editor
menubar.utils.terminal = terminal
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
      { "quit", function() awesome.quit() end },
}
myoptions = {
    {"open terminal", terminal},
    {"neofetch", terminal .. " -e neofetch"},
    { "vesktop-discord", "vesktop"},
    { "obs","obs"},
    {"snap", "flameshot gui"},
}
mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },{ "optional", myoptions}}})
mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu})
mylauncher = wibox.container.margin(mylauncher, 20, 10, 0, 0)

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}
-- CUSTOM WIDGETS 
local mytextclock = require("widgets.clock")
-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

-- }}}
