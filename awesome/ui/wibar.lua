local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local modkey = "Mod4"
local theme = require("theme_light")
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
    set_wallpaper(s)
    beautiful.get().wallpaper = "/home/" .. os.getenv("USER") .. "~/.config/awesome/images/background_03.jpg"
    awful.tag({ "Code", "Web", "Study", "Nothing", "Social"}, s, awful.layout.layouts[1])
    s.mypromptbox = awful.widget.prompt()
    local taglist_buttons = gears.table.join(
        awful.button({ }, 1, function(t) t:view_only() end),
        awful.button({ modkey }, 1, function(t)
                                  if client.focus then
                                      client.focus:move_to_tag(t)
                                  end
                              end),
        awful.button({ }, 3, awful.tag.viewtoggle),
        awful.button({ modkey }, 3, function(t)
                                  if client.focus then
                                      client.focus:toggle_tag(t)
                                  end
                              end),
        awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
        awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
    )

    local tasklist_buttons = gears.table.join(
                 awful.button({ }, 1, function (c)
                                          if c == client.focus then
                                              c.minimized = true
                                          else
                                              c:emit_signal(
                                                  "request::activate",
                                                  "tasklist",
                                                  {raise = true}
                                              )
                                          end
                                      end),
                 awful.button({ }, 3, function()
                                          awful.menu.client_list({ theme = { width = 250 } })
                                      end),
                 awful.button({ }, 4, function ()
                                          awful.client.focus.byidx(1)
                                      end),
                 awful.button({ }, 5, function ()
                                          awful.client.focus.byidx(-1)
                                      end))


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
        layout = {
            layout = wibox.layout.fixed.horizontal,
        },
        buttons = taglist_buttons,
        style = {
            bg_normal = theme.bg_normal,   -- màu nền tasklist thường
            bg_focus  = theme.bg_focus,   -- màu nền khi focus
            fg_focus  = theme.fg_focus,
            bg_minimize = theme.bg_minimize, -- minimize thì màu xám nhẹ
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
            left = 6,
            right = 4,
            },
            id     = 'background_role',
            widget = wibox.container.background,
        }
    } 

--Create a tasklist widget 
    s.mytasklist = awful.widget.tasklist { 
        screen  = s, 
        filter  = awful.widget.tasklist.filter.currenttags, 
        buttons = tasklist_buttons,
        style = {
            bg_normal = theme.bg_normal,   -- màu nền tasklist thường
            bg_focus  = theme.bg_focus,   -- màu nền khi focus
            bg_minimize = theme.bg_minimize, -- minimize thì màu xám nhẹ
        },
        layout = {
            spacing = 8,
            layout  = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                {
                    id     = 'icon_role',
                    widget = wibox.widget.imagebox,
                    resize = true
                },
                margins = 3,
                widget  = wibox.container.margin,
            },
            id     = 'background_role',
            widget = wibox.container.background,
        },
    }
    local mytextclock = require("widgets.clock")
    local mybatterywidget = require("widgets.battery")
    local cpu_widget = require("widgets.cpu_widget")
    local ram_widget = require("widgets.ram_widget")
local left = wibox.layout.fixed.horizontal()
left:add(s.mytaglist)
local mid = wibox.layout.fixed.horizontal()
mid:add(s.mytasklist)
local right = wibox.layout.fixed.horizontal()
right:add(mytextclock)
right:add(cpu_widget)
right:add(ram_widget)
right:add(wibox.container.margin(mybatterywidget,10,10,0,0))
s.mywibox = awful.wibar({ position = "top", screen = s })
s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    left,
    mid,
    right,
}
awful.key({ modkey,       }, "t",
    function()
        for s in screen do
            s.mywibox.visible =  not s.mywibox.visible
        end
    end,
    {description = "on/off"})
end)
