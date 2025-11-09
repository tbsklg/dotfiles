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
	{ key = "l", mods = "ALT", action = wezterm.action.ShowLauncher },
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
	{ key = "D", mods = "CTRL", action = wezterm.action.ShowDebugOverlay },
}

config.force_reverse_video_cursor = false
config.colors = {
	foreground = "#c5c5c5",
	background = "#18191a",
	cursor_bg = "#c5c5c5",
	cursor_fg = "#18191a",
	cursor_border = "#c5c5c5",
	selection_fg = "#c5c5c5",
	selection_bg = "#3c4048",

	scrollbar_thumb = "#3c4048",

	tab_bar = {
		background = "#18191a",
		active_tab = {
			bg_color = "#3c4048",
			fg_color = "#c5c5c5",
		},
		inactive_tab = {
			bg_color = "#18191a",
			fg_color = "#878787",
		},
		inactive_tab_hover = {
			bg_color = "#2a2b2c",
			fg_color = "#c5c5c5",
		},
		new_tab = {
			bg_color = "#18191a",
			fg_color = "#878787",
		},
		new_tab_hover = {
			bg_color = "#2a2b2c",
			fg_color = "#c5c5c5",
		},
	},

	ansi = {
		"#18191a", -- black
		"#d2788c", -- red (muted pink-red)
		"#a6cc70", -- green (muted sage green)
		"#e6b99d", -- yellow (muted peach)
		"#7c9fc9", -- blue (muted blue)
		"#b4a5d6", -- magenta (muted lavender)
		"#87c5a3", -- cyan (muted teal)
		"#c5c5c5", -- white
	},

	brights = {
		"#3c4048", -- bright black (dark gray)
		"#e8a5b5", -- bright red
		"#b8d17a", -- bright green
		"#f0c9a6", -- bright yellow
		"#8fb1d3", -- bright blue
		"#c4b5e0", -- bright magenta
		"#9dd1b0", -- bright cyan
		"#e0e0e0", -- bright white
	},
}

config.enable_tab_bar = true
config.window_decorations = "MACOS_FORCE_DISABLE_SHADOW | RESIZE"
config.native_macos_fullscreen_mode = true

config.font = wezterm.font_with_fallback({ "JetBrains Mono", "The font with those symbols" })

config.font_size = 14
config.adjust_window_size_when_changing_font_size = false

return config
