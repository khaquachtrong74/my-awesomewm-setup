local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local func_sync_icon = require('function.func')
local textwidget = wibox.widget.textbox("...")
local volumetextwidget = wibox.container.margin(textwidget, 10, 10, 10, 10)
local volumeicontext = wibox.widget{
    text = "󰜟",
    widget = wibox.widget.textbox()
}
local myvolumewidget = wibox.widget{
    layout = wibox.layout.fixed.horizontal,
    volumeicontext
}
local function get_volume ()
    local f = io.popen("pamixer --get-volume")
    if not f then
        return "?"
    end
    local output = f:read("*a")
    f:close()
    local vol = output:match("(%d+)")
    if vol then
        return vol .. "%"
    else
        return "?"
    end

end
awful.spawn.with_line_callback(
  "pactl subscribe",
  {
    stdout = function(line)
      if line:match("Event 'change' on sink") then
        textwidget.text = get_volume()
      end
    end,
  }
)
gears.timer {
    timeout = 30,
    autostart = true,
    call_now = true,
    callback = function()
        textwidget.text = get_volume()
    end
}
local volumetext_popup = awful.popup{
    ontop = true,
    visible = false,
    shape = gears.shape.rounded_rect,
    border_width =1,
    border_color = "#777777",
    widget = {
    {
        widget = volumetextwidget,
    },
    bg = "#222222",
    widget = wibox.container.background,
    },
    placement     = function(c)
        awful.placement.top_right(c, { 
            margins = { top=30, right=20 } 
        })
    end,
}
myvolumewidget:connect_signal("mouse::enter", function()
    volumetext_popup.visible = true;
end)
myvolumewidget:connect_signal("mouse::leave", function()
    volumetext_popup.visible = false;
end)
return myvolumewidget
