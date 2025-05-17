local wibox = require("wibox")
local awful = require("awful")
local func_sync_icon = require('function.func')
local brightnessicon = func_sync_icon.make_icon('/home/nullcore/.config/awesome/images/day-mode.png')
local brightnesstext = wibox.widget{
    {
        id = 'text',
        widget = wibox.widget.textbox,
    },
    right = 10,
    widget = wibox.container.margin,
}
local brightnesswidget = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    brightnessicon,
    brightnesstext,
}

local function get_brightness()
    -- Redirect stderr đúng đường dẫn /dev/null
    local f  = io.popen("brightnessctl g 2>/dev/null")
    local cur = f  and tonumber(f:read("*a")) or nil
    if f  then f :close() end

    local f1 = io.popen("brightnessctl m 2>/dev/null")
    local max = f1 and tonumber(f1:read("*a")) or nil
    if f1 then f1:close() end

    if cur and max and max > 0 then
        return math.floor(cur*100/max) .. "%"
    else
        return "?"
    end
end
brightnesstext:get_children_by_id('text')[1].text    = get_brightness()
local backlight_path = "/sys/class/backlight/intel_backlight/brightness"

awful.spawn.with_line_callback(
  string.format([[sh -c "inotifywait -q -m -e modify %s"]], backlight_path),
  {
    stdout = function(line)
      -- Update đúng widget textbox
      brightnesstext.text = get_brightness()
    end,
  }
)

return brightnesswidget
