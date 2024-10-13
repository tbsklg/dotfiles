local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.enable_tab_bar = false
config.color_scheme = 'Gruvbox dark, hard (base16)'

config.font = wezterm.font_with_fallback {
  'JetBrains Mono',
  'Nerd Fonts Symbols',
}
config.font_size = 15

return config
