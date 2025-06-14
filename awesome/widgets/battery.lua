local wibox = require("wibox")
local gears = require("gears")
local naughty = require("naughty")
local func_sync_icon = require('function.func')
naughty.config.defaults.position = "top_right" 
local batteryiconwidget = func_sync_icon.make_icon('/home/nullcore/.config/awesome/images/battery.png')
local batterytextwidget = wibox.widget{
        icon = "text",
        widget = wibox.widget.textbox,
}
local batteryicontext = wibox.widget{
    icon = "text",
    text = "  ",
    widget = wibox.widget.textbox,
}
local mybatterywidget = wibox.widget{
    layout = wibox.layout.fixed.horizontal,
--    batteryiconwidget,
    batterytextwidget,
    batteryicontext,
}
local function get_battery ()
        local handler = io.popen("upower -i $(upower -e | grep BAT) | grep percentage")
        local output = handler:read("*a")
        handler:close()
        local percent = output:match("(%d?%d?%d)%%")
        return percent or "?"
    end

gears.timer {
    timeout = 30,
    autostart = true,
    call_now = true, 
    callback = function()
        local percent = get_battery()
--        batteryiconwidget.image = os.getenv("HOME") .. "/.config/awesome/images/battery.png"
        local int_percent = tonumber(percent)
        if int_percent > 85 then
            batteryicontext.text = "  "
        elseif int_percent > 45 then
            batteryicontext.text = "  "
        elseif int_percent > 25 then
            batteryicontext.text = "  " 
        else
            batteryicontext.text = " 󰂎 "
        end
        batterytextwidget.text = percent .. "%"


    end
}
local battery_notify
mybatterywidget:connect_signal("mouse::enter", function()
    local status = io.popen("upower -i $(upower -e | grep BAT) | grep -E 'state|percentage|time'"):read("*a")
    battery_notify=naughty.notify(
        {
            title = "Battery Status",
            text = status,
            timeout = 5
        }
    )
end)
mybatterywidget:connect_signal("mouse::leave", function()
    if battery_notify then
        naughty.destroy(battery_notify)
        battery_notify=nil
    end
end)
return mybatterywidget
