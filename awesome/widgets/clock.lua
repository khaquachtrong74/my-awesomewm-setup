-- Create a textclock widget
local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local theme = require("theme")
local func_sync_icon = require('function.func')
local myiconclock = func_sync_icon.make_icon('/home/nullcore/.config/awesome/images/calendar.png')
local myicontextclock = wibox.widget{
    text = "  󱨰 ",
    widget = wibox.widget.textbox,
}
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
    myicontextclock,
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

local styles = {}
local function rounded_shape(size, partial)
    if partial then
        return function(cr, width, height)
                   gears.shape.partially_rounded_rect(cr, width, height,
                        false, true, false, true, 5)
               end
    else
        return function(cr, width, height)
                   gears.shape.rounded_rect(cr, width, height, size)
               end
    end
end
styles.month   = { padding      = 5,
                   bg_color     = theme.bg_normal,
                   border_width = 0,
                   shape        = rounded_shape(10)
}
styles.normal  = { shape    = rounded_shape(5) }
styles.focus   = { fg_color = theme.fg_focus,
                   bg_color = '#5a1917',
                   markup   = function(t) return '<b>' .. t .. '</b>' end,
                   shape    = rounded_shape(5, true)
}
styles.header  = { fg_color = theme.fg_focus,
                   markup   = function(t) return '<b>' .. t .. '</b>' end,
                   shape    = rounded_shape(10)
}
styles.weekday = { fg_color = '#7788af',
                   markup   = function(t) return '<b>' .. t .. '</b>' end,
                   shape    = rounded_shape(5)
}
local function decorate_cell(widget, flag, date)
    if flag=='monthheader' and not styles.monthheader then
        flag = 'header'
    end
    local props = styles[flag] or {}
    if props.markup and widget.get_text and widget.set_markup then
        widget:set_markup(props.markup(widget:get_text()))
    end
    -- Change bg color for weekends
    local d = {year=date.year, month=(date.month or 1), day=(date.day or 1)}
    local weekday = tonumber(os.date('%w', os.time(d)))
    local default_bg = (weekday==0 or weekday==6) and '#232323' or '#383838'
    local ret = wibox.widget {
        {
            widget,
            margins = (props.padding or 2) + (props.border_width or 0),
            widget  = wibox.container.margin
        },
        shape              = props.shape,
        shape_border_color = props.border_color or '#b9214f',
        shape_border_width = props.border_width or 0,
        fg                 = props.fg_color or theme.fg_normal,
        bg                 = props.bg_color or '#214180',
        widget             = wibox.container.background
    }
    return ret
end
local month_widget = wibox.widget{
    {
        {
            date = os.date("*t"),
            font = "JetBrainsMono Nerd Font 9",
            week_numbers = false,
            start_sunday = false,
            long_weekdays = true,
            fn_embed = decorate_cell,
            widget = wibox.widget.calendar.month
        },
        widget = wibox.container.margin,
        top = 20, left = 10, right = 10, bottom = 5
    },widget = wibox.container.background,
    bg = theme.bg_normal,

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
myicontextclock:buttons(
    gears.table.join(
        awful.button({}, 1, function()
            calendar_popup.visible = not calendar_popup.visible
        end
        )
    )
)
return myclock
