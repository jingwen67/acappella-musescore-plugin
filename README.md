# Jingwen · 阿卡贝拉编曲助手

独立的 MuseScore 编曲与本地音频扒谱工具，由 Jingwen Zhang 开发。

- [MuseScore 插件](plugins/acappella-arranger/README.md)：建谱、多 Solo、音域检查、Bass 和弦及声部分配、节奏型补全。
- [本地音频扒谱](tools/audio-score-converter/README.md)：上传原唱，提取 Solo 与伴奏最低音，直接准备供 MuseScore 打开的乐谱。

本仓库不包含两个阿卡贝拉 Hub 网站，不部署到 Vercel。

## Mac 安装与更新

```bash
git clone https://github.com/jingwen67/acappella-musescore-plugin.git "$HOME/Documents/CUCAC-Plugins/acappella-musescore-plugin"
```

在 MuseScore 的「设置 → 文件夹 → Plugins」中，把扫描目录设为仓库内的实际 plugins 文件夹：

```text
/Users/你的用户名/Documents/CUCAC-Plugins/acappella-musescore-plugin/plugins
```

不用建立链接或复制插件文件。保存设置后，在首页 Plugins 点击 Reload plugins，启用「阿卡贝拉编曲助手 · Jingwen」。第一次配置后若未出现，完全退出并重新打开 MuseScore。

以后关闭 MuseScore，双击 `plugins/acappella-arranger/update.command` 即可从 GitHub 同步当前安装的代码；也可运行：

```bash
git -C "$HOME/Documents/CUCAC-Plugins/acappella-musescore-plugin" pull --ff-only
```

更新后重新打开 MuseScore。这里的同步由你主动运行，不会在写谱期间自动替换代码。原有复制版和链接版无需立即删除；切换扫描目录后请只启用新目录中的助手，避免重复入口。

音频工具与详细使用步骤见各工具的 README。

## 来源

从 `jingwen67/acappella-hub` 的 `main` 分支迁出，源提交 `466f329d3911ccd80cd266b53b38b7ec173ce1c1`。旧版本开发历史仍可在原仓库查看。
