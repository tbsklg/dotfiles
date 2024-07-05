local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'rose-pine'
config.font = wezterm.font_with_fallback {
  'JetBrains Mono',
  'Nerd Fonts Symbols',
}

return config
