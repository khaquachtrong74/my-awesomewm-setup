-- Create a textclock widget
local beautiful = require("beautiful") 
local wibox = require("wibox")
local gears = require("gears")
local theme = require("theme_light")
local mytextclock = wibox.widget{
    {
        {
            {
                text = os.date("%a-%b-%d | %H:%M:%S"),
                widget = wibox.widget.textbox,
                id = "clock_text"
            },
            widget = wibox.container.margin,
            left = 10, right = 10,
        },
        bg = theme.bg_normal,
        fg = theme.fg_normal,
        widget = wibox.container.background,
    },
    widget = wibox.container.margin,
    left = 10,
    set_time = function(self, val)
        self:get_children_by_id("clock_text")[1].text = val
    end
}
gears.timer {
    timeout = 1,
    autostart = true,
    call_now = true,
    callback = function()
        mytextclock:set_time(os.date(" %a %d %b %H:%M:%S"))
    end
}
return mytextclock
