# AGENTS.md

本仓库是 Windows 下从 `%USERPROFILE%\.config\nvim` 加载的个人 Neovim 配置。纯 Lua，没有构建系统、测试、CI、linter 或 formatter 配置——不要臆造这些命令。

## 目录结构与加载方式

- `init.lua` 先启用 `vim.loader`，再按 `options`、`keymaps`、`autocmds`、`plugins` 的顺序 require 对应模块。新增配置请写进这些模块，不要继续往 `init.lua` 里堆。
- `lua/` 已在 `runtimepath` 中，因此 `require('options')` 会解析到 `lua/options.lua`；不要写成 `require('lua.options')`。
- 插件由 Neovim 内置的 `vim.pack` 管理：在 `lua/plugins/init.lua` 中用 `vim.pack.add()` 声明并安装，更新插件执行 `:lua vim.pack.update()` 后重启。`nvim-pack-lock.json` 由 vim.pack 生成并锁定版本，禁止手改，但必须提交。
- `lua/plugins/` 下的模块不会被自动加载，必须在 `lua/plugins/init.lua` 中显式 `require('plugins.xxx')`。
- 此处的 Neovim 为 v0.12.x，使用 LuaJIT（Lua 5.1）：不支持 `//`、位运算符以及仅 5.3 才有的语法。
- 数据目录为 `stdpath('data')`（`%LOCALAPPDATA%\nvim-data`），插件安装在其中的 `site/pack/core/opt/`，均不在本仓库内。请使用 `stdpath()`/`vim.fn.expand()`，不要硬编码 Unix 路径。

## 验证修改

- 完整加载配置：`nvim --headless +qa 2>&1`——正常时应无任何输出。
- 即使 `init.lua` 抛错，Neovim 也会以 **0** 退出，所以退出码说明不了任何问题；要在输出中查找 `Error` 或 `E\d+:`。
- 只检查单个模块：`nvim --headless -u NONE -c "luafile lua/keymaps.lua" -c qa 2>&1`。
- 没有热重载机制；修改后需重启 Neovim 才会生效。
