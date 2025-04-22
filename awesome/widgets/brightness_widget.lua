-- widgets/brightness_widget.lua
local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")

-- Hàm lấy độ sáng hiện tại (0-100)
local function get_brightness(callback)
    awful.spawn.easy_async_with_shell("brightnessctl get; brightnessctl max", function(stdout)
        local lines = {}
        for line in stdout:gmatch("[^\r\n]+") do
            table.insert(lines, tonumber(line))
        end
        local value = math.floor((lines[1] / lines[2]) * 100)
        if callback then callback(value) end
    end)
end

-- Widget slider
local brightness_slider = wibox.widget {
    orientation         = "vertical",
    bar_shape           = gears.shape.rounded_rect,
    bar_height          = 60,
    bar_width           = 6,
    bar_color           = "#3b4252",
    bar_active_color    = "#81a1c1",
    handle_color        = "#eceff4",
    handle_shape        = gears.shape.circle,
    handle_width        = 15,
    maximum             = 100,
    minimum             = 1,
    value               = 50,
    widget              = wibox.widget.slider,
}

-- Update brightness khi kéo
brightness_slider:connect_signal("property::value", function()
    awful.spawn("brightnessctl set " .. math.floor(brightness_slider.value) .. "%", false)
end)

-- Tự động load độ sáng ban đầu
get_brightness(function(val)
    brightness_slider.value = val
end)

-- Icon bấm để toggle slider
local brightness_icon = wibox.widget {
    widget = wibox.widget.textbox,
    text = "🔆",
    font = "JetBrainsMono Nerd Font 8",
    align = "center",
    valign = "center"
}

-- Popup container
local popup = awful.popup {
    widget = {
        {
            brightness_slider,
            margins = 10,
            widget = wibox.container.margin,
        },
        bg = "#2e3440",
        shape = gears.shape.rounded_rect,
        widget = wibox.container.background,
    },
    border_color = "#81a1c1",
    border_width = 2,
    ontop = true,
    visible = false,
    placement = function(c)
        awful.placement.top_right(c, { margins = { top = 60, right = 90 } })
    end,
}

-- Gán sự kiện click vào icon
brightness_icon:buttons(gears.table.join(
    awful.button({}, 1, function ()
        popup.visible = not popup.visible
        get_brightness(function(val)
            brightness_slider.value = val
        end)
    end)
))

-- Ẩn popup khi rời chuột
popup:connect_signal("mouse::leave", function()
    popup.visible = false
end)

return brightness_icon

