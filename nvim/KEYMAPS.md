# Nvim 快捷键速查表

> 基于 LazyVim v16.0.1 + 个人定制（`lua/config/keymaps.lua`、`lua/plugins/*.lua`）
> 生成方式：从运行时实际导出 469 条键位映射 + 源码逐一核对（2026-09-12）
>
> - `<leader>` = **空格键**，`<localleader>` = `\`
> - 任何前缀按完停一下，which-key 会弹出该前缀下所有可用键
> - 随时按 `<leader>sk` 可搜索所有键位
> - 标 🔧 的为个人自定义键位（非 LazyVim 默认）

## 一、个人自定义键位 🔧

### 保存
| 键位 | 说明 |
|---|---|
| `<M-s>` | 保存（跳过格式化） |
| `<D-s>` | 保存（带格式化，macOS Cmd+S，normal/insert 均可） |
| `<C-s>` | 保存（LazyVim 默认） |

### Buffer / Tab
| 键位 | 说明 |
|---|---|
| `<BS>` | 当前 buffer ↔ 上一个编辑的 buffer 来回切换（`b#`） |
| `<M-1>` ~ `<M-9>` | 跳到第 1~9 个 buffer（bufferline） |
| `H` / `L` | 上一个 / 下一个 buffer |
| `Q` | 卸载当前 buffer（`<S-q>`） |
| `<leader>bf` / `<leader>ba` | 第一个 / 最后一个 buffer |
| `<leader>b<Tab>` | 当前 buffer 移入新标签页 |
| `<leader>.` | buffer 选择模式（bufferline pick） |
| `<leader>bS` / `<leader>bs` | buffer 按目录 / 扩展名排序 |
| `<Space><` / `<Space>>` | 左移 / 右移 buffer 位置 |
| `]<Tab>` / `[<Tab>` | 下一个 / 上一个标签页 |
| `<leader><Tab>1`~`9` | 跳到第 N 个标签页 |
| `<leader>f<Tab>` | 标签页选择器（显示各页文件名） |
| `<leader>uS` | 开关状态栏 |
| `<leader>u<Tab>` | 开关标签栏（LazyVim 自带 `<leader>uA` 同功能，二选一即可） |

### 编辑与移动
| 键位 | 模式 | 说明 |
|---|---|---|
| `E` | n | 跳回上一个词尾（`ge`） |
| `+` / `-` | n | 数字 +1 / -1（代替 `<C-a>`/`<C-x>`） |
| `U` | n | 重做（`<C-r>`） |
| `<C-e>` | n | 全选 |
| `<C-c>` | n | 复制整个文件到系统剪贴板 |
| `dd` | n | 删除空行时不写入寄存器 |
| `<A-d>` / `<A-c>` | n/v/x | 删除 / 修改且不写入寄存器 |
| `p` | v | 粘贴且不覆盖寄存器 |
| `dm` | n | 删除当前行上的 mark |
| `gO` / `go` | n | 在上 / 下方插入空行（不动光标） |
| `<M-h>/<M-l>/<M-j>/<M-k>` | i | 插入模式下移动光标 |
| `<C-a>` / `<C-e>` | i | 行首 / 行尾 |
| `<C-a>` | c | 命令行行首 |
| `<C-v>` | i | 粘贴默认寄存器 |
| `*` / `#` | v | 向下 / 向上搜索选中文本 |
| `g/` | v | 在选区范围内搜索 |
| `]/` / `[/` | n | 下一个 / 上一个块注释（`╭` 开头） |

### 文件 / 搜索 / Git / 其他
| 键位 | 说明 |
|---|---|
| `<leader>?` | 用 Brave 搜索光标下的词 |
| `<leader>R` | 全局替换光标下的词 |
| `<leader>O` | fzf-lua：文档符号列表 |
| `<leader>ghb` | 行级 blame（Snacks 浮窗，覆盖了 gitsigns 默认） |
| `<leader>lg` / `<leader>gl` | LazyGit / LazyGit 日志 |
| `<leader>gbb` | Git 分支选择器 |
| `<leader>fd` | Dashboard 首页 |
| `<leader>!` / `<leader>@` | 加入 / 移出拼写词典 |
| `<C-\>` / `<C-\_>` | 打开浮动终端（root 目录）；终端内 `<C-\>` 隐藏 |
| `<leader>_` / `<leader>\` | 下方 / 右侧分屏 |
| `<leader>cif` / `<leader>cic` / `<leader>ciL` / `<leader>cir` | 格式化信息 / Conform 信息 / 当前 Linter / 项目根目录 |

## 二、Git（gitsigns + snacks）

### Hunk 跳转（打开 git 仓库文件后生效）
| 键位 | 说明 |
|---|---|
| `]h` / `[h` | 下一个 / 上一个修改块（支持计数如 `3]h`；diff 分屏中自动变为 `]c`/`[c`） |
| `]H` / `[H` | 最后一个 / 第一个修改块 |
| `ih` | v/o 模式：选中整个 hunk（如 `vih`、`dih`） |

### Hunk 操作
| 键位 | 说明 |
|---|---|
| `<leader>ghp` | 预览当前 hunk |
| `<leader>ghs` / `<leader>ghr` | 暂存 / 撤销暂存当前 hunk |
| `<leader>ghS` / `<leader>ghR` | 暂存 / 重置整个 buffer |
| `<leader>ghu` | 撤销 stage |
| `<leader>ghd` / `<leader>ghD` | 与索引 / 与上次提交 diff |
| `<leader>ghB` | 整个 buffer 的 blame 视图 |

### 仓库级（snacks picker / lazygit）
| 键位 | 说明 |
|---|---|
| `<leader>gg` / `<leader>gG` | LazyGit（项目根 / 当前目录） |
| `<leader>gl` / `<leader>gL` | LazyGit 日志 / 当前仓库提交历史 |
| `<leader>gf` | 当前文件历史 |
| `<leader>gd` | Git diff（文件列表） |
| `<leader>gs` | Git status |
| `<leader>gc` | 提交列表 |
| `<leader>gb` / `<leader>gB` | 行 blame / 在浏览器打开 GitHub |
| `<leader>gY` | 复制 GitHub 链接 |
| `<leader>gS` | Git stash |

## 三、文件与搜索（snacks picker）

| 键位 | 说明 |
|---|---|
| `<leader><Space>` | 智能找文件（最常用） |
| `<leader>ff` / `<leader>fF` | 找文件（项目根 / 当前目录） |
| `<leader>fg` | 在 git 管理的文件中找 |
| `<leader>fr` / `<leader>fR` | 最近文件（全部 / 当前目录） |
| `<leader>fb` / `<leader>fB` | buffer 列表（当前 / 全部） |
| `<leader>fc` | 找配置文件 |
| `<leader>fn` | 新建文件 |
| `<leader>e` / `<leader>E` | 文件树（项目根 / 当前目录） |
| `<leader>fm` / `<leader>fM` | mini.files（当前文件 / 当前目录） |
| `<leader>/` | 全文搜索（项目根） |
| `<leader>:` | 命令历史 |
| `<leader>n` | 通知历史 |

## 四、搜索器（`<leader>s` 前缀）

| 键位 | 说明 |
|---|---|
| `<leader>sg` / `<leader>sG` | 全文搜索（项目根 / 当前目录） |
| `<leader>sw` / `<leader>sW` | 搜光标词（项目根 / 当前目录） |
| `<leader>ss` / `<leader>sS` | 跳符号（当前文件 / 工作区） |
| `<leader>sk` / `<leader>sj` | 搜键位 / 跳转列表 |
| `<leader>sh` / `<leader>sc` | 帮助页 / 命令历史 |
| `<leader>sr` | 搜索并替换 |
| `<leader>sR` | 恢复上次搜索 |
| `<leader>sq` / `<leader>sl` | quickfix / location 列表 |
| `<leader>sd` / `<leader>sD` | 诊断（工作区 / 当前 buffer） |
| `<leader>st` / `<leader>sT` | TODO 注释（当前文件 / 全部） |
| `<leader>sm` / `<leader>s"` / `<leader>s/` | mark / 寄存器 / 搜索历史 |
| `<leader>sC` / `<leader>sH` / `<leader>sM` / `<leader>sa` | 命令 / 高亮组 / man 页 / autocmd |
| `<leader>snd` / `<leader>snh` / `<leader>snl` | 清除通知 / 通知历史 / 最近消息 |

## 五、LSP 与代码

### 跳转与信息（LSP 附加后生效）
| 键位 | 说明 |
|---|---|
| `gd` / `gD` / `gI` / `gy` | 定义 / 声明 / 实现 / 类型定义 |
| `K` / `gK`（插入模式 `<C-k>`） | 悬浮文档 / 签名帮助 |
| `gra` / `grn` | 代码操作 / 重命名 |
| `grr` / `gri` / `grt` / `grx` | 引用 / 实现 / 类型定义 / CodeLens |
| `<C-Space>` | n/v：Treesitter 增量选中 |

### 代码操作（`<leader>c` 前缀）
| 键位 | 说明 |
|---|---|
| `<leader>ca` / `<leader>cA` | 代码操作 / 源码操作 |
| `<leader>cr` / `<leader>cR` | 重命名符号 / 重命名文件 |
| `<leader>cd` | 行诊断浮窗 |
| `<leader>cf` / `<leader>cF` | 格式化 / 格式化注入语言 |
| `<leader>cs` / `<leader>cS` | 符号列表（Trouble）/ 引用定义列表（Trouble） |
| `<leader>cm` | Mason（LSP/DAP 工具管理） |

## 六、诊断、TODO 与快速修复

| 键位 | 说明 |
|---|---|
| `]d` / `[d` | 下一个 / 上一个诊断 |
| `]e` / `[e`，`]w` / `[w` | 下/上一个错误、警告 |
| `]D` / `[D` | 最后 / 第一个诊断 |
| `<C-W>d` | 光标处诊断浮窗 |
| `<leader>xx` / `<leader>xX` | 诊断列表（全部 / 当前 buffer，Trouble） |
| `<leader>xq` / `<leader>xl` | quickfix / location 列表 |
| `]q` / `[q`，`]Q` / `[Q` | quickfix 上/下、首/尾 |
| `]l` / `[l`，`]L` / `[L` | location list 上/下、首/尾 |
| `<leader>xt` / `<leader>xT` | TODO 列表（当前文件 / 全部） |

## 七、窗口与布局

| 键位 | 说明 |
|---|---|
| `<C-h>/<C-j>/<C-k>/<C-l>` | 窗口间跳转（左/下/上/右） |
| `<leader>-` / `<leader>|` | 下方 / 右侧分屏 |
| `<leader>wd` | 关闭窗口 |
| `<leader>wm` | 窗口最大化（zoom） |
| `<C-Up>/<C-Down>` | 增 / 减窗口高度 |
| `<C-Right>/<C-Left>` | 增 / 减窗口宽度 |
| `<C-W>d` | 光标处诊断 |

## 八、移动、搜索与文本对象

| 键位 | 模式 | 说明 |
|---|---|---|
| `s` / `S` | n/v | Flash 跳转（快速屏幕内移动）/ Treesitter 节点跳转 |
| `R` | v | Treesitter 搜索 |
| `j` / `k` | n/v | 显示行移动（wrap 友好） |
| `<M-j>` / `<M-k>` | n/i/v | 下移 / 上移当前行（含自动缩进） |
| `n` / `N` | n/v | 下 / 上一个搜索结果（居中） |
| `gc` / `gcc` / `gco` / `gcO` | n/v | 切换注释 / 行注释 / 下方加注释 / 上方加注释 |
| `[<Space>` / `]<Space>` | n | 上 / 下方加空行 |
| `[y` / `]y` | n | yank 历史向前 / 向后循环 |
| `<leader>p` | n/v | yank 历史选择器 |
| `a` / `i` 系列 | v | mini.ai 文本对象（如 `af`/`if` 函数、`a"`/`i"` 引号） |
| `g[` / `g]` | n/v | 移到"周围"文本对象左 / 右侧 |
| `]n` / `[n`，`]N` / `[N` | v | 下/上一个 treesitter 节点、兄弟节点 |
| `g<C-a>` / `g<C-x>` | n/v | 递增 / 递减多行序列数字 |
| `<C-s>` | c | 切换 Flash 搜索（命令行 `/` 中可用） |
| `<Esc>` | n/i/v | 清除搜索高亮 |

## 九、UI 开关（`<leader>u` 前缀）

| 键位 | 说明 |
|---|---|
| `<leader>uf` / `<leader>uF` | 自动格式化（全局 / 当前 buffer） |
| `<leader>ud` / `<leader>uh` | 开关诊断 / Inlay Hints |
| `<leader>ul` / `<leader>uL` | 行号 / 相对行号 |
| `<leader>us` / `<leader>uw` | 拼写 / 自动换行 |
| `<leader>ub` / `<leader>uC` | 深浅色切换 / 配色预览 |
| `<leader>uz` / `<leader>uZ` | Zen 模式 / Zoom 模式 |
| `<leader>uD` / `<leader>ua` | 窗口变暗（vimade）/ 动画 |
| `<leader>ug` / `<leader>uc` | 缩进参考线 / conceal |
| `<leader>un` / `<leader>ur` | 清除通知 / 重绘清高亮 |
| `<leader>ui` / `<leader>uI` | 检查光标高亮组 / Treesitter 语法树 |
| `<leader>uT` | Treesitter 高亮开关 |

## 十、会话、测试与杂项

| 键位 | 说明 |
|---|---|
| `<leader>qs` / `<leader>qS` | 恢复 / 选择会话 |
| `<leader>ql` / `<leader>qd` / `<leader>qq` | 恢复上次会话 / 不保存退出会话 / 退出 |
| `<leader>tt` / `<leader>tT` | 运行当前文件 / 全部测试文件（neotest） |
| `<leader>tr` / `<leader>tl` | 运行最近的 / 上一个测试 |
| `<leader>ts` / `<leader>to` / `<leader>tO` | 测试面板 / 输出 / 输出面板 |
| `<leader>tS` / `<leader>ta` / `<leader>tw` | 停止 / 附加调试 / watch |
| `<leader>dpp` / `<leader>dps` / `<leader>dph` | 性能分析器开关 / scratch / 高亮 |
| `<leader>D` | 数据库 UI（DBUI） |
| `<leader>S` | scratch buffer |
| `gx` | 用系统程序打开光标下的链接 / 文件 |
| `<leader>K` | 查关键词（man/帮助） |
| `<C-/>` / `<leader>ft` | 终端（root 目录） |

## 附：插入模式补充

| 键位 | 说明 |
|---|---|
| `<Tab>` / `<S-Tab>` | 跳到代码片段下一个 / 上一个占位 |
| `<C-s>` | 保存 |
| mini.pairs | 括号引号自动配对，插入模式输入即生效 |
