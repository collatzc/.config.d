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

-- 标签栏:红绿灯按钮集成进标签条,去掉原生标题栏,窗口顶部只留一条标签栏。
-- 注:集成按钮模式下标签条必须常驻(按钮画在标签条里),
-- hide_tab_bar_if_only_one_tab 对此模式无效,故不设置。
config.enable_tab_bar = true
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = true
config.tab_max_width = 32
-- 隐藏标签上的关闭按钮。该选项目前仅 nightly 版支持(20240203 稳定版没有),
-- 用 pcall 包裹:当前版本静默跳过,换 nightly 后自动生效
pcall(function()
	config.show_close_tab_button_in_tabs = false
end)

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.integrated_title_button_style = "MacOsNative"
config.native_macos_fullscreen_mode = true

-- 标签图标:按前台命令配 Nerd Font 图标,映射与 kitty 的 tab_bar.py 保持一致
local ICONS = {
	-- 编辑器
	nvim = "\u{e725}", vim = "\u{e725}", vi = "\u{e725}", view = "\u{e725}", vimdiff = "\u{e725}",
	-- Git
	git = "\u{e0a0}", lazygit = "\u{e0a0}", tig = "\u{e0a0}", gh = "\u{e0a0}", gitui = "\u{e0a0}",
	-- Python
	python = "\u{e606}", python3 = "\u{e606}", ipython = "\u{e606}", pip = "\u{e606}",
	pip3 = "\u{e606}", pipx = "\u{e606}", uv = "\u{e606}", uvx = "\u{e606}", pytest = "\u{e606}",
	-- Node / JS
	node = "\u{e718}", npm = "\u{e718}", npx = "\u{e718}", pnpm = "\u{e718}", yarn = "\u{e718}",
	bun = "\u{e718}", deno = "\u{e718}", tsc = "\u{e718}", tsx = "\u{e718}", vite = "\u{e718}",
	-- Go / Rust
	go = "\u{e626}", gofmt = "\u{e626}", cargo = "\u{e7a8}", rustc = "\u{e7a8}", rustup = "\u{e7a8}",
	-- 监控
	htop = "\u{f080}", btop = "\u{f080}", top = "\u{f080}", atop = "\u{f080}", btm = "\u{f080}",
	-- 文档
	man = "\u{f02d}", tldr = "\u{f02d}",
	-- 容器
	docker = "\u{f308}", ["docker-compose"] = "\u{f308}", lazydocker = "\u{f308}", colima = "\u{f308}",
	-- 数据库
	psql = "\u{e76e}", mysql = "\u{e76e}", sqlite3 = "\u{e76e}", mongosh = "\u{e76e}", ["redis-cli"] = "\u{e76e}",
	-- 构建
	make = "\u{f121}", cmake = "\u{f121}",
}

local REMOTE_COMMANDS = { ssh = true, mosh = true, scp = true, sftp = true, rsync = true, telnet = true }
local REMOTE_GLYPH = "\u{eba9}"
local SHELL_GLYPH = "\u{ea85}"
local SPLITS_GLYPH = "\u{f24d}"
local ZOOM_GLYPH = "\u{f065}"
-- 标题已自带图标前缀(某些工具设置)时原样显示,不再追加图标
local PASSTHROUGH_PREFIX = "\u{e6ae}"
-- python3.11 / cargo-nextest 这类带版本号或后缀的命令按前缀匹配
local BOUNDARY = "0123456789.-_+"

local function icon_for(title)
	local t = title:match("^%s*(.-)%s*$")
	if t == "" then
		return SHELL_GLYPH
	end
	if t:sub(1, #PASSTHROUGH_PREFIX) == PASSTHROUGH_PREFIX then
		return nil
	end
	local base = t:match("^%S+"):gsub("^.*/", "")
	if ICONS[base] then
		return ICONS[base]
	end
	for key, glyph in pairs(ICONS) do
		if base:sub(1, #key) == key then
			local c = base:sub(#key + 1, #key + 1)
			if c == "" or BOUNDARY:find(c, 1, true) then
				return glyph
			end
		end
	end
	if REMOTE_COMMANDS[base] or t:find("@", 1, true) then
		return REMOTE_GLYPH
	end
	return SHELL_GLYPH
end

wezterm.on("format-tab-title", function(tab, _tabs, _panes, _config, _hover, max_width)
	local title = tab.tab_title ~= "" and tab.tab_title or tab.active_pane.title
	local icon = icon_for(title)
	local text = icon and (icon .. " ") or ""
	if title ~= "" then
		text = text .. title
	end
	if tab.active_pane.is_zoomed then
		text = text .. " " .. ZOOM_GLYPH
	end
	local n = #tab.panes
	if n > 1 then
		text = text .. " " .. SPLITS_GLYPH .. n
	end
	return { { Text = wezterm.truncate_right(text, max_width) } }
end)

-- 毛玻璃:半透明 + 背景模糊
config.window_background_opacity = 0.80
config.macos_window_background_blur = 28

-- 内容四周留白,不顶着窗口边缘
config.window_padding = {
	left = "12px",
	right = "12px",
	top = "8px",
	bottom = "8px",
}

-- 回滚行数(默认 3500)
config.scrollback_lines = 10000

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
	-- 补齐 macOS 习惯的分屏/面板键(默认只有 Ctrl+Alt 系,不便按)
	{
		key = "d",
		mods = "SUPER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "d",
		mods = "SUPER|SHIFT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "Enter",
		mods = "SUPER|SHIFT",
		action = wezterm.action.TogglePaneZoomState,
	},
	{
		key = "LeftArrow",
		mods = "SUPER|ALT",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "RightArrow",
		mods = "SUPER|ALT",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "UpArrow",
		mods = "SUPER|ALT",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "DownArrow",
		mods = "SUPER|ALT",
		action = wezterm.action.ActivatePaneDirection("Down"),
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
