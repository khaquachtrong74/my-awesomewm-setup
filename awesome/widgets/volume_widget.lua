
-- ~/.config/awesome/widgets/volume_widget.lua
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

-- Volume slider
local volume_slider = wibox.widget {
    bar_shape           = gears.shape.rounded_rect,
    bar_height          = 6,    -- thin bar
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

-- Sync volume level from pamixer
local function update_slider()
    awful.spawn.easy_async("pamixer --get-volume", function(stdout)
        volume_slider.value = tonumber(stdout)
    end)
end

-- When slider is changed, set volume
volume_slider:connect_signal("property::value", function()
    awful.spawn("pamixer --set-volume " .. math.floor(volume_slider.value))
end)

-- Icon button to toggle popup
local volume_icon = wibox.widget {
    widget = wibox.widget.textbox,
    text = "🔊",
    font = "JetBrainsMono Nerd Font 20",
    align = "center",
    valign = "center"
}

-- Popup container (initially hidden)
local popup = awful.popup {
    widget = {
        {
            volume_slider,
            forced_width = 30,
            forced_height = 150,
            widget = wibox.container.constraint,
        },
        margins = 10,
        widget = wibox.container.margin,
    },
    border_color = "#81a1c1",
    border_width = 2,
    ontop = true,
    visible = false,
    placement = function(c)
        awful.placement.top_right(c, { margins = { top = 60, right = 360 } })
    end,
    shape = gears.shape.rounded_rect,
    preferred_positions = { "right" }
}

-- Toggle popup when icon clicked
volume_icon:buttons(gears.table.join(
    awful.button({}, 1, function()
        popup.visible = not popup.visible
        update_slider()
    end)
))

-- Optional: hide popup when mouse leaves
popup:connect_signal("mouse::leave", function()
    popup.visible = false
end)

return volume_icon
