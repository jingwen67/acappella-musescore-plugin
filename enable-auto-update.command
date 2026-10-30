#!/bin/bash
set -eu
repo_root="$(cd -- "$(dirname -- "$0")" && pwd -P)"
if [ "$(uname -s)" != Darwin ]; then
  echo '后台自动更新仅适用于 macOS。'; exit 1
fi
if ! git -C "$repo_root" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo '请在 GitHub 克隆的仓库中运行此文件。'; exit 1
fi
agent_label='com.jingwen.acappella-plugin.autoupdate'
agent_folder="$HOME/Library/LaunchAgents"
agent_file="$agent_folder/$agent_label.plist"
mkdir -p "$agent_folder"
xml_escape() {
  printf '%s' "$1" | sed -e 's/&/\&amp;/g' -e 's/</\&lt;/g' -e 's/>/\&gt;/g' -e 's/"/\&quot;/g' -e "s/'/\&apos;/g"
}
script_xml="$(xml_escape "$repo_root/scripts/auto-update.sh")"
cat > "$agent_file" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
<key>Label</key><string>$agent_label</string>
<key>ProgramArguments</key><array><string>/bin/bash</string><string>$script_xml</string></array>
<key>RunAtLoad</key><true/>
<key>StartInterval</key><integer>300</integer>
<key>ProcessType</key><string>Background</string>
</dict></plist>
PLIST
/usr/bin/plutil -lint "$agent_file" >/dev/null
agent_domain="gui/$(id -u)"
launchctl bootout "$agent_domain/$agent_label" >/dev/null 2>&1 || true
if ! launchctl bootstrap "$agent_domain" "$agent_file"; then
  echo '后台任务启用失败，请保留终端错误信息。'; exit 1
fi
echo '已开启：登录后每 5 分钟自动检查，MuseScore 关闭时同步 GitHub。'
echo '以后无需双击更新文件；本地有修改或冲突时会保留原文件并跳过更新。'
echo '可在仓库中运行 disable-auto-update.command 关闭。'
