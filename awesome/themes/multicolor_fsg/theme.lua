--[[
  MultiColor - FSG - TokyoNight variation
  https://github.com/felsangom/dotfiles/tree/tokyonight

    Theme based on:
      Multicolor Awesome WM theme 2.0
      github.com/lcpz
--]]

local gears = require("gears")
local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")

local dpi = require("beautiful.xresources").apply_dpi

local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme = {}
theme.confdir = os.getenv("HOME") .. "/.config/awesome/themes/multicolor_fsg"
-- Colors
theme.color = {
  background = "#24283b",
  foreground = "#c0caf5",
  highlight = "#353a52",
  black = "#1d202f",
  red = "#f7768e",
  green = "#9ece6a",
  yellow = "#e0af68",
  blue = "#7aa2f7",
  magenta = "#bb9af7",
  cyan = "#7dcfff",
  white = "#a9b1d6",
  gray = '#444444'
}
-- Font config
theme.font = "CaskaydiaCove Nerd Font " .. dpi(10)
theme.taglist_font = "CaskaydiaCove Nerd Font " .. dpi(13)
theme.icon_font = "CaskaydiaCove Nerd Font"
theme.icon_size = dpi(13)
-- Menu
theme.menu_bg_normal = theme.color.background
theme.menu_bg_focus = theme.color.highlight
-- Background and foreground colors
theme.bg_normal = theme.color.background
theme.bg_focus = theme.color.highlight
theme.bg_urgent = theme.bg_normal
theme.fg_normal = theme.color.foreground
theme.fg_focus = theme.color.red
theme.fg_urgent = theme.color.red
theme.widget_separator_color = theme.color.gray
-- Borders
theme.useless_gap = 4
theme.border_width = 2
theme.border_normal = theme.bg_normal
theme.border_focus = theme.color.blue
theme.border_marked = theme.color.magenta
-- Wibar border
theme.wibar_height = dpi(26)
theme.wibar_bg = theme.bg_normal .. 'cc'
theme.wibar_border = 0
theme.wibar_border_radius = 0
theme.wibar_border_color = "#00000000"
-- Menu
theme.menu_border_width = 0
theme.menu_width = dpi(130)
theme.menu_submenu_icon = theme.confdir .. "/icons/submenu.png"
theme.menu_fg_normal = theme.fg_normal
theme.menu_fg_focus = theme.fg_focus
-- Taglist
theme.taglist_bg_normal = theme.bg_normal
theme.taglist_bg_focus = theme.bg_focus .. '00'
theme.taglist_fg_focus = theme.fg_focus
theme.taglist_fg_occupied = theme.color.yellow
theme.taglist_fg_urgent = theme.fg_urgent
theme.taglist_fg_empty = theme.fg_normal
theme.taglist_spacing = 5
-- Tasklist
theme.tasklist_bg_normal = theme.bg_normal .. '00'
theme.tasklist_bg_focus = theme.bg_normal .. '00'
theme.tasklist_plain_task_name = true
theme.tasklist_disable_icon = true
-- Layout icons
theme.layout_tile = theme.confdir .. "/icons/tile.png"
theme.layout_tilegaps = theme.confdir .. "/icons/tilegaps.png"
theme.layout_tileleft = theme.confdir .. "/icons/tileleft.png"
theme.layout_tilebottom = theme.confdir .. "/icons/tilebottom.png"
theme.layout_tiletop = theme.confdir .. "/icons/tiletop.png"
theme.layout_fairv = theme.confdir .. "/icons/fairv.png"
theme.layout_fairh = theme.confdir .. "/icons/fairh.png"
theme.layout_spiral = theme.confdir .. "/icons/spiral.png"
theme.layout_dwindle = theme.confdir .. "/icons/dwindle.png"
theme.layout_max = theme.confdir .. "/icons/max.png"
theme.layout_fullscreen = theme.confdir .. "/icons/fullscreen.png"
theme.layout_magnifier = theme.confdir .. "/icons/magnifier.png"
theme.layout_floating = theme.confdir .. "/icons/floating.png"
-- Titlebar icons
theme.titlebar_close_button_normal = theme.confdir .. "/icons/titlebar/close_normal.png"
theme.titlebar_close_button_focus = theme.confdir .. "/icons/titlebar/close_focus.png"
theme.titlebar_minimize_button_normal = theme.confdir .. "/icons/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus = theme.confdir .. "/icons/titlebar/minimize_focus.png"
theme.titlebar_ontop_button_normal_inactive = theme.confdir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = theme.confdir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = theme.confdir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = theme.confdir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_sticky_button_normal_inactive = theme.confdir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = theme.confdir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = theme.confdir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = theme.confdir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_floating_button_normal_inactive = theme.confdir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = theme.confdir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = theme.confdir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = theme.confdir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_maximized_button_normal_inactive = theme.confdir .. "/icons/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = theme.confdir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = theme.confdir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = theme.confdir .. "/icons/titlebar/maximized_focus_active.png"

local markup = lain.util.markup

--[[
-- Get the icon hex code on https://www.nerdfonts.com/cheat-sheet
-- You'll need a patched nerd font for the icons. I recommend Hack Nerd Font, but you
-- can use any nerd font you like and change the icon_font above.
--]]
local function make_icon(icon_code, icon_color)
  local icon_widget = wibox.widget{
    markup = '<span color="' .. icon_color .. '">' .. icon_code .. '</span>',
    font = theme.icon_font .. ' ' .. theme.icon_size,
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
  }

  -- Return the icon widget with left and right margins
  return wibox.container.margin(icon_widget, 5, 5)
end

-- Textclock
os.setlocale(os.getenv("LANG")) -- to localize the clock
local clockicon = make_icon('\u{f073} ', theme.color.blue)
local mytextclock = wibox.widget.textclock(markup(theme.fg_normal, "%d/%m/%Y ") .. markup(theme.fg_normal, "%H:%M "))
mytextclock.font = theme.font
mytextclock:connect_signal("button::press",
  function(_, _, _, button)
    if button == 1 then cw.toggle() end
  end
)

-- Calendar
local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")
local cw = calendar_widget({
  theme = "dark",
  placement = "top_right"
})

-- CPU
local cpuicon = make_icon('\u{f85a} ', theme.color.red)
local cpu = lain.widget.cpu({
  settings = function()
    widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, cpu_now.usage .. "% "))
  end
})

-- Battery
--[[
local baticon = make_icon('\u{f0e7} ', '#d8a657')
local bat = lain.widget.bat({
  settings = function()
    local perc = bat_now.perc ~= "N/A" and bat_now.perc .. "%" or bat_now.perc

    if bat_now.ac_status == 1 then
      perc = perc .. " plug"
    end

    widget:set_markup(markup.fontfg(theme.font, "#d8a657", perc .. " "))
  end
})
]]--

local volume_widget = require('awesome-wm-widgets.volume-widget.volume')

-- Net
local netdownicon = make_icon('\u{f13a} ', theme.color.green)
local netdowninfo = wibox.widget.textbox()
local netupicon = make_icon('\u{f139} ', theme.color.red)
local netupinfo = lain.widget.net({
  settings = function()
    widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, net_now.sent .. " "))
    netdowninfo:set_markup(markup.fontfg(theme.font, theme.fg_normal, net_now.received .. " "))
  end
})

-- MEM
local memicon = make_icon('\u{f2db} ', theme.color.yellow)
local memory = lain.widget.mem({
  settings = function()
    widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, mem_now.used .. "M "))
  end
})

-- Logout widget
local logout_menu_widget = require("awesome-wm-widgets.logout-menu-widget.logout-menu")

function theme.at_screen_connect(s)
  -- Tags
  local names = { '\u{f269}', '\u{f121}', '\u{f120}', '\u{eb23}' }
  local l = awful.layout.suit
  local layouts = { l.max, l.tile, l.fair, l.floating }
  awful.tag(names, s, layouts)

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  -- Create an imagebox widget which will contains an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox = wibox.container.margin(s.mylayoutbox, 5, 5, 5, 5)
  s.mylayoutbox:buttons(
    my_table.join(
      awful.button({}, 1, function () awful.layout.inc( 1) end),
      awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
      awful.button({}, 3, function () awful.layout.inc(-1) end),
      awful.button({}, 4, function () awful.layout.inc( 1) end)
    )
  )

  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.all,
    buttons = awful.util.taglist_buttons,
    style = {
      shape = gears.shape.rectangle
    },
    layout = {
      spacing = 5,
      spacing_widget = {
        color = '#00000000',
        shape = gears.shape.rectangle,
        widget = wibox.widget.separator
      },
      layout = wibox.layout.fixed.horizontal
    },
    widget_template = {
      {
        {
          {
            id = 'text_role',
            forced_width = 20,
            valign = 'center',
            halign = 'center',
            widget = wibox.widget.textbox
          },
          left = 3,
          right = 3,
          widget = wibox.container.margin
        },
        id = 'text_margin_role',
        bottom = 2,
        color = theme.fg_focus .. '00',
        widget = wibox.container.margin
      },
      id = 'background_role',
      widget = wibox.container.background,
      -- This callback is used for selected tag bottom border
      create_callback = function(comp, tag, index, tags) --luacheck: no unused args
        -- On create, index 1 has border
        if (index == 1) then
          comp:get_children_by_id('text_margin_role')[1].color = theme.fg_focus
        end

        -- On selected property change, show/hide border
        tag:connect_signal('property::selected', function(t)
          if (t.selected) then
            comp:get_children_by_id('text_margin_role')[1].color = theme.fg_focus
          else
            comp:get_children_by_id('text_margin_role')[1].color = theme.fg_focus .. '00'
          end
        end)
      end
    }
  }

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

  -- Create the wibox
  s.mywibox = awful.wibar({
    position = "top",
    screen = s,
    height = theme.wibar_height,
    border_width = theme.wibar_border,
    border_color = theme.wibar_border_color,
    type = 'dock',
    shape = function(cr, width, height)
      if (theme.wibar_border_radius > 0) then
        gears.shape.rounded_rect(cr, width, height, 8)
      else
        gears.shape.rectangle(cr, width, height)
      end
    end
  })

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      wibox.container.margin(s.mytaglist, 5),
      s.mypromptbox,
      wibox.container.margin(wibox.widget.textbox(markup(theme.widget_separator_color, '|')), 2, 2)
    },
    s.mytasklist, -- Middle widget
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      s.systray,
      wibox.container.margin(wibox.widget.textbox(''), 0, 4),
      volume_widget(),
      wibox.container.margin(wibox.widget.textbox(markup(theme.widget_separator_color, '|')), 2, 2),
      netdownicon,
      netdowninfo,
      wibox.container.margin(wibox.widget.textbox(''), 0, 4),
      netupicon,
      netupinfo.widget,
      wibox.container.margin(wibox.widget.textbox(markup(theme.widget_separator_color, '|')), 2, 2),
      memicon,
      memory.widget,
      wibox.container.margin(wibox.widget.textbox(markup(theme.widget_separator_color, '|')), 2, 2),
      cpuicon,
      cpu.widget,
      wibox.container.margin(wibox.widget.textbox(markup(theme.widget_separator_color, '|')), 2, 2),
      --baticon,
      --bat.widget,
      --wibox.container.margin(wibox.widget.textbox(markup(theme.widget_separator_color, "|")), 2, 2),
      clockicon,
      mytextclock,
      s.mylayoutbox,
      logout_menu_widget()
    },
  }
end

return theme
