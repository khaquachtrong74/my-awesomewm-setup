local awful = require("awful")
local gears = require("gears")
local beautiful = require("theme_light")
client.connect_signal("manage", function (c)
    c.opacity = 0
        c.shape = function(cr, width, height)
            gears.shape.rectangle(cr, width, height)
        end
        if awesome.startup
          and not c.size_hints.user_position
          and not c.size_hints.program_position then
            -- Prevent clients from being unreachable after screen count changes.
            awful.placement.no_offscreen(c) end local fade_timer = gears.timer{
            timeout = 0.01,
            autostart = true,
            call_now = true,
            callback = function()
                if c.opacity < 1 then
                c.opacity = c.opacity + 0.05
                else
                    c.opacity = 1
                    fade_timer:stop()
                end
            end
        }
    end)

client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )
end)
-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
client.connect_signal("property::fullscreen", function (c)
    for s in screen do
        if s == c.screen then
            s.mywibox.visible     = not c.fullscreen
        end
    end
end)
client.connect_signal("property::floating", function(c)
    if c.class == "menubar" then
        gears.timer.start_new(0.1, function()
            c.geometry({
                width = 500,
                height = 200,
                x = 100,
                y = 60
            })
            return false
        end)
    end 
end)

client.connect_signal("manage", function(c)
    if c.class == "menubar" then
        c:geometry({
            width = 500,
            height = 400,
            x = 100,
            y = 100
        })
    end
end)
screen.connect_signal("request::wallpaper", function(s)
    gears.wallpaper.maximized("/home/" .. os.getenv("USER") .. "/.config/awesome/images/background.png", s, true)
end)
-- }}}
