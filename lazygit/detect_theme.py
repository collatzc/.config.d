#!/usr/bin/env python3
"""查询终端背景色(OSC 11)判断明暗,输出 light 或 dark;终端无应答时输出 dark。

供 zsh 的 lg 函数调用:theme=$(detect_theme.py),据此选择 lazygit 主题文件。
wezterm / kitty 等现代终端都会应答 OSC 11,且应答的是当前生效配色(切过明暗后立即反映)。
"""

import os
import re
import select
import termios
import time
import tty


def main():
    fd = os.open("/dev/tty", os.O_RDWR)
    old = termios.tcgetattr(fd)
    try:
        tty.setraw(fd)
        os.write(fd, b"\x1b]11;?\x1b\\")  # OSC 11 查询:当前背景色
        buf = b""
        deadline = time.time() + 0.5
        while time.time() < deadline:
            r, _, _ = select.select([fd], [], [], 0.05)
            if not r:
                continue
            buf += os.read(fd, 256)
            if b"\x1b\\" in buf or b"\x07" in buf:
                break
    finally:
        termios.tcsetattr(fd, termios.TCSADRAIN, old)
        os.close(fd)

    m = re.search(rb"rgb:([0-9a-f]+)/([0-9a-f]+)/([0-9a-f]+)", buf, re.I)
    if not m:
        print("dark")
        return
    r, g, b = (int(m.group(i), 16) >> 8 for i in (1, 2, 3))
    lum = 0.2126 * r + 0.7152 * g + 0.0722 * b
    print("light" if lum >= 128 else "dark")


main()
