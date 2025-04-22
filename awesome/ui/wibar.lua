local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local set_wallpaper = function(s)
    if beautiful.wallpaper then 
        local wallpaper = beautiful.wallpaper
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end
awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper

--    beautiful.get().wallpaper = "/home/nullcore/Documents/images/background.png"
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5"}, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget 
    s.mytaglist = awful.widget.taglist { 
        screen  = s, 
        filter  = awful.widget.taglist.filter.all, 
        buttons = taglist_buttons,
        layout = {
            layout = wibox.layout.fixed.horizontal,
        },
        widget_template = {
        {
            {
                id     = 'text_role',
                widget = wibox.widget.textbox,
                align  = "center",
                valign = "center",
            },
            --layout = wibox.container.place,
            widget = wibox.container.margin,
            left = 20,
            right = 20,
        },
        id     = 'background_role',
        widget = wibox.container.background;
    }
} 
--Create a tasklist widget 
    s.mytasklist = awful.widget.tasklist { 
        screen  = s, 
        filter  = awful.widget.tasklist.filter.currenttags, 
        buttons = tasklist_buttons,
        style = {
            shape_border_width = 3,
            shape_border_color = "#9AB5FF",
            shape = gears.shape.transform(gears.shape.powerline)
        },
        layout = {
            --spacing = 10,
            spacing_widget = {
                {
                    forced_width = 40,
                    forced_height = 24,
                    shape = gears.shape.rectangle,
                    widget       = wibox.widget.separator
                },
                valign = "left",
                halign = "center",
                widget = wibox.container.place,
            },
            layout  = wibox.layout.flex.horizontal,
            spacing = 10 
        },
    }
   
-- create clocktext
    local mytextclock = require("widgets.clock")
    -- Create the wibox
    s.mywibox = awful.wibar({ 
        ontop = true, screen = s,
        shape = gears.shape.rectangle,
        width = 250, height = 40,
        bg = "#ffffff",top = 60,
        visible = true,
        --fg = "#000000",
        border_width = 3,
        border_color = "#6482ad"

    })
    
-- widget = wibox.container.margin,
-- Add widgets to the wibox

    s.mywibox:geometry({
        x = (s.geometry.width - 300) / 2,
        y = 10,
        width = 250,
        height = 40
    })

    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        -- Left widgets
        s.mytaglist,
        -- Middle widget
        -- Right widgets
    }
    s.clockwibox = wibox({
        screen = s,
        width = 260,
        height = 40,
        x = 210, -- Position from the right
        y = 10,                     -- Distance from top
        visible = true,
        ontop = true,
        shape = gears.shape.rounded_rect,
        bg = "#ffffff",
        fg = "#000000",
        border_width = 2,
        border_color = "#6482ad"
    })

    -- Setup the clock content
    s.clockwibox:setup {
        {
            mytextclock,
            widget = wibox.container.margin,
            left = 8,
            right = 8,
            top = 8,
            bottom = 8,
        },
        layout = wibox.layout.align.horizontal,
    }
    s.tools_wibox = wibox({
        screen = s, width = 200, height = 40, x = s.geometry.width - 410,
        y = 10, visible = true, ontop = true, shape = gears.shape.rounded_rect,
        bg = "#ffffff", fg = "#000000", border_width = 2, border_color = "#6482ad"
    })
    s.tools_wibox:setup {
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.fixed.horizontal,
            --volume_widget,
        },
        nil,
        {
            layout = wibox.layout.fixed.horizontal,
            --brightness_widget,
            widget = wibox.container.margin,
            left = 8,
            right = 8,
            top = 8,
            bottom = 8,
        },
    }
end)
