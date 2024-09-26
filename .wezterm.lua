local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'Kanagawa Dragon (Gogh)'
config.colors = {
  background = '#14161b',
  cursor_bg = '#e0e2ea',
  cursor_border = '#e0e2ea',
  cursor_fg = '#14161b',
  foreground = '#e0e2ea',
  selection_bg = '#2c2e33',
  selection_fg = '#14161b',
  ansi = {
    '#2c2e33',
    '#a30202',
    '#b3f6c0',
    '#6b5300',
    '#81a9c6',
    '#9d81bb',
    '#128184',
    '#4f5258',
  },
  brights = {
    '#2c2e33',
    '#ffc0b9',
    '#b3f6c0',
    '#fce094',
    '#8cf8f7',
    '#7f639b',
    '#007373',
    '#c4c6cd',
  }
}

config.font = wezterm.font_with_fallback {
  'JetBrains Mono',
  'Nerd Fonts Symbols',
}

config.font_size = 13

return config
