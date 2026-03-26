@echo off
chcp 65001 >nul 2>&1
title TRIME + GroqVoice Installer

echo ============================================
echo   TRIME + GroqVoice One-Click Installer
echo ============================================
echo.

REM Check ADB
where adb >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] adb not found. Please install Android SDK Platform Tools.
    echo Download: https://developer.android.com/studio/releases/platform-tools
    pause
    exit /b 1
)

REM Check device connection
echo [1/8] Checking device connection...
adb devices | findstr /r "device$" >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] No device found. Please:
    echo   1. Enable USB Debugging on your phone
    echo   2. Connect via USB
    echo   3. Accept the USB debugging prompt on your phone
    pause
    exit /b 1
)
echo       Device connected!
echo.

REM Install TRIME
echo [2/8] Installing TRIME (Tong Wen Input Method)...
adb install -r "%~dp0apk\trime.apk"
if %errorlevel% neq 0 (
    echo [WARNING] TRIME install failed. It may already be installed.
)
echo.

REM Install GroqVoice
echo [3/8] Installing GroqVoice...
adb install -r "%~dp0apk\groqvoice.apk"
if %errorlevel% neq 0 (
    echo [WARNING] GroqVoice install failed. It may already be installed.
)
echo.

REM Grant permissions BEFORE pushing data or opening apps
echo [4/8] Granting permissions...
adb shell pm grant com.groqvoice android.permission.RECORD_AUDIO
adb shell pm grant com.groqvoice android.permission.READ_EXTERNAL_STORAGE 2>nul
adb shell pm grant com.groqvoice android.permission.WRITE_EXTERNAL_STORAGE 2>nul
adb shell appops set com.groqvoice MANAGE_EXTERNAL_STORAGE allow 2>nul
adb shell pm grant com.osfans.trime android.permission.READ_EXTERNAL_STORAGE 2>nul
adb shell pm grant com.osfans.trime android.permission.WRITE_EXTERNAL_STORAGE 2>nul
adb shell appops set com.osfans.trime MANAGE_EXTERNAL_STORAGE allow 2>nul
echo       Permissions granted!
echo.

REM Push rime data
echo [5/8] Pushing rime configuration to device...
echo       This may take a minute (~80MB)...
adb push "%~dp0rime/" /storage/emulated/0/rime/
echo.

REM Open TRIME to trigger first-time deploy
echo [6/8] Opening TRIME for initial deployment...
adb shell am start -n com.osfans.trime/.MainLauncherAlias 2>nul
echo       Waiting for TRIME to initialize...
timeout /t 5 >nul
echo.

REM Enable IMEs (AFTER permissions and init, so system won't auto-disable)
echo [7/8] Enabling input methods...
adb shell ime enable com.osfans.trime/.ime.core.TrimeInputMethodService
adb shell ime enable com.groqvoice/.GroqVoiceIME
adb shell ime enable com.google.android.tts/com.google.android.apps.speech.tts.googletts.settings.asr.voiceime.VoiceInputMethodService 2>nul
echo.

REM Set TRIME as default
echo [8/8] Setting TRIME as default input method...
adb shell ime set com.osfans.trime/.ime.core.TrimeInputMethodService
echo.

REM Verify
echo Verifying installation...
echo.
echo Enabled input methods:
adb shell ime list -s
echo.
echo Default input method:
adb shell settings get secure default_input_method
echo.

echo ============================================
echo   Installation Complete!
echo ============================================
echo.
echo Next steps:
echo   1. Open GroqVoice app to set your Groq API key
echo      (Get free API key at https://console.groq.com)
echo   2. Long-press Enter in TRIME to use voice input
echo.
echo Optional: In GroqVoice settings you can configure:
echo   - LLM text refinement (requires Groq/OpenAI/OpenRouter key)
echo   - Auto send (press Enter after voice input)
echo   - Voice input language
echo.
pause
