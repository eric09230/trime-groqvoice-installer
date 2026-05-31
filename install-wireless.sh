#!/usr/bin/env bash
# ============================================================
#  TRIME + GroqVoice 無線安裝腳本（在「手機 Termux」執行）
#  用途：用一支手機，透過 WiFi 無線偵錯，幫「另一台手機」或「自己這台」安裝。
#  用法：把整個 trime-installer 資料夾放到手機，cd 進去後執行：
#         bash install-wireless.sh
#  需求：Termux（F-Droid 版）、兩台同一 WiFi、目標手機 Android 11+ 開無線偵錯
# ============================================================

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "============================================"
echo "  TRIME + GroqVoice 無線安裝 (Termux)"
echo "============================================"
echo

# --- 1. 確認 adb ---
if ! command -v adb >/dev/null 2>&1; then
    echo "[*] 找不到 adb，正在安裝 android-tools ..."
    pkg install -y android-tools || { echo "[錯誤] 安裝 android-tools 失敗，請手動跑：pkg install android-tools"; exit 1; }
fi

# --- 2. 確認檔案齊全 ---
if [ ! -f "$SCRIPT_DIR/apk/trime.apk" ] || [ ! -d "$SCRIPT_DIR/rime" ]; then
    echo "[錯誤] 找不到 apk/trime.apk 或 rime/ 資料夾。"
    echo "       請確認這支腳本和 apk/、rime/ 在同一個資料夾裡。"
    exit 1
fi

# --- 3. 目標手機開無線偵錯 + 配對 ---
echo ">> 在【目標手機】操作（要裝自己就是這台）："
echo "   設定 → 開發者選項 → 開啟『無線偵錯』"
echo "   點進『無線偵錯』→『使用配對碼配對裝置』"
echo "   會顯示：6 位配對碼，以及一組 IP位址:埠"
echo
read -p "請輸入【配對】的 IP:埠（例 192.168.0.50:42801）： " PAIR_ADDR
echo "（接著會問配對碼，輸入目標手機螢幕上的 6 位數）"
adb pair "$PAIR_ADDR" || { echo "[錯誤] 配對失敗，請重開無線偵錯重試（埠號會變）。"; exit 1; }

echo
echo ">> 回到『無線偵錯』主畫面，看『IP位址與連接埠』（跟配對埠不同）"
read -p "請輸入【連線】的 IP:埠（例 192.168.0.50:39769）： " CONN_ADDR
adb connect "$CONN_ADDR" || { echo "[錯誤] 連線失敗。"; exit 1; }

echo
echo "=== 目前連線的裝置 ==="
adb devices
echo
read -p "上面有看到一行 device 嗎？有的話按 Enter 繼續安裝（Ctrl+C 取消）..."

# --- 4. 安裝 ---
echo
echo "[1/5] 安裝 TRIME ..."
if ! adb install -r "$SCRIPT_DIR/apk/trime.apk"; then
    echo "[!] 安裝失敗，可能目標手機已有『不同簽章』的舊 Trime。"
    read -p "    要先解除安裝舊 Trime 再裝嗎？(y/N)： " YN
    if [ "$YN" = "y" ] || [ "$YN" = "Y" ]; then
        adb uninstall com.osfans.trime
        adb install "$SCRIPT_DIR/apk/trime.apk" || { echo "[錯誤] 仍失敗，請手動處理。"; exit 1; }
    fi
fi

echo "[2/5] 安裝 GroqVoice ..."
adb install -r "$SCRIPT_DIR/apk/groqvoice.apk" || echo "[!] GroqVoice 安裝略過（可能已安裝或簽章衝突）"

echo "[3/5] 授予權限 ..."
adb shell pm grant com.groqvoice android.permission.RECORD_AUDIO 2>/dev/null
adb shell appops set com.groqvoice MANAGE_EXTERNAL_STORAGE allow 2>/dev/null
adb shell appops set com.osfans.trime MANAGE_EXTERNAL_STORAGE allow 2>/dev/null

echo "[4/5] 推送 rime 設定到目標手機（約 80MB，請稍候）..."
adb push "$SCRIPT_DIR/rime/" /storage/emulated/0/rime/

echo "[5/5] 啟用並設定輸入法 ..."
adb shell ime enable com.osfans.trime/.ime.core.TrimeInputMethodService
adb shell ime enable com.groqvoice/.GroqVoiceIME
adb shell ime set com.osfans.trime/.ime.core.TrimeInputMethodService

echo
echo "============================================"
echo "  安裝完成！請在【目標手機】上："
echo "   1. 開 Trime → 方案：選『洋蔥手機注音plus』"
echo "      → 主題：選『洋蔥注音331k_M』→ 點『重新部署』"
echo "   2. 開 GroqVoice → 貼上 Groq API Key"
echo "============================================"
