# 阿卡贝拉编曲助手 v0.9.0

作者：Jingwen Zhang。当前仅包含「建谱」和「音域检查」两个页签。

## 安装与更新

见[仓库首页](../../README.md)。MuseScore 直接扫描 Git 工作副本中的实际 `plugins` 目录；按仓库首页的一次性设置启用后台自动更新；每 5 分钟检查，MuseScore 关闭时同步，重开使用新版。也可手动运行 `update.command`。

## 自动建谱

- 设置曲名、编曲者、1–256 小节、调号、拍号和速度；BPM 按四分音符计算。
- 默认 Solo、Soprano、Alto、Tenor、Baritone、Bass、Beatbox，可选 Rap，也可取消声部。
- 可添加多个 Solo，每个独立选择高音、高音低八度或低音谱号，名称自动区分 Solo 1、Solo 2…。
- Soprano／Alto／Rap 用高音谱号；Tenor 用高音低八度；Baritone／Bass 用低音；Beatbox 用打击乐谱。除 Beatbox 外默认音色为 Piano。
- 点击「创建新谱」会先关闭助手，再创建未保存的新谱。开始写谱后需要保留时，按 ⌘S 保存为 .mscz，默认文件名为曲名。
- 自动跳转不可用时，点击 MuseScore 顶部 Score／乐谱，无需重复创建。

原生建谱依赖 MuseScore Studio 4.7.x 的内部 NewScoreModel，针对 4.7.5 开发；4.7 以下不支持，其他版本需要验证。临时 MSCX 只用作模板，不自动保存谱子或按普通文件导入。

## 音域检查

助手打开时默认自动检查当前谱，约每 0.9 秒刷新，关闭助手后停止。按实际发声音高检查，包含边界的音不标红。

| 声部 | 手册音域 |
|---|---|
| Soprano | G3–E5 |
| Alto | D3–B4 |
| Tenor | C3–G4 |
| Baritone | F2–E4 |
| Bass | D2 及以上，未设上限 |

每个 Solo 可分别选择以上任一声部音域，默认不检查。选择保存在谱子元数据中；保存谱子后随文件保留。Beatbox、Rap、未知名称默认跳过。

支持和弦音、装饰音及常见声部名称缩写。超音域标记为红色；回到音域内时恢复原色。「清除选区内标记」处理选中的音符或小节范围，「清除全谱标记」处理全谱。清除会暂停自动检查，避免立即重新标红，可重新勾选开启。音符移动导致旧位置记录无法对应时，恢复色可能为黑色；颜色变更可撤销。

## v0.9.0 精简

移除 Bass 配和弦、节奏样例补全，以及独立的音频转谱网页工具、相关算法与测试。保留建谱和音域检查，已移除功能以后重新设计。旧实现可在 Git 历史查看。

## 验证与来源

```bash
node --test plugins/acappella-arranger/tests/*.test.cjs
```

自动测试检查建谱的关闭／创建顺序、可选跳转接口、声部模板、音域边界与选区清除。测试环境没有 MuseScore 桌面程序，实际新谱、音色及窗口行为需在 Mac 验证。

原生模板乐器数据改编自 MuseScore revision 3654226 的 Piano 与 Rock Band 模板，见 NativeInstruments.js（GPL-3.0-only）。
