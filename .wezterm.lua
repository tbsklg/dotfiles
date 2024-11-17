local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	{
		key = "|",
		mods = "LEADER",
		action = wezterm.action.SplitPane({
			direction = "Right",
			size = { Percent = 50 },
		}),
	},
	{
		key = "-",
		mods = "LEADER",
		action = wezterm.action.SplitPane({
			direction = "Down",
			size = { Percent = 50 },
		}),
	},
	{
		key = "9",
		mods = "LEADER",
		action = act.ShowLauncherArgs({
			flags = "FUZZY|WORKSPACES",
		}),
	},
	{
		key = "t",
		mods = "SHIFT|ALT",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "m",
		mods = "LEADER",
		action = wezterm.action.TogglePaneZoomState,
	},
	{ key = "H", mods = "CTRL", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
	{ key = "J", mods = "CTRL", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
	{ key = "K", mods = "CTRL", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
	{ key = "L", mods = "CTRL", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
	{ key = "i", mods = "CTRL|SHIFT", action = act.SwitchToWorkspace },
	{ key = "n", mods = "CTRL", action = act.SwitchWorkspaceRelative(1) },
	{ key = "p", mods = "CTRL", action = act.SwitchWorkspaceRelative(-1) },
	{
		key = "h",
		mods = "LEADER",
		action = act.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "j",
		mods = "LEADER",
		action = act.AdjustPaneSize({ "Down", 5 }),
	},
	{ key = "k", mods = "LEADER", action = act.AdjustPaneSize({ "Up", 5 }) },
	{
		key = "l",
		mods = "LEADER",
		action = act.AdjustPaneSize({ "Right", 5 }),
	},
	{
		key = "n",
		mods = "SHIFT|CTRL",
		action = wezterm.action.ToggleFullScreen,
	},
	{ key = "L", mods = "CTRL", action = wezterm.action.ShowDebugOverlay },
}

config.enable_tab_bar = false
config.colors = {
	indexed = {
		[16] = "#ffa066",
		[17] = "#ff5d62",
	},
	foreground = "#dcd7ba",
	background = "#1f1f23",
	cursor_bg = "#dcd7ba",
	cursor_border = "#dcd7ba",
	cursor_fg = "#1f1f23",
	selection_bg = "#2d4f67",
	selection_fg = "#c8c093",

	ansi = {
		"#090618", -- black
		"#c34043", -- red
		"#76946a", -- green
		"#c0a36e", -- yellow
		"#7e9cd8", -- blue
		"#957fb8", -- magenta
		"#6a9589", -- cyan
		"#c8c093", -- white
	},

	brights = {
		"#727169", -- black
		"#e82424", -- red
		"#98bb6c", -- green
		"#e6c384", -- yellow
		"#7fb4ca", -- blue
		"#938aa9", -- magenta
		"#7aa89f", -- cyan
		"#dcd7ba", -- white
	},
}
config.window_background_opacity = 0.9

config.font = wezterm.font_with_fallback({
	"JetBrains Mono",
	"Nerd Fonts Symbols",
})
config.font_size = 15

return config
