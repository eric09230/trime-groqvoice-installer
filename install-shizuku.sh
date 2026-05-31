#!/system/bin/sh
# ============================================================
#  TRIME + GroqVoice 安裝腳本（透過 Shizuku，在「手機自己」執行，免電腦）
#
#  兩種跑法（先把 Shizuku 啟動好）：
#   (A) aShell You：直接把這個檔的「指令部分」整段貼進去執行
#   (B) Termux + rish：設定好 Shizuku 的 rish 後，執行  sh install-shizuku.sh
#
#  ⚠️ 前置：1) 裝 Shizuku 並啟動（開發者選項→無線偵錯→Shizuku 配對啟動）
#           2) 把 apk/ 和 rime/ 放到手機，並把下面 SRC 改成它們的實際位置
# ============================================================

# 安裝包資料夾在手機上的位置（依你實際放的地方修改）
SRC="/sdcard/Download/trime-installer"

echo "== [1/5] 安裝 TRIME =="
pm install -r "$SRC/apk/trime.apk" || {
    echo "   安裝失敗，若是簽章衝突，先解除安裝舊版："
    echo "   pm uninstall com.osfans.trime   然後再跑一次"
}

echo "== [2/5] 安裝 GroqVoice =="
pm install -r "$SRC/apk/groqvoice.apk"

echo "== [3/5] 複製 rime 設定到 /sdcard/rime =="
mkdir -p /sdcard/rime
cp -r "$SRC/rime/." /sdcard/rime/

echo "== [4/5] 授予權限 =="
appops set com.osfans.trime MANAGE_EXTERNAL_STORAGE allow
appops set com.groqvoice MANAGE_EXTERNAL_STORAGE allow
pm grant com.groqvoice android.permission.RECORD_AUDIO

echo "== [5/5] 啟用 + 設定輸入法 =="
ime enable com.osfans.trime/.ime.core.TrimeInputMethodService
ime enable com.groqvoice/.GroqVoiceIME
ime set com.osfans.trime/.ime.core.TrimeInputMethodService

echo
echo "== 完成！最後手動：開 Trime → 選方案『洋蔥手機注音plus』+ 主題『洋蔥注音331k_M』→ 重新部署 =="
echo "==          開 GroqVoice → 貼上 Groq API Key =="
