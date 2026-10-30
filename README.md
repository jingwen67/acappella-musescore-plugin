# Jingwen · 阿卡贝拉编曲助手

由 Jingwen Zhang 开发的 MuseScore 插件。当前 v0.9.0 只保留两项功能：

- 自动建谱：曲名、编曲者、调号、拍号、速度、多 Solo 及各自谱号；除 Beatbox 外默认 Piano。
- 音域检查：按声部自动标红超音域音符，每个 Solo 单独选择音域，支持清除选区或全谱标记。

Bass 配和弦、节奏样例补全与音频转谱网页工具已移除，后续重新设计。旧代码仍可从 Git 历史查看。本插件不部署到 Vercel。

## Mac 安装

需要 Git；当前原生建谱实现针对 MuseScore Studio 4.7.5，其他版本需实际验证。

```bash
mkdir -p "$HOME/Documents/CUCAC-Plugins"
git clone --branch main --single-branch https://github.com/jingwen67/acappella-musescore-plugin.git "$HOME/Documents/CUCAC-Plugins/acappella-musescore-plugin"
```

已有仓库时不用再次 clone。在 MuseScore → Settings／设置 → Folders／文件夹 → Plugins 中，选择仓库内的实际 `plugins` 文件夹：

```text
/Users/你的用户名/Documents/CUCAC-Plugins/acappella-musescore-plugin/plugins
```

不要复制或建立软链接。保存设置，在首页 Plugins 点击 Reload plugins，启用「阿卡贝拉编曲助手 · Jingwen」。必要时完全退出再重新打开 MuseScore。

## 更新

关闭 MuseScore，双击 `plugins/acappella-arranger/update.command`，或运行：

```bash
git -C "$HOME/Documents/CUCAC-Plugins/acappella-musescore-plugin" pull --ff-only
```

重开 MuseScore 即使用最新版。更新会同步当前实际安装的代码，无需复制文件，不会自动丢弃本地修改。

[功能说明与音域表](plugins/acappella-arranger/README.md)

## 来源

最初从 `jingwen67/acappella-hub` 的提交 `466f329d3911ccd80cd266b53b38b7ec173ce1c1` 迁出。此前历史在旧仓库，迁出后的历史在本仓库。两个 Hub 和 Workshop 页面继续在旧仓库维护。
