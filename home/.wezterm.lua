local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Tokyo Night 明暗两套,光标统一为荧光绿
local schemes = {
	dark = wezterm.color.get_builtin_schemes()["Tokyo Night Storm"],
	light = wezterm.color.get_builtin_schemes()["Tokyo Night Day"],
}
for _, scheme in pairs(schemes) do
	scheme.cursor_bg = "#47FF9C"
	scheme.cursor_border = "#47FF9C"
end
config.color_schemes = {
	my_colorscheme_dark = schemes.dark,
	my_colorscheme_light = schemes.light,
}
config.color_scheme = "my_colorscheme_dark"

-- 标题栏/标签页配色直接取自当前主题,明暗切换时窗口 chrome 一起跟着变
local function window_frame(scheme)
	return {
		font = wezterm.font({ family = "SF Pro Text", weight = "Regular" }),
		font_size = 13.0,

		active_titlebar_bg = scheme.ansi[1],
		inactive_titlebar_bg = scheme.ansi[1],
	}
end

local function tab_colors(scheme)
	return {
		background = scheme.ansi[1],
		active_tab = {
			bg_color = scheme.brights[5],
			fg_color = scheme.background,
		},
		inactive_tab = {
			bg_color = scheme.ansi[1],
			fg_color = scheme.ansi[8],
		},
		inactive_tab_hover = {
			bg_color = scheme.ansi[7],
			fg_color = scheme.background,
		},
		new_tab = {
			bg_color = scheme.ansi[1],
			fg_color = scheme.ansi[8],
		},
		new_tab_hover = {
			bg_color = scheme.ansi[7],
			fg_color = scheme.background,
			italic = false,
		},
	}
end

config.window_frame = window_frame(schemes.dark)
config.colors = { tab_bar = tab_colors(schemes.dark) }

config.font = wezterm.font("Maple Mono NF CN")
config.harfbuzz_features = { "zero" }
config.font_size = 15

config.front_end = "WebGpu"

config.cursor_thickness = "200%"
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 300

-- 原生圆角标签栏,替代自绘 powerline 标签
config.enable_tab_bar = true
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true
config.tab_max_width = 32

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.integrated_title_button_style = "MacOsNative"
config.native_macos_fullscreen_mode = true

-- 毛玻璃:半透明 + 背景模糊
config.window_background_opacity = 0.80
config.macos_window_background_blur = 28

-- 内容四周留白,不顶着窗口边缘
config.window_padding = {
	left = "10px",
	right = "10px",
	top = "4px",
	bottom = "6px",
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

local function scheme_key(name)
	if name:find("dark") then
		return "dark"
	end
	return "light"
end

-- 配色和窗口 chrome 一起下发,避免出现"浅色内容 + 深色标题栏"
local function apply_scheme(window, scheme_name)
	local overrides = window:get_config_overrides() or {}
	if overrides.color_scheme == scheme_name and overrides.colors then
		return
	end
	local scheme = schemes[scheme_key(scheme_name)]
	overrides.color_scheme = scheme_name
	overrides.window_frame = window_frame(scheme)
	overrides.colors = { tab_bar = tab_colors(scheme) }
	window:set_config_overrides(overrides)
end

wezterm.on("window-config-reloaded", function(window, _pane)
	apply_scheme(window, scheme_for_appearance(window:get_appearance()))
end)

wezterm.on("toggle-color-scheme", function(window, _pane)
	local overrides = window:get_config_overrides() or {}
	local current = overrides.color_scheme or config.color_scheme
	if scheme_key(current) == "dark" then
		apply_scheme(window, "my_colorscheme_light")
	else
		apply_scheme(window, "my_colorscheme_dark")
	end
end)

config.enable_kitty_keyboard = true
config.enable_csi_u_key_encoding = false

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

return config
