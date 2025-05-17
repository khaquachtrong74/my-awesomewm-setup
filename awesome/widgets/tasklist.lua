local awful = require('awful')
local theme = require('theme')
local gears = require('gears')
local wibox = require('wibox')
local tasklist = awful.wibar {
    widget = awful.widget.tasklist{
        screen = screen[1],
        filter = awful.widget.tasklist.filter.currenttags,
--        buttons = tasklist_buttons,
        layout = {
            spacing = 5,
            forced_num_rows = 1,
            layout = wibox.layout.grid.vertical,
        },
        widget_template = {
            {
                {
                    id     = 'clienticon',
                    widget = awful.widget.clienticon,
                },
              --  margins = 4,
              --  left = 8,
                widget  = wibox.container.margin,
            },
            id              = 'background_role',
            forced_width    = 32,
            forced_height   = 32,
            widget          = wibox.container.background,
            create_callback = function(self, c, index, objects) --luacheck: no unused
                self:get_children_by_id('clienticon')[1].client = c
            end,
        },
    },
    ontop        = true,
    visible = false,
    width = 32,
    height = 400,
    position = 'left',
    type = 'dock',
    shape        = gears.shape.rounded_rect
}
return tasklist
