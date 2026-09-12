# vim:fileencoding=utf-8:ft=python
# kitty 标签页图标：根据前台命令给标签配 Nerd Font 图标。
# 由 kitty.conf 中 tab_title_template 的 {custom} 调用（kitty 0.43+ 内置机制，
# 即 kitty.tab_bar.load_custom_draw_title）。出错时 kitty 自动回退为原始标题。

# 标题已自带图标前缀（由某些工具设置）时原样显示，不再追加图标
_PASSTHROUGH_PREFIX = '\ue6ae'

_ICONS = {
    # 编辑器
    'nvim': '\ue725', 'vim': '\ue725', 'vi': '\ue725', 'view': '\ue725', 'vimdiff': '\ue725',
    # Git
    'git': '\ue0a0', 'lazygit': '\ue0a0', 'tig': '\ue0a0', 'gh': '\ue0a0', 'gitui': '\ue0a0',
    # Python
    'python': '\ue606', 'python3': '\ue606', 'ipython': '\ue606', 'pip': '\ue606',
    'pip3': '\ue606', 'pipx': '\ue606', 'uv': '\ue606', 'uvx': '\ue606', 'pytest': '\ue606',
    # Node / JS
    'node': '\ue718', 'npm': '\ue718', 'npx': '\ue718', 'pnpm': '\ue718', 'yarn': '\ue718',
    'bun': '\ue718', 'deno': '\ue718', 'tsc': '\ue718', 'tsx': '\ue718', 'vite': '\ue718',
    # Go / Rust
    'go': '\ue626', 'gofmt': '\ue626', 'cargo': '\ue7a8', 'rustc': '\ue7a8', 'rustup': '\ue7a8',
    # 监控
    'htop': '\uf080', 'btop': '\uf080', 'top': '\uf080', 'atop': '\uf080', 'btm': '\uf080',
    # 文档
    'man': '\uf02d', 'tldr': '\uf02d',
    # 容器
    'docker': '\uf308', 'docker-compose': '\uf308', 'lazydocker': '\uf308', 'colima': '\uf308',
    # 数据库
    'psql': '\ue76e', 'mysql': '\ue76e', 'sqlite3': '\ue76e', 'mongosh': '\ue76e', 'redis-cli': '\ue76e',
    # 构建
    'make': '\uf121', 'cmake': '\uf121',
}

# 远程类命令 + SSH 空闲标题（user@host:~）都算远程
_REMOTE_COMMANDS = {'ssh', 'mosh', 'scp', 'sftp', 'rsync', 'telnet'}
_REMOTE_GLYPH = '\ueba9'
_SHELL_GLYPH = '\uea85'
_SPLITS_GLYPH = '\uf24d'

# python3.11 / gh-dash / cargo-nextest 这类带版本号或后缀的命令按前缀匹配
_BOUNDARY = set('0123456789.-_+')


def _icon(title: str) -> str:
    t = title.strip()
    if not t:
        return _SHELL_GLYPH
    if t[0] == _PASSTHROUGH_PREFIX:
        return ''
    base = t.split()[0].rsplit('/', 1)[-1]
    if base in _ICONS:
        return _ICONS[base]
    for key in _ICONS:
        if base.startswith(key) and (len(base) == len(key) or base[len(key)] in _BOUNDARY):
            return _ICONS[key]
    if base in _REMOTE_COMMANDS or '@' in t:
        return _REMOTE_GLYPH
    return _SHELL_GLYPH


def draw_title(data: dict) -> str:
    title = data.get('title') or ''
    icon = _icon(title)
    parts = [icon] if icon else []
    if title:
        parts.append(title)
    # 分屏时在末尾标注窗口数，一眼看出该标签内有多个窗格
    n = data.get('num_windows') or 1
    if n > 1:
        parts.append(f'{_SPLITS_GLYPH}{n}')
    return ' '.join(parts) if parts else _SHELL_GLYPH
