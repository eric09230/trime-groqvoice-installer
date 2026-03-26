# TRIME 同文輸入法 + GroqVoice 語音輸入 一鍵安裝包

[![GitHub release](https://img.shields.io/github/v/release/eric09230/trime-groqvoice-installer)](https://github.com/eric09230/trime-groqvoice-installer/releases)

**專案連結**：https://github.com/eric09230/trime-groqvoice-installer

## 包含內容

- **TRIME v3.3.9** — Android RIME 輸入法（洋蔥注音方案）
- **GroqVoice** — Groq Whisper 語音輸入法
- **rime/** — 預設好的注音方案、詞庫、鍵盤主題

## 致謝與來源

本安裝包整合自以下開源專案：

- **TRIME 同文輸入法** — [osfans/trime](https://github.com/osfans/trime) (Apache-2.0 License)
- **洋蔥注音 RIME 方案** — [oniondelta/Onion_Trime_Files](https://github.com/oniondelta/Onion_Trime_Files) by 洋蔥
- **GroqVoice** — 基於 [Groq](https://groq.com) Whisper API 的語音輸入法

## 安裝前準備

### 第一步：電腦安裝 ADB

ADB（Android Debug Bridge）是電腦與手機之間的橋梁工具，需要手動下載。

1. 前往下載頁面：https://developer.android.com/studio/releases/platform-tools
2. 根據你的系統下載：
   - Windows：點擊 **Download SDK Platform-Tools for Windows**
   - macOS：點擊 **Download SDK Platform-Tools for Mac**
   - Linux：點擊 **Download SDK Platform-Tools for Linux**
3. 下載後解壓縮到任意資料夾（例如 `C:\platform-tools`）
4. **Windows 設定環境變數（重要）**：
   - 右鍵「本機」→「內容」→「進階系統設定」→「環境變數」
   - 在「系統變數」找到 `Path`，點擊「編輯」
   - 點擊「新增」，輸入 ADB 解壓縮的路徑（例如 `C:\platform-tools`）
   - 按「確定」儲存
5. 開啟命令提示字元，輸入 `adb version`，看到版本號就代表安裝成功

### 第二步：手機開啟 USB 偵錯

1. 開啟手機「設定」
2. 找到「關於手機」（通常在最底部）
3. 連續點擊「版本號碼」7 次 → 會提示「您已成為開發人員」
4. 返回「設定」，找到「開發人員選項」（可能在「設定」→「一般管理」或「系統」底下）
5. 開啟「USB 偵錯」（USB Debugging）

### 第三步：申請 Groq API Key（免費）

GroqVoice 需要 Groq API Key 才能使用語音轉文字功能。

1. 前往 https://console.groq.com
2. 註冊帳號（可用 Google 登入）
3. 進入 Dashboard 後，點擊左側「API Keys」
4. 點擊「Create API Key」，取一個名字，按建立
5. 複製 API Key（以 `gsk_` 開頭），安裝完成後會用到

## 開始安裝

1. 用 USB 傳輸線將手機連接到電腦
2. 手機會跳出「允許 USB 偵錯嗎？」→ 點擊「允許」（建議勾選「一律允許」）
3. 執行安裝腳本：
   - **Windows**：雙擊 `install.bat`
   - **macOS / Linux**：開啟終端機，執行：
     ```
     chmod +x install.sh
     ./install.sh
     ```
4. 等待安裝完成（推送 rime 資料約需 1-2 分鐘）

## 安裝完成後設定

### 步驟一：設定 TRIME 同文輸入法

1. **開啟手機上的 TRIME app**（同文輸入法）
2. **設定首選語音輸入**：
   - 進入「常規」
   - 找到「首選語音輸入」→ 選擇 **GroqVoice**
3. **設定輸入方案**：
   - 進入「方案」頁面
   - 點擊右下角的 **＋** 按鈕 → 選擇「**洋蔥手機注音plus**」方案
   - 點擊右上角的 **鉛筆圖案** → 把其他不需要的方案移除（只保留洋蔥手機注音plus）
4. **設定鍵盤主題**：
   - 進入「鍵盤樣式」→「主題」
   - 選擇「**洋蔥注音331k_M**」（又稱「注音方案中版」）
5. **設定配色**：
   - 進入「配色」
   - 推薦選擇：
     - **原標準配色！** — 有注音標示及詳細標點符號
     - **標準配色！** — 有注音標示，簡潔風格
6. **重新部署**：
   - 點擊右上角的 **重新部署圖案**（↻），等待部署完成

### 步驟二：設定 GroqVoice 語音輸入

1. **開啟手機上的 GroqVoice app**
2. 貼上你的 Groq API Key → 點擊「Add API Key」
3. 可依需求開啟 LLM 文字精修等功能（詳見下方功能說明）
4. **建議設定完成後拉到最底按「Backup」**，將設定備份到 `/storage/emulated/0/GroqVoice/backup.json`，日後重裝 app 只需按「Restore」即可一鍵還原所有設定及 API keys

### 步驟三：測試

1. 打開任意聊天 app（LINE、Telegram 等）
2. 使用 TRIME 鍵盤輸入
3. **長按 Enter 鍵** → GroqVoice 自動開始錄音
4. 說完話後點擊「Stop」→ 自動轉文字並回到 TRIME

## GroqVoice 功能說明

| 功能 | 說明 |
|------|------|
| 語音轉文字 | Groq Whisper 雲端轉錄，速度快 |
| 簡轉繁 | 自動將簡體字轉為繁體中文 |
| LLM 文字精修 | 去除語助詞、修正同音錯字、修標點 |
| 自我修正偵測 | 自動處理「不對，改成...」 |
| 條列式格式 | 多個要點自動排成條列 |
| 字數門檻 | 每個功能可設定最少字數才啟動 |
| 多平台 LLM | 支援 Groq / OpenAI / OpenRouter |
| 自動送出 | 可選擇語音輸入後自動按 Enter 送出 |
| 設定備份/還原 | 備份 API keys 及所有設定到手機儲存空間，重裝不遺失 |

## 洋蔥注音 trime.yaml 鍵盤方案功能總覽

本安裝包內建的 `洋蔥注音331k_M.trime.yaml` 是一份極為完整的 TRIME 同文輸入法外觀與鍵盤佈局設定檔（非 RIME 引擎層 schema），由作者**洋蔥**及社群貢獻者（風花絮、llx、暖暖等）共同打造。以下為其完整功能解析。

---

### 1. 鍵盤佈局系統（超過 80 種鍵盤）

#### 主要鍵盤

| 鍵盤 | 說明 |
|------|------|
| `default` | 26 鍵 QWERTY 預設鍵盤（作者：暖暖），支援長按數字、滑動方向鍵 |
| `42keys` | 42 鍵基礎鍵盤（作者：洋蔥），五行配置含獨立數字行 |
| `number` | 數字 + 運算符號鍵盤，ASCII 模式 |
| `kmenu` | 鍵盤選擇選單頁，可快速切換所有鍵盤佈局 |
| `duse` | 全功能編輯鍵盤（方向鍵、Home/End、全選/剪下/複製/貼上/Undo/Redo） |

#### 注音鍵盤系列（bpmfmobile）

| 變體 | 說明 |
|------|------|
| `bpmfmobile` | 注音改鍵盤（有滑動），所有按鍵支援四方向滑動 |
| `bpmfmobile_ns` | 注音改鍵盤（無滑動版本） |
| `bpmfmobileplus` | 注音 Plus，每鍵帶 QWERTY 字母提示 |
| `bpmfmobilemix` | 注音 Mix，混合更多編輯功能 |
| `bpmfmobilemixin` ~ `mixin4` | 多種 Mixin 變體，透過 `__include`/`__patch` 實現差異化 |
| `bpmfmobiledouble` | 注音雙拼 D8（36 鍵） |
| `bpmfmobiledouble_t2` | 注音雙拼 T2 |
| `bpmfmobiledouble_full` | 注音雙拼 Full |

#### 嘸蝦米鍵盤系列（ovffmobile）

| 變體 | 說明 |
|------|------|
| `ovffmobile` | 嘸蝦米 D8 版，五行含數字行 |
| `ovffmobile_up` | 嘸蝦米 Up 版 |
| `ovffmobile_lessd8` | 嘸蝦米 LessD8，三行佈局，數字透過上滑輸入 |
| `ovffmobile_less` | 嘸蝦米 LessF 版 |

#### 其他鍵盤

| 鍵盤 | 說明 |
|------|------|
| `numov` | 數字洋蔥鍵盤，數字鍵帶嘸蝦米拆碼提示 |
| `hangeul2set` | 韓文二式鍵盤，QWERTY 對應韓文字母 |

---

### 2. Emoji 表情鍵盤（10 大分類，約 35 頁）

所有 Emoji 鍵盤共用統一的頂端導覽列（11 個分類按鈕）及滑動手勢翻頁。

| 分類 | 鍵盤 ID | 頁數 | 內容 |
|------|---------|------|------|
| 人物表情 🙂 | bqrw1~6 | 6 頁 | 笑臉、負面、惡魔、貓臉、人物角色、家庭組合、手勢、愛心、服飾 |
| 花草動物 🌼 | bqhc1~2 | 2 頁 | 哺乳動物、禽鳥、水生爬蟲、昆蟲、花卉、植物樹木 |
| 食物飲品 🎂 | bqpt1~2 | 2 頁 | 水果、蔬菜、主食、日式料理、甜品、飲品、餐具 |
| 旅行地點 🚖 | bqlx1~5 | 5 頁 | 地球地圖、建築、風景、交通工具、時鐘、天文氣象 |
| 活動慶典 🎉 | bqhd1~2 | 2 頁 | 節慶、禮物、球類運動、戶外運動、遊戲娛樂、撲克麻將 |
| 科技物品 🔌 | bqkj1~4 | 4 頁 | 音樂設備、通訊、電腦、影視、文具、工具、武器、旗幟 |
| 其他符號 🔶 | bqqt1~4 | 4 頁 | 公共設施、警告禁止、方向箭頭、宗教、星座、媒體控制、幾何圖形 |
| 國旗 🇺🇸 | bqqz1~5 | 5 頁 | 全球約 250 面國家/地區旗幟（按 ISO 國碼排列） |
| 符號集 | symbols1~6 | 6 頁 | Unicode 符號大全（詳見下方符號系統） |
| 標點符號 #!? | bqfh1~14 | 14 頁 | 中英文標點、全形/小型符號、數學、貨幣、幾何、箭頭、制表符、直排標點 |

---

### 3. 顏文字鍵盤（7 種情緒分類）

| 分類 | 鍵盤 ID | 範例 |
|------|---------|------|
| 開心 | kao_happy | `^_^`、`~\(≧▽≦)/~`、`(*^ω^*)` |
| 喜歡 | kao_fond | `♡＾▽＾♡`、`～(^з^)-☆` |
| 驚訝 | kao_astonished | `Σ( ° △ °|||)︴`、`(ﾟДﾟ≡ﾟдﾟ)!?` |
| 無奈 | kao_impotent | `╮(╯_╰)╭`、`_(:з」∠)_` |
| 傷心 | kao_sad | `(＞﹏＜)`、`ಥ_ಥ`、`QAQ` |
| 生氣 | kao_mad | `（╯‵□′）╯︵┴─┴`、`(▼皿▼#)` |
| 對話 | kao_dialogue | `☸ヾ(｡╹ω╹｡)ﾉ☸加油！`、`b'∀' ~OK!` |

---

### 4. 符號快捷輸入系統

透過 `{Escape}3` + 編碼觸發符號表查詢，涵蓋**數百種 Unicode 符號分類**：

- **文字符號**：拼音、注音、假名（平/片）、韓文、希臘字母、俄語字母、羅馬數字
- **數學/科學**：數學符號、上下標、分數、單位、貨幣
- **裝飾字符**：字母圈/括/框/黑圈、數字圈/括/點/標、漢字圈/框/括、假名圈、韓文圈/括
- **中華文化**：八卦、易經六十四卦、天干地支、六十干支、十二宮、太玄經、部首、筆畫、偏旁
- **遊戲娛樂**：象棋、麻將、骰子、撲克
- **Emoji 細分**：按情緒/動作/膚色/性別等數十種子分類查詢
- **字母變化體**：A~Z 各字母的裝飾/花體 Unicode 變體

---

### 5. 標點符號快捷鍵

#### 中文標點（一鍵輸入）

| 按鍵 | 輸出 | 按鍵 | 輸出 |
|------|------|------|------|
| 頓號 | 、 | 分號 | ； |
| 刪節號 | … | 逗號 | ， |
| 句號 | 。 | 波浪線 | ～ |

#### 成對括號（自動輸入並將游標定位在中間）

`「」`、`『』`、`（）`、`〈〉`、`《》`、`""`、`''`、`[]`、`{}`、`<>`、`()`

---

### 6. 完整注音符號對應（37 個注音 + 4 聲調）

標準鍵盤 QWERTY 對應全部注音符號，例如：
- `1`=ㄅ、`q`=ㄆ、`a`=ㄇ、`z`=ㄈ
- `2`=ㄉ、`w`=ㄊ、`s`=ㄋ、`x`=ㄌ
- 聲調：`3`=ˇ、`4`=ˋ、`6`=ˊ、`7`=˙

---

### 7. 功能鍵系統

#### 編輯操作

| 功能 | 說明 |
|------|------|
| 剪下 / 複製 / 貼上 / 全選 | 標準剪貼簿操作 |
| 全剪下 / 整行剪下 / 整行複製 | 進階選取操作 |
| Undo / Redo | 復原 / 重做（需 Android 6.0+） |
| Home / End / Page Up / Page Down | 游標快速定位 |
| 方向鍵（含 Ctrl+方向） | 按字元或按詞移動 |
| 限定候選字數（x1~x4） | 限定 1~4 字候選詞 |

#### 輸入法控制

| 功能 | 說明 |
|------|------|
| 中/英切換 | ascii_mode 切換 |
| 半角/全角 | full_shape 切換 |
| 繁/簡切換 | simplification 切換 |
| 常用/增廣字集 | extended_charset 切換 |
| Emoji 建議開關 | emoji_suggestion 切換 |
| 方案選單 (F4) | RIME 方案切換 |
| 配色切換 | 切換配色方案 |
| 鍵盤選單 | 切換鍵盤佈局 |
| 輸入法切換 | 切換系統輸入法 |
| 日期/時間輸出 | 快速輸入日期時間 |

#### Android 系統鍵

亮度調整、計算機、日曆、電話簿、瀏覽器、音樂、電源、搜尋、音量控制、語音助理

#### RIME 進階操作

| 功能 | 說明 |
|------|------|
| 刪除前一音節 | Ctrl+BackSpace |
| 上屏原始輸入 | Ctrl+Return |
| 上屏編碼文本 | Shift+Return |
| 上屏提示 | Ctrl+Shift+Return |
| 刪除使用者詞條 | Ctrl+Delete |

---

### 8. 液態鍵盤（Liquid Keyboard）

| 功能 | 說明 |
|------|------|
| 收藏 | 自訂收藏的片語/符號 |
| 剪貼簿 | 剪貼簿歷史記錄 |
| 草稿 | 草稿暫存 |

預留可啟用分頁：emoji 全集、數學符號、ASCII、中文標點、歷史紀錄、IDS 漢字結構、拼音、花體字母、假名、希臘字母、俄語、韓文、拉丁擴展、音標、單位、顏文字、組合字元等。

---

### 9. 配色方案（近 40 套）

| 方案 | 作者 | 方案 | 作者 |
|------|------|------|------|
| 標準配色 | 風花絮 | 同文風 | 風花絮 |
| 碧水 Aqua | 佛振 | 青天 Azure | 佛振 |
| 明月 Luna | 佛振 | 墨池 Ink | 佛振 |
| 孤寺 Lost Temple | 佛振 | 暗堂 Dark Temple | 佛振 |
| 星際爭霸 StarCraft | Contralisk | 谷歌 Google | skoj |
| 曬經石 Solarized Rock | Aben | 丁丁 Tintin | Patricivs |
| DOTA 2 | Patricivs | 銅鑼衛門 Doraemon | Patricivs |
| 熊出沒 | Patricivs | NBA | Patricivs |
| 遊驛四 PS4 | Patricivs | YouTube | Patricivs |
| 藍精靈 Smurfs | skoj | 致青春 So Young | 五磅兔 |
| Wii | Patricivs | Android | Patricivs |
| Steam | Patricivs | 小鶴飛揚 flypy | Pal.lxk |
| 丹青 | Mijiag | 一葉孤城 | 小辛 |
| …及更多 | | | |

每套方案均定義完整配色：背景、邊框、候選文字、高亮，以及鍵盤按鍵的 4 色分區（一般鍵、聲調鍵、功能鍵/退格、Enter），確保所有配色方案都能正確顯示鍵盤顏色。

---

### 10. 視覺與排版設定

- **字型系統**：候選字體(han.ttf)、編碼提示(comment.ttf)、鍵盤(LucidaGrande.ttc)、西文(latin.ttf)、符號(symbol.ttf)、擴充漢字(HanaMinB.ttf)
- **候選區**：水平候選模式、字號 19、高度 34、編碼提示在上方
- **按鍵**：圓角 12、間距 4、按鍵糾錯開啟
- **懸浮窗口**：固定位置、最大寬度 360、圓角 8、不可移動
- **橫屏適配**：獨立的橫屏鍵盤高度與邊距設定
- **Enter 鍵動態標籤**：根據 App 場景顯示「前往/完成/搜索/發送」等
- **顏色後備機制**：60+ 項顏色繼承鏈（含自訂按鍵色標 fallback），未指定時自動從父項繼承

---

### 11. 技術特色

- **YAML 錨點系統**：50+ 顏色錨點、10 組高度錨點、字型大小錨點，統一管理全域參數
- **`__include` / `__patch` 繼承**：鍵盤變體透過繼承與差異化修補，減少重複定義
- **滑動手勢導航**：所有 Emoji/符號鍵盤的每個按鍵均支援四方向滑動翻頁/切分類
- **成對括號自動定位**：輸入成對符號後游標自動回到中間
- **符號引擎整合**：透過 `{Escape}3` 編碼觸發 RIME 符號表，實現數百種符號分類查詢
- **預留擴充**：風頂功鍵盤（dgdaniu）已定義但註解，可隨時啟用

---

## 資料夾結構

```
trime-installer/
├── install.bat          ← Windows 安裝腳本
├── install.sh           ← macOS/Linux 安裝腳本
├── README.md            ← 本說明文件
├── apk/
│   ├── trime.apk        ← TRIME 同文輸入法
│   └── groqvoice.apk    ← GroqVoice 語音輸入
└── rime/                ← RIME 方案及詞庫
```

## 自訂修改記錄

本安裝包使用的 TRIME APK 為[自訂 fork](https://github.com/eric09230/trime)（branch: `restore-inline-switches`），基於官方 v3.3.9 並修復以下問題：

### APK 原始碼修改

| # | 問題 | 修復方式 |
|---|------|----------|
| 1 | **開關列被收進三點選單** — v3.3.6 移除 inline SwitchesUi | fork 並 backport SwitchesUi 到 v3.3.9 架構，新增 4 檔（`ime/bar/ui/switches/`），修改 `AlwaysUi.kt`、`InputBarDelegate.kt` |
| 2 | **SwitchesUi emoji 按鈕** | 在開關列加入 😀 按鈕，按下開啟 emoji 鍵盤 |
| 3 | **emoji 按鈕開啟符號頁而非 emoji** | `Keyboard_bqrw`（select: bqfh1）改為 `Keyboard_bqrw1`（select: bqrw1） |
| 4 | **emoji 按鈕無法 toggle 回主鍵盤** | 在 `KeyboardWindow.kt` 暴露 `activeKeyboardId`/`isActiveKeyboardLocked`，`InputBarDelegate.kt` 判斷若已在 emoji/符號區則切回主鍵盤 |
| 5 | **簡繁切換無效** — OpenCC 字典未打包 | `OpenCCDataPlugin.kt` 的 `providers.exec {}` 加 `.result.get()` 強制執行 |
| 6 | **CI 改為 release build** | `.github/workflows/commit-ci.yml` 改 `make release`，`app/build.gradle.kts` release signingConfig fallback 到 debug key |
| 7 | **英文模式按 ✽ 不開英文標點頁** | `KeyboardWindow.switchKeyboard()` 判斷 target=="bqfh1" 且 isAsciiMode 時重導到 "bqfh2" |
| 8 | **bqfh 頁面間無法切回 bqfh1** — fix #7 的重導在 bqfh 內部導航也會觸發，配合同鍵盤 guard 導致無反應 | 重導加 `!currentId.startsWith("bqfh")` 條件，僅從外部進入時重導 |
| 9 | **SwitchesUi 按鈕無觸覺回饋** | `InputBarDelegate.kt` 的 `setOnSwitchClick` 加入 `InputFeedbackManager.keyPressVibrate()`，遵循用戶振動設定 |

### YAML 修改（rime/洋蔥注音331k_M.trime.yaml）

| # | 問題 | 修復方式 |
|---|------|----------|
| 1 | **數字鍵盤重複輸入** | `KP_0`~`KP_9` 改為 `num_0`~`num_9` + `functional: false` |
| 2 | **剪貼簿/收藏無法叫出** | `command: liquid_keyboard` → `command: clipboard_window`（option: "0"=剪貼簿, "1"=收藏） |
| 3 | **符號鍵盤(bqfh)導航列錯位** — `click: ''` 空佔位 key 在 v3.3.9 因缺少 width 導致寬度為 0，底部導航列（中文/英文/常用...）擠到錯誤位置 | 138 個空 key 加上 `width: 10`，涵蓋 bqfh1~14 中的 11 頁 |
| 4 | **多數配色方案鍵盤顏色異常** — 鍵盤佈局引用自訂色標（`bkg`、`benter`、`bbs`、`bzyplus` 等 30+ 個），但僅「標準配色！」和「原標準配色！」有定義，其餘 36 個方案全部缺失，導致切換配色後鍵盤變成整片同色 | 1. 在 `fallback_colors` 新增 30+ 項自訂色標回退鏈作為安全網 2. 為全部 36 個配色方案逐一推導並補齊自訂按鍵色（4 色分區：一般鍵=背景色、聲調鍵=accent 淡化、功能鍵/退格=背景加深/減淡、Enter=accent 色） |

### Schema 修改（rime/bpmfmobileplus.schema.yaml）

| # | 問題 | 修復方式 |
|---|------|----------|
| 1 | **按數字 7 無法輸入韓文** — `dependencies` 宣告 `hangeul`（形碼版），但 korea translator 使用 `hangeul_hnc_m.extended`（HNC 版），導致 prism 未被編譯，韓文翻譯器無法運作 | `dependencies` 從 `hangeul` 改為 `hangeul_hnc_m`，使部署時正確編譯 HNC 韓文 prism |

### 注意事項

- `_H`（高版）和 `_L`（低版）透過 `__include: 洋蔥注音331k_M.trime.yaml:/` 繼承 M 版，不需另外修改
- 簡繁切換修復後，需確保手機 user dir（`/storage/emulated/0/rime/opencc/`）沒有多餘的 OpenCC 標準檔案遮蔽 shared dir

---

## 常見問題

**Q: 執行 install.bat 時顯示「adb not found」**
A: ADB 沒有正確安裝或環境變數沒設定。請重新確認第一步。

**Q: 顯示「no devices found」**
A: 手機沒有正確連接。請確認 USB 偵錯已開啟，並在手機上允許 USB 偵錯。

**Q: 安裝後 TRIME 鍵盤沒出現**
A: 到手機「設定」→「語言與輸入」→「管理鍵盤」→ 開啟「同文輸入法」。

**Q: 長按 Enter 顯示「尚未安裝語音輸入」**
A: 安裝腳本會自動處理，但如果仍出現，請用電腦執行：
```
adb shell ime enable com.groqvoice/.GroqVoiceIME
```

**Q: GroqVoice 閃退**
A: 請先開啟 GroqVoice app 確認已授予錄音權限和設定 API Key。

**Q: 重裝 GroqVoice 後要重新輸入 API Key？**
A: 如果之前有按過「Backup」，重裝後打開 GroqVoice → 拉到最底按「Restore」即可還原。備份檔位於 `/storage/emulated/0/GroqVoice/backup.json`，不會隨 app 解除安裝而刪除。

**Q: GroqVoice 卡在錄音畫面無法退出**
A: 畫面最底部有「Switch Keyboard」按鈕可隨時切回上一個鍵盤。
