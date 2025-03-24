local wezterm = require("wezterm")
local config = wezterm.config_builder()

local my_colorscheme_dark = wezterm.color.get_builtin_schemes()["Tokyo Night Storm"]
my_colorscheme_dark.cursor_bg = "#47FF9C"
my_colorscheme_dark.cursor_border = "#47FF9C"
local my_colorscheme_light = wezterm.color.get_builtin_schemes()["Tokyo Night Day"]
my_colorscheme_light.cursor_bg = "#47FF9C"
my_colorscheme_light.cursor_border = "#47FF9C"

config.color_schemes = {
	["my_colorscheme_dark"] = my_colorscheme_dark,
	["my_colorscheme_light"] = my_colorscheme_light,
}
config.color_scheme = "my_colorscheme_dark"

local TAB_BAR_BG = config.color_schemes[config.color_scheme].ansi[1]
local ACTIVE_TAB_BG = config.color_schemes[config.color_scheme].brights[5]
local ACTIVE_TAB_FG = config.color_schemes[config.color_scheme].background
local HOVER_TAB_BG = config.color_schemes[config.color_scheme].ansi[7]
local HOVER_TAB_FG = config.color_schemes[config.color_scheme].background
local NORMAL_TAB_BG = config.color_schemes[config.color_scheme].ansi[1]
local NORMAL_TAB_FG = config.color_schemes[config.color_scheme].ansi[8]

-- Catppuccin Macchiato
config.colors = {
	tab_bar = {
		background = TAB_BAR_BG,
	},
}

config.font = wezterm.font("Maple Mono NF CN")
config.harfbuzz_features = { "zero" }
config.font_size = 12

config.cursor_thickness = "200%"
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 300

config.enable_tab_bar = true
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_max_width = 64

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

wezterm.on("format-tab-title", function(tab, tabs, panes, _config, hover, max_width)
	local background = NORMAL_TAB_BG
	local foreground = NORMAL_TAB_FG

	local is_first = tab.tab_id == tabs[1].tab_id
	local is_last = tab.tab_id == tabs[#tabs].tab_id

	if tab.is_active then
		background = ACTIVE_TAB_BG
		foreground = ACTIVE_TAB_FG
	elseif hover then
		background = HOVER_TAB_BG
		foreground = HOVER_TAB_FG
	end

	local leading_fg = NORMAL_TAB_FG
	local leading_bg = background

	local trailing_fg = background
	local trailing_bg = NORMAL_TAB_BG

	if is_first then
		if tab.is_active then
			leading_fg = ACTIVE_TAB_BG
		else
			leading_fg = background
		end
	else
		leading_fg = NORMAL_TAB_BG
	end

	if is_last then
		if tab.is_active then
			trailing_fg = ACTIVE_TAB_BG
		end
		trailing_bg = TAB_BAR_BG
	else
		trailing_bg = NORMAL_TAB_BG
	end

	local title = tab.active_pane.title
	local titleIcon = " " .. wezterm.nerdfonts.cod_terminal .. " "
	if wezterm.truncate_right(title, 1) == "" then
		titleIcon = " "
	end
	if string.find(title, "@", 1, true) then
		titleIcon = " " .. wezterm.nerdfonts.cod_remote_explorer .. " "
	end

	return {
		{ Attribute = { Italic = tab.is_active and true or false } },
		{ Attribute = { Intensity = tab.is_active and "Bold" or "Normal" } },
		{ Background = { Color = leading_bg } },
		{ Foreground = { Color = leading_fg } },
		{ Text = SOLID_RIGHT_ARROW },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = titleIcon .. title .. " " },
		{ Background = { Color = trailing_bg } },
		{ Foreground = { Color = trailing_fg } },
		{ Text = SOLID_RIGHT_ARROW },
	}
end)

config.tab_bar_style = {
	new_tab = wezterm.format({
		{ Background = { Color = HOVER_TAB_BG } },
		{ Foreground = { Color = TAB_BAR_BG } },
		{ Text = SOLID_RIGHT_ARROW },
		{ Background = { Color = HOVER_TAB_BG } },
		{ Foreground = { Color = HOVER_TAB_FG } },
		{ Text = " " .. wezterm.nerdfonts.cod_empty_window .. "  " },
		{ Background = { Color = TAB_BAR_BG } },
		{ Foreground = { Color = HOVER_TAB_BG } },
		{ Text = SOLID_RIGHT_ARROW },
	}),
	new_tab_hover = wezterm.format({
		{ Attribute = { Italic = false } },
		{ Attribute = { Intensity = "Bold" } },
		{ Background = { Color = NORMAL_TAB_BG } },
		{ Foreground = { Color = TAB_BAR_BG } },
		{ Text = SOLID_RIGHT_ARROW },
		{ Background = { Color = NORMAL_TAB_BG } },
		{ Foreground = { Color = NORMAL_TAB_FG } },
		{ Text = " " .. wezterm.nerdfonts.cod_empty_window .. "  " },
		{ Background = { Color = TAB_BAR_BG } },
		{ Foreground = { Color = NORMAL_TAB_BG } },
		{ Text = SOLID_RIGHT_ARROW },
	}),
}

config.enable_kitty_keyboard = true
config.enable_csi_u_key_encoding = false

config.window_decorations = "RESIZE"
config.native_macos_fullscreen_mode = true
config.window_background_opacity = 0.85
config.macos_window_background_blur = 10
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.inactive_pane_hsb = {
	saturation = 0.5,
	brightness = 0.5,
}

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "my_colorscheme_dark"
	else
		return "my_colorscheme_light"
	end
end

wezterm.on("window-config-reloaded", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	local scheme = scheme_for_appearance(window:get_appearance())
	if overrides.color_scheme ~= scheme then
		overrides.color_scheme = scheme
		window:set_config_overrides(overrides)
	end
end)

wezterm.on("toggle-color-scheme", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if overrides.color_scheme == "my_colorscheme_dark" then
		overrides.color_scheme = "my_colorscheme_light"
	else
		overrides.color_scheme = "my_colorscheme_dark"
	end
	window:set_config_overrides(overrides)
end)

config.leader = { key = "p", mods = "SUPER", timeout_milliseconds = 1000 }
config.keys = {
	{
		key = "t",
		mods = "LEADER",
		action = wezterm.action({ EmitEvent = "toggle-color-scheme" }),
	},
	{
		key = "Enter",
		mods = "SUPER",
		action = wezterm.action.SplitVertical({
			domain = "CurrentPaneDomain",
		}),
	},
	{
		key = "x",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		key = "Tab",
		mods = "CTRL",
		action = wezterm.action.ActivateLastTab,
	},
}

config.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "SUPER",
		action = wezterm.action.StartWindowDrag,
	},
}

-- and finally, return the configuration to wezterm
return config
