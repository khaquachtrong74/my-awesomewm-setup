local awful = require("awful")
local beautiful = require("beautiful")

local M = {}

M.rules = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus        = awful.client.focus.filter,
            raise        = true,
            keys         = clientkeys,
            buttons      = clientbuttons,
            screen       = awful.screen.preferred,
            placement    = awful.placement.no_overlap + awful.placement.no_offscreen
        }
    },

    -- Floating clients
    {
        rule_any = {
            instance = { "DTA", "copyq", "pinentry" },
            class    = {
                "Arandr", "Blueman-manager", "Gpick", "Kruler", "MessageWin", "Sxiv",
                "Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer"
            },
            name     = { "Event Tester" },
            role     = {
                "AlarmWindow", "ConfigManager", "pop-up"
            }
        },
        properties = { floating = true }
    },
    -- Add titlebars to normal clients and dialogs
    {
        rule_any = { type = { "normal", "dialog" } },
        properties = { titlebars_enabled = true }
    },
 -- Set Firefox to always map on the tag named "2" on screen 1.
    {
        rule_any = { class = {"firefox", "chrome"} },
        properties = {
            screen        = 1,
            tag           = "Web",
            switch_to_tag = true,
            focus         = true,
        }
    }
}
return M

