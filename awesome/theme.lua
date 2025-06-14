local theme = {}
local dpi = require("beautiful.xresources").apply_dpi
theme.useless_gap = dpi(4)   -- đặt gap mặc định là 10px
--theme.font = "JetBrainsMono Nerd Font 20"
-- Colors
theme.bg_normal     = "#2e3440"
theme.bg_focus      = "#727388"
theme.bg_urgent     = "#456789"
theme.bg_minimize   = "#2a2e36"
theme.bg_progressbar= '#aabad3'

theme.fg_normal     = "#5d80ab"
theme.fg_focus      = "#d8dee9"
theme.fg_urgent     = "#000000"
theme.fg_minimize   = "#555556"
theme.fg_tool_normal= "#eead38"
theme.usage_bar = "#212121"
theme.tag_bg = "#1e4376"
theme.wrap_bg = theme.bg_normal
theme.wrap_bg_tools = theme.bg_normal
theme.wrap_fg_usage = theme.fg_normal
theme.wrap_fg_tools = theme.fg_normal
-- Borders
theme.border_width  = 2 
theme.border_normal = theme.fg_normal
theme.border_focus =  '#9cb3ae'
theme.border_marked = "#FF6F61"
-- Other
theme.useless_gap   = 6
theme.systray_icon_spacing = 6

theme.menu_height = 16
theme.menu_width = 16
return theme
