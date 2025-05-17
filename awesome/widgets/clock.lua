-- Create a textclock widget
local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local theme = require("theme")
local func_sync_icon = require('function.func')
local myiconclock = func_sync_icon.make_icon('/home/nullcore/.config/awesome/images/calendar.png')
local mytextclock = wibox.widget{
    {
        text = os.date("%b-%d | %H:%M"),
        widget = wibox.widget.textbox,
        id = "clock_text"
    },
    widget = wibox.container.margin,
    set_time = function(self, val)
        self:get_children_by_id("clock_text")[1].text = val
    end
} 
local myclock = wibox.widget{
    layout = wibox.layout.fixed.horizontal,
    myiconclock,
    mytextclock,
}
gears.timer {
    timeout = 1,
    autostart = true,
    call_now = true,
    callback = function()
        mytextclock:set_time(os.date("%H:%M:%S"))
    end
}
local month_widget = wibox.widget{
    {
        {
            date = os.date("*t"),
            font = "JetBrainsMono Nerd Font 9",
            widget = wibox.widget.calendar.month
        },
        widget = wibox.container.margin,
        top = 10, left = 10, right = 10
    },widget = wibox.container.background,
    bg = '#303030',

}
local calendar_popup = awful.popup{
    widget = month_widget,
    placement     = function(c)
        awful.placement.top_left(c, { margins = { top = 40, left = 8 } })
    end,
    shape = gears.shape.rounded_rect,
    ontop = true,
    visible = false,
}
myiconclock:buttons(
    gears.table.join(
        awful.button({}, 1, function()
            calendar_popup.visible = not calendar_popup.visible
        end
        )
    )
)
return myclock
