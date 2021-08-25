--[[

  MultiColor - FSG

    Theme based on:
      Multicolor Awesome WM theme 2.0
      github.com/lcpz

--]]

local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi

local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme                                     = {}
theme.confdir                                   = os.getenv("HOME") .. "/.config/awesome/themes/multicolor_fsg"
theme.font                                      = "Ubuntu " .. dpi(10)
theme.taglist_font                              = "Hack " .. dpi(15)
theme.icon_font                                 = "Hack"
theme.icon_size                                 = dpi(13)
theme.menu_bg_normal                            = "#282c34"
theme.menu_bg_focus                             = "#191f2b"
theme.bg_normal                                 = "#282c34"
theme.bg_focus                                  = theme.bg_normal
theme.bg_urgent                                 = "#b70202"
theme.fg_normal                                 = "#cccccc"
theme.fg_focus                                  = "#46d9ff"
theme.fg_urgent                                 = "#ffffff"
theme.fg_minimize                               = "#ffffff"
theme.border_width                              = dpi(2)
theme.border_normal                             = "#282c34"
theme.border_focus                              = "#46d9ff"
theme.border_marked                             = "#3ca4d8"
theme.menu_border_width                         = 0
theme.menu_width                                = dpi(130)
theme.menu_submenu_icon                         = theme.confdir .. "/icons/submenu.png"
theme.menu_fg_normal                            = "#aaaaaa"
theme.menu_fg_focus                             = "#ff8c00"
theme.taglist_squares_sel                       = theme.confdir .. "/icons/square_a.png"
theme.taglist_squares_unsel                     = theme.confdir .. "/icons/square_b.png"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.useless_gap                               = 3
theme.layout_tile                               = theme.confdir .. "/icons/tile.png"
theme.layout_tilegaps                           = theme.confdir .. "/icons/tilegaps.png"
theme.layout_tileleft                           = theme.confdir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.confdir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.confdir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.confdir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.confdir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.confdir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.confdir .. "/icons/dwindle.png"
theme.layout_max                                = theme.confdir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.confdir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.confdir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.confdir .. "/icons/floating.png"
theme.titlebar_close_button_normal              = theme.confdir .. "/icons/titlebar/close_normal.png"
theme.titlebar_close_button_focus               = theme.confdir .. "/icons/titlebar/close_focus.png"
theme.titlebar_minimize_button_normal           = theme.confdir .. "/icons/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus            = theme.confdir .. "/icons/titlebar/minimize_focus.png"
theme.titlebar_ontop_button_normal_inactive     = theme.confdir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = theme.confdir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = theme.confdir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = theme.confdir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_sticky_button_normal_inactive    = theme.confdir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = theme.confdir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = theme.confdir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = theme.confdir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_floating_button_normal_inactive  = theme.confdir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = theme.confdir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = theme.confdir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = theme.confdir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_maximized_button_normal_inactive = theme.confdir .. "/icons/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.confdir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = theme.confdir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = theme.confdir .. "/icons/titlebar/maximized_focus_active.png"

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
local clockicon = make_icon('\u{f073}', '#7788af')
local mytextclock = wibox.widget.textclock(markup("#7788af", "%d/%m/%Y ") .. markup("#ab7367", ">") .. markup("#de5e1e", " %H:%M "))
mytextclock.font = theme.font

-- Calendar
local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")
local cw = calendar_widget({
  theme = "outrun",
  placement = "top_right"
})
mytextclock:connect_signal("button::press",
  function(_, _, _, button)
    if button == 1 then cw.toggle() end
  end
)

-- CPU
local cpuicon = make_icon('\u{f85a}', '#e33a6e')
local cpu = lain.widget.cpu({
  settings = function()
    widget:set_markup(markup.fontfg(theme.font, "#e33a6e", cpu_now.usage .. "% "))
  end
})

-- Battery
local baticon = make_icon('\u{f0e7}', '#e0da37')
local bat = lain.widget.bat({
  settings = function()
    local perc = bat_now.perc ~= "N/A" and bat_now.perc .. "%" or bat_now.perc

    if bat_now.ac_status == 1 then
      perc = perc .. " plug"
    end

    widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, perc .. " "))
  end
})

local volume_widget = require('awesome-wm-widgets.volume-widget.volume')

-- Net
local netdownicon = make_icon('\u{f0ab}', '#87af5f')
local netdowninfo = wibox.widget.textbox()
local netupicon = make_icon('\u{f0aa}', '#e54c62')
local netupinfo = lain.widget.net({
  settings = function()
    widget:set_markup(markup.fontfg(theme.font, "#e54c62", net_now.sent .. " "))
    netdowninfo:set_markup(markup.fontfg(theme.font, "#87af5f", net_now.received .. " "))
  end
})

-- MEM
local memicon = make_icon('\u{f2db}', '#e0da37')
local memory = lain.widget.mem({
  settings = function()
    widget:set_markup(markup.fontfg(theme.font, "#e0da37", mem_now.used .. "M "))
  end
})

-- Logout widget
local logout_menu_widget = require("awesome-wm-widgets.logout-menu-widget.logout-menu")

function theme.at_screen_connect(s)
  -- Quake application
  s.quake = lain.util.quake({ app = awful.util.terminal })

  -- If wallpaper is a function, call it with the screen
  local wallpaper = theme.wallpaper
  if type(wallpaper) == "function" then
    wallpaper = wallpaper(s)
  end
  gears.wallpaper.maximized(wallpaper, s, true)

  -- Tags
  local names = { '\u{f268} ', '\u{f121} ', '\u{e795} ', '\u{f2d0} ', '\u{f269} ' }
  local l = awful.layout.suit
  local layouts = { l.max, l.tile, l.fair, l.max, l.max }
  awful.tag(names, s, layouts)

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  -- Create an imagebox widget which will contains an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(
    my_table.join(
      awful.button({}, 1, function () awful.layout.inc( 1) end),
      awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
      awful.button({}, 3, function () awful.layout.inc(-1) end),
      awful.button({}, 4, function () awful.layout.inc( 1) end),
      awful.button({}, 5, function () awful.layout.inc(-1) end)
    )
  )

  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

  -- Create the wibox
  s.mywibox = awful.wibar({
    position = "top",
    screen = s,
    height = dpi(26),
    bg = theme.bg_normal,
    fg = theme.fg_normal,
    border_width = 3,
    border_color = '#00000000',
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 8)
    end
  })

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      wibox.container.margin(s.mytaglist, 5),
      s.mypromptbox,
      wibox.container.margin(wibox.widget.textbox(markup('#444444', '|')), 2, 2)
    },
    s.mytasklist, -- Middle widget
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      wibox.widget.systray(),
      wibox.container.margin(wibox.widget.textbox(''), 0, 4),
      volume_widget(),
      wibox.container.margin(wibox.widget.textbox(markup('#444444', '|')), 2, 2),
      netdownicon,
      netdowninfo,
      wibox.container.margin(wibox.widget.textbox(''), 0, 4),
      netupicon,
      netupinfo.widget,
      wibox.container.margin(wibox.widget.textbox(markup('#444444', '|')), 2, 2),
      memicon,
      memory.widget,
      wibox.container.margin(wibox.widget.textbox(markup('#444444', '|')), 2, 2),
      cpuicon,
      cpu.widget,
      wibox.container.margin(wibox.widget.textbox(markup('#444444', '|')), 2, 2),
      baticon,
      bat.widget,
      wibox.container.margin(wibox.widget.textbox(markup("#444444", "|")), 2, 2),
      clockicon,
      mytextclock,
      s.mylayoutbox,
      logout_menu_widget()
    },
  }
end

return theme
