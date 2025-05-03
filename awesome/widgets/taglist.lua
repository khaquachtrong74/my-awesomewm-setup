local awful  = require("awful")
local gears  = require("gears")
local modkey = "Mod4"

awful.tag({ "Code", "Web", "Study", "Music", "Social"}, s, awful.layout.layouts[1])
       -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
-- {{{ Wibar
-- Create a wibox for each screen and add it
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

