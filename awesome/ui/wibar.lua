local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
-- 2. lấy hàm apply_dpi về biến dpi
local dpi = xresources.apply_dpi
local modkey = "Mod4"
local theme = require("theme")
local hotkeys_popup = require("awful.hotkeys_popup")
local terminal = "alacritty"
local editor = os.getenv("EDITOR") or "nano"
local editor_cmd = terminal .. " -e " .. editor


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
    beautiful.get().wallpaper = "/home/" .. os.getenv("USER") .. "~/.config/awesome/images/background.jpg"
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
            bg_focus  = theme.tag_bg,   -- màu nền khi focus
            fg_focus  = theme.fg_focus,
            bg_minimize = theme.bg_minimize, -- minimize thì màu xám nhẹ
        },

        widget_template = {
            {
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
        },
        widget = wibox.container.margin,
--        top = 2,bottom = 2
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
    local mytextclock     = require("widgets.clock")
    local mybatterywidget = require("widgets.battery")
    local cpu_widget      = require("widgets.cpu")
    local ram_widget      = require("widgets.ram")
    local volume_widget   = require("widgets.volume")
    local brightness_widget = require("widgets.brightness")
    local tasklist = require('widgets.tasklist')
    local mykeyboardlayout = awful.widget.keyboardlayout()
    local mymainmenu = require("mainmenu")

local mylauncher = awful.widget.launcher(
    {
        image = beautiful.theme_assets.awesome_icon(dpi(2048),theme.fg_focus,theme.bg_focus),
        menu = mymainmenu
    }
)
--    mylayoutbox.layout = 'spiral'
local left = wibox.layout.fixed.horizontal()
left.spacing = dpi(8)
left:add(mytextclock)
left:add(mylauncher)
left:add(s.mytaglist)
left:add(s.mypromptbox)
local mid = wibox.layout.fixed.horizontal()
--mid:add(wibox.widget.systray())
--mid:add(s.mytasklist)
--mid:add(wibox.widget.separator())
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
--        shape = gears.shape.rounded_rect
    },
    widget = wibox.container.margin,
--    top = 
--    bottom = 2,
}

local wrap_tools = wibox.widget{
    {
        wibox.container.margin(mybatterywidget,10,10,0,0),
        volume_widget,
        brightness_widget,
        layout = wibox.layout.fixed.horizontal
    },
    bg = theme.wrap_bg_tools,
    fg = theme.wrap_fg_tools,
    widget = wibox.widget.background,
--    left = 20, --top = 2, bottom = 2
}
local right = wibox.layout.fixed.horizontal()
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
    mid,
    right
}
    s.wibox_trigger = wibox({
        screen = s,
        x      = s.geometry.x,
        y      = s.geometry.y,
        width  = s.geometry.width,
        height = 2,               -- mỏng chỉ 2px
        bg     = "#00000000",     -- trong suốt hoàn toàn
        ontop  = true,
        visible = true
    })
    s.wibox_trigger:struts({ top = 0 })
    s.wibox_trigger:connect_signal("mouse::enter", function()
        s.mywibox.visible = true
        s.wibox_trigger.visible = false
        tasklist.visible = true
    end)

    s.mywibox:connect_signal("mouse::leave", function()
        s.mywibox.visible = false
        s.wibox_trigger.visible = true
        tasklist.visible = false
    end)
end)
