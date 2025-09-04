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

config.color_scheme = "Rosé Pine (base16)"
config.enable_tab_bar = false
config.window_background_opacity = 1.0

config.font = wezterm.font_with_fallback({
	"JetBrains Mono",
	"Nerd Fonts Symbols",
})
config.font_size = 15
config.macos_window_background_blur = 30
config.adjust_window_size_when_changing_font_size = false

return config
