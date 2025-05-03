local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local bg    = require("theme_light")
local ram_widget = wibox.widget{
    {
        {
            id = "label",
            widget = wibox.widget.textbox
        },
        widget = wibox.container.margin,
        right = 10,
        left = 10
    },
    {
        id = "progressbar",
        widget = wibox.widget.progressbar,
        force_height = 30,
        force_width  = 100,
        width = 100,
        background_color = bg.bg_focus,
        color = bg.bg_progressbar
    },
    layout = wibox.layout.fixed.horizontal
}
gears.timer{
    timeout = 2,
    autostart = true,
    callback = function()
        awful.spawn.easy_async_with_shell(
            "free -m | awk '/Mem:/ {print $3 \" \" $2 }'",
            function(stdout)
                local used, total = stdout:match("(%d+) (%d+)")
                local label = ram_widget:get_children_by_id("label")[1]
                local progressbar = ram_widget:get_children_by_id("progressbar")[1]
                if used and total then
                    local used_mb = tonumber(used)
                    local total_mb = tonumber(total)
                    local percent = (used_mb/total_mb) * 100
                progressbar.value = percent/100
                label.text = string.format("RAM: %.1f%%", percent)
                end
            end
        )
    end
}
return ram_widget
