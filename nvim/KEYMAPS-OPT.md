# 快捷键配置优化方案

> 基于 LazyVim v16.0.1 + `lua/config/keymaps.lua` + `KEYMAPS.md`（2026-09-21 生成）
> 结论先行：整体键位覆盖已经很完整（469 条映射，发现/搜索/LSP/Git/测试均有），**不需要大改**。
> 真正值得做的是：修 4 个真实冲突/失效项（P0），精简 4 处冗余（P1），再做几处一致性与文档修正（P2）。

---

## P0：真实冲突 / 失效项（建议优先处理）

### 1. 插入模式 `<M-j>/<M-k>` 与 LazyVim「移动行」冲突，且 KEYMAPS.md 描述不符

- `keymaps.lua:25-26` 把插入模式 `<M-j>/<M-k>` 映射为 `<down>/<up>`（光标移动）。
- LazyVim 默认在插入模式有 `<A-j>/<A-k>` = 移动当前行（`LazyVim/lua/lazyvim/config/keymaps.lua:28-29`），用户配置后加载，**已将其覆盖**。
- 后果：n/v 模式 `<M-j>/<M-k>` 是移动行，i 模式却是移动光标——同键不同义；且 `KEYMAPS.md` 第 195 行写的「`<M-j>/<M-k>` n/i/v 移动行」与实际行为不符。

**建议（二选一）**：
- **A（推荐）**：保留现状（插入模式用 `<M-hjkl>` 移光标的手感更好），把 `KEYMAPS.md` 中移动行的模式改为 `n/v`。
- B：想两全的话，插入模式移动行改绑 `<M-S-j>/<M-S-k>`：
  ```lua
  map("i", "<M-S-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Line Down" })
  map("i", "<M-S-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Line Up" })
  ```

### 2. `<D-s>`（Cmd+S）在 kitty 下是死键

- kitty 默认不把 Cmd 组合键透传给终端内程序，`~/.config/kitty/kitty.conf` 中也没有针对 `cmd+s` 的透传映射。
- 因此 `keymaps.lua:19-20` 的 `<D-s>` 保存（n/i 模式）在 kitty 里**永远不会触发**，目前实际生效的保存键只有 `<C-s>` 和 `<M-s>`。

**建议（二选一）**：
- **A（推荐）**：kitty.conf 增加 `map cmd+s send_text all \x13`，让 Cmd+S 向 nvim 发送 Ctrl+S（即触发 LazyVim 的保存）。
- B：确认只在 GUI 客户端（neovide 等）使用 `<D-s>`，保留并在文档标注「仅 GUI 生效」。

### 3. 终端模式 `<C-\>` 吞掉了标准的 `<C-\><C-n>` 退出序列

- `keymaps.lua:192` 把 `t` 模式 `<C-\>` 映射为关闭终端。这导致标准的「终端模式回 normal」序列 `<C-\><C-n>` 无法输入——按下第一个 `<C-\>` 就直接把终端关了。
- snacks terminal 本身自带 `<C-\><C-n>` 支持。

**建议**：删掉 `t` 模式这条映射。隐藏/关闭终端用 normal 模式的 `<C-\>`（toggle）或 `<C-/>`；需要在终端里做 normal 操作时用 `<C-\><C-n>`。

### 4. `+` / `-` 绕过了 dial 的智能增减

- 已启用 `extras.editor.dial`：dial 接管 `<C-a>/<C-x>`，支持布尔、日期、字母、按文件类型切换增减规则（`LazyVim/.../extras/editor/dial.lua:20-23`）。
- 但 `keymaps.lua:32-33` 的 `+`→`<C-a>` 默认 `noremap=true`，**直接命中原生递增，dial 完全不参与**。

**建议**：改为 remap，让 `+`/`-` 与 `<C-a>/<C-x>` 行为完全一致（含 dial）：
```lua
map("n", "+", "<C-a>", { remap = true, desc = "Increment" })
map("n", "-", "<C-x>", { remap = true, desc = "Decrement" })
```

---

## P1：冗余项（二选一，删一套）

| # | 冗余 | 建议 |
|---|---|---|
| 1 | 分屏两套：自定义 `<leader>_` / `<leader>\` 与默认 `<leader>-` / `<leader>\|` | 保留自定义一套（`<leader>_` 不用按 shift，更顺手），删除默认：`vim.keymap.del("n", "<leader>-")`、`vim.keymap.del("n", "<leader>|")` |
| 2 | Tab 切换入口过多：`]<tab>`/`[<tab>`（=原生 `gt`/`gT`）、`<leader><tab>1..9`（=原生 `Ngt`，如 `3gt`）、`<leader>f<tab>` 选择器、默认 `<leader><tab>[/]` | 删掉 `]<tab>`/`[<tab>` 和 `<leader><tab>1..9` 循环（原生 `gt`/`gT`/`Ngt` 全覆盖），保留 `<leader>f<tab>` 选择器用于发现 |
| 3 | `<leader>u<tab>` 与自带 `<leader>uA`（KEYMAPS.md 自己也标注了重复） | 删掉自定义的 `<leader>u<tab>` |
| 4 | `<leader>O`（fzf-lua 符号）与 `<leader>ss`（snacks 符号）重复；fzf-lua 目前只为这一个键而加载 | 若无特别偏好 fzf 的符号 UI，删除后可整体减载一个插件；偏好则保留（`:FzfLua` 仍可用） |

另有两处「重复但无害」，可只做文档标注：`<leader>ghb`（gitsigns 行 blame）与 `<leader>gb`（snacks 行 blame）二选一；`<leader>lg` 与 `<leader>gg` 都是 LazyGit，保留其一即可。

---

## P2：一致性与可发现性（低优先级）

1. **VSCode 模式守卫**：已启用 `extras.vscode`，但 `keymaps.lua` 未做区分，`<C-e>`（全选）、`<C-c>`（整文件复制）、`<M-hjkl>`、`i<C-a>/<C-e>` 等会照常进入 vscode-neovim，可能与 VSCode 自身快捷键冲突。建议给桌面专属键加 `if not vim.g.vscode then ... end` 守卫。
2. **`<leader>ci` 命名不规则**：`cif`/`cic`/`ciL`/`cir` 中大写 L/R 夹在小写里，不易记。建议统一小写（`ciL`→`cil`）并注册组名，which-key 弹窗更清晰：
   ```lua
   require("which-key").add({ { "<leader>ci", group = "Tool Info" } })
   ```
3. **`<C-Space>`（Treesitter 增量选中）在 macOS 常被「选择输入源」系统快捷键拦截**。若在 kitty 里按了没反应：系统设置里关掉该快捷键，或改绑 `<A-Space>`。
4. **文档修正**：`KEYMAPS.md` 中 `<M-j>/<M-k>` 的模式标注（见 P0-1）、`<D-s>` 生效环境（见 P0-2）需要同步更新；任何删改后跑一遍 `<leader>sk` 抽查。

---

## 附：改动清单（可直接对照执行）

```lua
-- lua/config/keymaps.lua

-- P0-4：+/- 走 dial
- map("n", "+", "<C-a>")
- map("n", "-", "<C-x>")
+ map("n", "+", "<C-a>", { remap = true, desc = "Increment" })
+ map("n", "-", "<C-x>", { remap = true, desc = "Decrement" })

-- P0-3：删除终端模式 <C-\>（保留 normal 模式的 toggle）
- map("t", [[<c-\>]], "<cmd>close<cr>", { desc = "Hide Terminal" })

-- P1-2：删 tab 数字循环与 ]<tab>/[<tab>（原生 gt/gT/Ngt 已覆盖）
- map("n", "]<tab>", ...) / map("n", "[<tab>", ...)
- for i = 1, 9 do map("n", "<leader><tab>" .. i, ...) end

-- P1-3：删 <leader>u<tab>（与 <leader>uA 重复）
- map("n", "<leader>u<tab>", ...)

-- P1-1：删默认分屏键（保留自定义 <leader>_ / <leader>\）
+ vim.keymap.del("n", "<leader>-")
+ vim.keymap.del("n", "<leader>|")
```

```conf
# ~/.config/kitty/kitty.conf（P0-2 可选项）
map cmd+s send_text all \x13
```

## 验证方式

1. 改完重启或 `:Lazy reload` 后，`:verbose map +` 应显示经 `<C-a>` remap 到 dial；在日期上按 `+` 观察智能增减。
2. kitty 里按 Cmd+S 验证保存；终端内按 `<C-\><C-n>` 应进入终端 normal 而不是关闭窗口。
3. `:nmap <leader>-` 应报「No mapping found」（已删默认分屏键）。
4. 同步更新 `KEYMAPS.md` 对应条目。
