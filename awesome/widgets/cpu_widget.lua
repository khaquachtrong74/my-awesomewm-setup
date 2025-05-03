local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local bg    = require("theme_light")
local cpu_widget = wibox.widget{
    {
        {
            id = "label",
            widget = wibox.widget.textbox,
        },
        widget = wibox.container.margin,
        left = 10,
        right = 10,
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
    autostart =  true,
    callback = function()
        awful.spawn.easy_async_with_shell(
            "grep 'cpu ' /proc/stat",
            function(stdout)
                local user, nice, system, idle = stdout:match("(%d+) (%d+) (%d+) (%d+)")
                local progressbar = cpu_widget:get_children_by_id("progressbar")[1]
                local label       = cpu_widget:get_children_by_id("label")[1]
                    if user and nice and system and idle then
                        user    = tonumber(user)
                        nice    = tonumber(nice)
                        system  = tonumber(system)
                        idle    = tonumber(idle)
                        local total = user + nice + system + idle 
                        if not progressbar.last_total then
                            progressbar.last_total = total
                            progressbar.last_idle = idle
                            return 
                        end
                        local delta_total = total - progressbar.last_total
                        local delta_idle = idle - progressbar.last_idle
                        if delta_total > 0 then
                            local cpu_usage = (100*(delta_total - delta_idle))/delta_total
                            progressbar.value = cpu_usage/100
                            label.text = string.format("CPU: %.1f%%",cpu_usage) 
                        end
                        progressbar.last_total = total
                        progressbar.last_idle = idle
                end
            end
        )
    end
}
return cpu_widget
