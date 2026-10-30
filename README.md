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

## 自动更新（Mac，设置一次）

先关闭 MuseScore，在终端运行一次：

```bash
git -C "$HOME/Documents/CUCAC-Plugins/acappella-musescore-plugin" pull --ff-only
bash "$HOME/Documents/CUCAC-Plugins/acappella-musescore-plugin/enable-auto-update.command"
```

之后登录 Mac 时后台任务自动启动，每 5 分钟检查一次；MuseScore 运行时暂不更新，关闭后下次检查同步。以后不用双击更新文件。新版本同步后，重新打开 MuseScore 加载。

只更新本仓库的 main 分支，使用快进合并；有本地修改、冲突或离线时跳过／等待，不会自动丢弃文件。后台任务仅更新 Git 工作副本，不修改乐谱和 MuseScore 设置。仓库路径移动后需在新位置重新启用。

关闭自动更新：运行仓库根目录的 `disable-auto-update.command`。

仍可手动运行 `plugins/acappella-arranger/update.command` 或 `git pull --ff-only`。后台自动更新只支持 macOS；首次安装与后台权限需在实际 Mac 上确认。

[功能说明与音域表](plugins/acappella-arranger/README.md)

## 来源

最初从 `jingwen67/acappella-hub` 的提交 `466f329d3911ccd80cd266b53b38b7ec173ce1c1` 迁出。此前历史在旧仓库，迁出后的历史在本仓库。两个 Hub 和 Workshop 页面继续在旧仓库维护。
