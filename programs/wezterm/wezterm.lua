local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "GruvboxDarkHard"

config.font = wezterm.font("JetBrainsMono NerdFont")
config.font_size = 13.3
config.line_height = 1.1

config.text_background_opacity = 1.0
config.window_background_opacity = 0.8
config.window_padding = {
	left = "0.5cell",
	right = "0.5cell",
	top = "0.5cell",
	bottom = 0,
}

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

config.enable_scroll_bar = true

config.disable_default_key_bindings = true
config.leader = {
	key = "Space",
	mods = "CTRL",
}
config.keys = {
	{ key = "F11", mods = "", action = wezterm.action.ToggleFullScreen },

	{ key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") },
	{ key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },
	{ key = "n", mods = "ALT|SHIFT", action = wezterm.action.SpawnTab("DefaultDomain") },
	{ key = "Comma", mods = "ALT|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },
	{ key = "Period", mods = "ALT|SHIFT", action = wezterm.action.ActivateTabRelative(1) },
	{ key = "Comma", mods = "LEADER", action = wezterm.action.MoveTabRelative(-1) },
	{ key = "Period", mods = "LEADER", action = wezterm.action.MoveTabRelative(1) },
	{ key = "1", mods = "LEADER", action = wezterm.action.ActivateTab(0) },
	{ key = "2", mods = "LEADER", action = wezterm.action.ActivateTab(1) },
	{ key = "3", mods = "LEADER", action = wezterm.action.ActivateTab(2) },
	{ key = "4", mods = "LEADER", action = wezterm.action.ActivateTab(3) },
	{ key = "5", mods = "LEADER", action = wezterm.action.ActivateTab(4) },
	{ key = "6", mods = "LEADER", action = wezterm.action.ActivateTab(5) },
	{ key = "7", mods = "LEADER", action = wezterm.action.ActivateTab(6) },
	{ key = "8", mods = "LEADER", action = wezterm.action.ActivateTab(7) },
	{ key = "9", mods = "LEADER", action = wezterm.action.ActivateTab(8) },

	{ key = "w", mods = "LEADER", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
	{
		key = "[",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "]",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{ key = "h", mods = "ALT|SHIFT", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "j", mods = "ALT|SHIFT", action = wezterm.action.ActivatePaneDirection("Down") },
	{ key = "k", mods = "ALT|SHIFT", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "l", mods = "ALT|SHIFT", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "UpArrow", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
	{ key = "DownArrow", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },
	{ key = "LeftArrow", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
	{ key = "RightArrow", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },
}

return config
