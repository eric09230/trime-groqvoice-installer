#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "============================================"
echo "  TRIME + GroqVoice One-Click Installer"
echo "============================================"
echo

# Check ADB
if ! command -v adb &>/dev/null; then
    echo "[ERROR] adb not found. Please install Android SDK Platform Tools."
    echo "  macOS:   brew install android-platform-tools"
    echo "  Linux:   sudo apt install adb"
    echo "  Manual:  https://developer.android.com/studio/releases/platform-tools"
    exit 1
fi

# Check device
echo "[1/8] Checking device connection..."
if ! adb devices | grep -q "device$"; then
    echo "[ERROR] No device found. Please:"
    echo "  1. Enable USB Debugging on your phone"
    echo "  2. Connect via USB"
    echo "  3. Accept the USB debugging prompt on your phone"
    exit 1
fi
echo "       Device connected!"
echo

# Install TRIME
echo "[2/8] Installing TRIME (Tong Wen Input Method)..."
adb install -r "$SCRIPT_DIR/apk/trime.apk" || echo "[WARNING] TRIME install may have failed"
echo

# Install GroqVoice
echo "[3/8] Installing GroqVoice..."
adb install -r "$SCRIPT_DIR/apk/groqvoice.apk" || echo "[WARNING] GroqVoice install may have failed"
echo

# Grant permissions BEFORE pushing data or opening apps
echo "[4/8] Granting permissions..."
adb shell pm grant com.groqvoice android.permission.RECORD_AUDIO
adb shell pm grant com.groqvoice android.permission.READ_EXTERNAL_STORAGE 2>/dev/null || true
adb shell pm grant com.groqvoice android.permission.WRITE_EXTERNAL_STORAGE 2>/dev/null || true
adb shell appops set com.groqvoice MANAGE_EXTERNAL_STORAGE allow 2>/dev/null || true
adb shell pm grant com.osfans.trime android.permission.READ_EXTERNAL_STORAGE 2>/dev/null || true
adb shell pm grant com.osfans.trime android.permission.WRITE_EXTERNAL_STORAGE 2>/dev/null || true
adb shell appops set com.osfans.trime MANAGE_EXTERNAL_STORAGE allow 2>/dev/null || true
echo "       Permissions granted!"
echo

# Push rime data
echo "[5/8] Pushing rime configuration to device..."
echo "       This may take a minute (~80MB)..."
adb push "$SCRIPT_DIR/rime/" /storage/emulated/0/rime/
echo

# Open TRIME for initial deploy
echo "[6/8] Opening TRIME for initial deployment..."
adb shell am start -n com.osfans.trime/.MainLauncherAlias 2>/dev/null || true
echo "       Waiting for TRIME to initialize..."
sleep 5
echo

# Enable IMEs (AFTER permissions and init)
echo "[7/8] Enabling input methods..."
adb shell ime enable com.osfans.trime/.ime.core.TrimeInputMethodService
adb shell ime enable com.groqvoice/.GroqVoiceIME
adb shell ime enable com.google.android.tts/com.google.android.apps.speech.tts.googletts.settings.asr.voiceime.VoiceInputMethodService 2>/dev/null || true
echo

# Set TRIME as default
echo "[8/8] Setting TRIME as default input method..."
adb shell ime set com.osfans.trime/.ime.core.TrimeInputMethodService
echo

# Verify
echo "Verifying installation..."
echo
echo "Enabled input methods:"
adb shell ime list -s
echo
echo "Default input method:"
adb shell settings get secure default_input_method
echo

echo "============================================"
echo "  Installation Complete!"
echo "============================================"
echo
echo "Next steps:"
echo "  1. Open GroqVoice app to set your Groq API key"
echo "     (Get free API key at https://console.groq.com)"
echo "  2. Long-press Enter in TRIME to use voice input"
echo
echo "Optional: In GroqVoice settings you can configure:"
echo "  - LLM text refinement (requires Groq/OpenAI/OpenRouter key)"
echo "  - Auto send (press Enter after voice input)"
echo "  - Voice input language"
