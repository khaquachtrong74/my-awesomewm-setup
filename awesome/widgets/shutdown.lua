local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local shutdown_widget = wibox.widget{
    text = " ⏻ ",
    widget = wibox.widget.textbox,
}
shutdown_widget:connect_signal("button::press", function()
    awful.spawn.with_shell("systemctl poweroff")
end)
return shutdown_widget
