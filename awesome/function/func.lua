local wibox = require('wibox')
local beautiful = require('beautiful')
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi
local func = {}
function func.make_icon(path)
    return wibox.widget {
        {
            image         = path,
            resize        = true,
            --forced_width  = dpi(4),
            --forced_height = dpi(16),
            widget        = wibox.widget.imagebox,
        },
        margins = dpi(6),
--       top = 4, 
        widget  = wibox.container.margin,
    }
end
return func
