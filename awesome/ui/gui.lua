local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local modkey = "Mod4"
local theme = require("theme")
local naughty = require('naughty')
local clock_widget     = require("widgets.clock")
local battery_widget = require("widgets.battery")
local cpu_widget      = require("widgets.cpu")
local ram_widget      = require("widgets.ram")
local volume_widget   = require("widgets.volume")
local shutdown_widget = require("widgets.shutdown")
local mykeyboardlayout = awful.widget.keyboardlayout()
local mymainmenu = require("mainmenu")
awful.screen.connect_for_each_screen(function(s)
    awful.tag({ "Browser", "Study", "Huauaua", "Nothing", "Recorder"}, s, awful.layout.layouts[1])
    local taglist_buttons = gears.table.join(
        awful.button({ }, 1, function(t) t:view_only() end),
        awful.button({ modkey }, 1, 
        function(t)
          if client.focus then
              client.focus:move_to_tag(t)
          end
        end),
        awful.button({ }, 3, awful.tag.viewtoggle),
        awful.button({ modkey }, 3, 
        function(t)
          if client.focus then
              client.focus:toggle_tag(t)
          end
        end),
        awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
        awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end))
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

    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
       awful.button({ }, 1, function () awful.layout.inc( 1) end),
       awful.button({ }, 3, function () awful.layout.inc(-1) end),
       awful.button({ }, 4, function () awful.layout.inc( 1) end),
       awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    s.mytaglist = awful.widget.taglist { 
        screen  = s, 
        filter  = awful.widget.taglist.filter.all, 
        layout = {
            layout = wibox.layout.fixed.horizontal,
        },
        buttons = taglist_buttons,
        style = {
            bg_normal = theme.bg_normal,  
            bg_focus  = theme.tag_bg,
            fg_focus  = theme.fg_focus,
            bg_minimize = theme.bg_minimize,
        },
}

    s.mytasklist = awful.widget.tasklist { 
        screen  = s, 
        filter  = awful.widget.tasklist.filter.currenttags, 
        buttons = tasklist_buttons,
        style = {
            bg_normal = theme.bg_normal,   -- màu nền tasklist thường
            bg_focus  = theme.bg_normal,   -- màu nền khi focus
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

local mylauncher = awful.widget.launcher(
    {
        image = beautiful.theme_assets.awesome_icon(dpi(2048),theme.fg_focus,theme.bg_focs),
        menu = mymainmenu
    }
)
local left = wibox.layout.fixed.horizontal()
local mid = wibox.layout.fixed.horizontal()
local right = wibox.layout.fixed.horizontal()

left.spacing = dpi(8)
left:add(clock_widget)
left:add(mylauncher)
left:add(s.mytaglist)
mid:add(s.mytasklist)
local wrap_usage = wibox.widget{
    {
        {
            cpu_widget,
            ram_widget,
            layout = wibox.layout.fixed.horizontal
        },
        bg = theme.wrap_bg,
        fg = theme.wrap_fg_usage,
        widget = wibox.container.background,
    },
    widget = wibox.container.margin,
}

local wrap_tools = wibox.widget{
    {
        wibox.container.margin(battery_widget,0,10,0,0),
        volume_widget,
        shutdown_widget,
        layout = wibox.layout.fixed.horizontal
    },
    bg = theme.bg_normal,
    fg = theme.fg_normal,
    widget = wibox.widget.background,
}
right.spacing = dpi(8)
right:add(wrap_usage)
right:add(wrap_tools)
s.mywibox = awful.wibar({ position = "top", screen = s, height = 28, visible=false, ontop=true})
s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    {
        left,
        fg = theme.fg_normal,
        bg = theme.bg_normal,
        widget = wibox.widget.background
    },
    {
        mid,
        bg = theme.bg_normal,
        widget = wibox.widget.background

    },
    {
        right,
        fg = "#ffffff",
        bg = theme.bg_normal,
        widget = wibox.widget.background
    }, 
    shape = gears.shape.rectangle
}
    s.wibox_trigger = wibox({
        screen = s,
        x      = s.geometry.x,
        y      = s.geometry.y,
        width  = s.geometry.width,
        height = 2,              
        bg     = "#00000000",    
        ontop  = true,
        visible = true
    })
    s.wibox_trigger:struts({ top = 0 })
    s.wibox_trigger:connect_signal("mouse::enter", function()
        s.mywibox.visible = true
        s.wibox_trigger.visible = false
    end)

    s.mywibox:connect_signal("mouse::leave", function()
        s.mywibox.visible = false
        s.wibox_trigger.visible = true
    end)
end)
  
local function update_wibox_visibility(s)
    local t = s.selected_tag
    if not t or #t:clients() == 0 then
        s.mywibox.visible     = true
        s.wibox_trigger.visible = false
    else
        s.mywibox.visible     = false
        s.wibox_trigger.visible = true
    end
end

awful.tag.attached_connect_signal(nil, "property::selected", function(t)
    update_wibox_visibility(t.screen)
end)
client.connect_signal("manage",   function(c) update_wibox_visibility(c.screen) end)
client.connect_signal("unmanage", function(c) update_wibox_visibility(c.screen) end)
awful.screen.connect_for_each_screen(function(s)
    update_wibox_visibility(s)
end)
