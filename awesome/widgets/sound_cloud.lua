local wibox = require("wibox")

local sound_icon = wibox.widget{
    widget = wibox.widget.iconbox,
    resize = false
}

local sound_wibox = wibox{
   ontop = true,
   width = 200,
   height = 30,
   x = 1200,
   y = 4,
}
