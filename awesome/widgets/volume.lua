local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local func_sync_icon = require('function.func')
local volumetextwidget = wibox.widget.textbox()
--local volumeiconwidget = func_sync_icon.make_icon('/home/nullcore/.config/awesome/images/high-volume.png')
local volumeicontext = wibox.widget{
    text = " 󰜟",
    widget = wibox.widget.textbox()
}
local myvolumewidget = wibox.widget{
    layout = wibox.layout.fixed.horizontal,
    volumetextwidget,
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
      -- Mỗi khi có “Event 'change' on sink #…”
      if line:match("Event 'change' on sink") then
        -- Cập nhật ngay
        volumetextwidget.text = get_volume()
      end
    end,
  }
)
gears.timer {
    timeout = 30,
    autostart = true,
    call_now = true,
    callback = function()
        volumetextwidget.text = get_volume()
    end
}
return myvolumewidget
