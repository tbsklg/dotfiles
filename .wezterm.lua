local wezterm = require 'wezterm'

local config = wezterm.config_builder()

--config.color_scheme = 'Nord (base20)'
config.colors = {
  foreground = '#d8d8d8',
  background = '#0e0e0e',

  cursor_bg = '#d8d8d8',
  cursor_border = '#d8d8d8',
  cursor_fg = '#0e0e0e',

  selection_bg = '#383838',
  selection_fg = '#d8d8d8',

  ansi = {
    '#161616',
    '#ab4642',
    '#76946A',
    '#f7ca88',
    '#799496',
    '#a8aec1',
    '#86c1b9',
    '#d8d8d8',
  },
  brights = {
    '#585858',
    '#4C8C8C',
    '#76946A',
    '#f7ca88',
    '#739393',
    '#9ca0b0',
    '#86c1b9',
    '#f9f9f9',
  },
}

config.force_reverse_video_cursor = true

config.font = wezterm.font_with_fallback {
  'JetBrains Mono',
  'Nerd Fonts Symbols',
}

config.font_size = 13

return config
