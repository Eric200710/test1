# 給 AI agent 的安裝指引（資訊科技與應用 W11）

這份文件是寫給 AI agent（例如 Antigravity）讀的。學生會對你說：「請讀 AGENT-GUIDE.md，照它做。」

## 你在幫誰

- 一位大學生，不是資訊系，第一次用這些工具。請用繁體中文、短句回報，少用術語。
- 這是他自己的筆電，Windows 或 Mac。課堂上大約有 25 分鐘。
- 你現在所在的資料夾就是老師給的起始包，裡面有資料檔、gnuplot 腳本、LaTeX 範本。

## 要完成什麼（做到這三項才算完成）

1. 裝好 gnuplot（畫圖用）。成功的樣子：執行 `gnuplot --version` 回一行版本號，例如 `gnuplot 6.0 patchlevel 4`。在 Windows 上用完整路徑 `C:\Program Files\gnuplot\bin\gnuplot.exe` 執行成功也算完成。
2. 裝好 Zotero（管理文獻用）。成功的樣子：電腦上找得到 Zotero 這個應用程式。
3. 用這個資料夾裡的腳本重新畫出兩張圖。成功的樣子：兩條 gnuplot 指令都正常結束，`figure-demo.png` 和 `figure-bar.png` 的修改時間變成現在。注意：起始包裡本來就附了這兩張圖，所以「檔案存在」不能當作成功的證據。

本機版 LaTeX 是選做，見最後一節。學生沒有說要裝就不要裝。

## 做事的規則

- **先給計畫，學生回「可以」再動手。** 計畫要列出：你判斷的作業系統、會跑的每一條指令、會裝到哪裡、大概占多少空間。學生回「可以」之後，計畫裡列過的指令可以一條一條直接跑，不用每條再問一次。計畫沒列到的指令要先問。原因：學生要知道自己的電腦被裝了什麼。
- **只用系統的套件管理工具裝**：Windows 用 winget，Mac 用 Homebrew。不要從其他網站下載安裝檔。原因：搜尋到的下載站常夾廣告軟體。
- **一次裝一樣，裝完就驗證，把驗證指令的輸出原文貼給學生看。** 原因：「安裝完成」的訊息不代表真的能用。
- **需要密碼、或跳出要按「是」的視窗時，停下來請學生自己處理。** 不要問學生的密碼，也不要請他把密碼打給你。Windows 的「使用者帳戶控制」視窗你看不到，裝的時候先提醒學生注意工作列有沒有閃爍的盾牌圖示。
- **安裝或畫圖失敗就停。** 每跑完一條指令都看它是不是正常結束（PowerShell 看 `$LASTEXITCODE`，Mac 看 `$?`，0 才是成功），不要只看有沒有印出文字。失敗時把錯誤訊息原文貼出來，說明你認為的原因和你建議的下一步，等學生回覆。不要自己換另一個下載來源，也不要假裝成功。例外：一開始檢查「有沒有裝過」時查不到程式，是預期中的結果，代表還沒裝，接著安裝就好，不用停。
- **只動這次要裝的東西。** 可以動的範圍：計畫裡學生同意的安裝（含套件管理工具自動帶進來的必要相依套件，請在計畫裡提一句）、這個資料夾裡的檔案。其他都不要動：不要移除或升級電腦上其他軟體，不要改其他資料夾的檔案。
- **Windows 的指令一律用 PowerShell 跑。** 下面的 `Test-Path` 和 `& "完整路徑"` 是 PowerShell 的寫法。

## 第 1 步：判斷作業系統與套件管理工具

- Windows：跑 `winget --version`。有版本號就繼續。
  沒有 winget：停下來，請學生到 Microsoft Store 安裝「應用程式安裝程式」（App Installer），裝好再叫你繼續。
- Mac：跑 `brew --version`。有版本號就繼續。
  沒有 Homebrew：停下來。安裝 Homebrew 要在終端機輸入電腦密碼，這一步你不能代做。請學生打開 https://brew.sh 照首頁那一行指令自己安裝，裝好再叫你繼續。

## 第 2 步：安裝 gnuplot

先檢查是不是已經有了：`gnuplot --version`。已經有就跳到第 3 步。查不到是正常的，代表還沒裝。

Windows：

```
winget install --id gnuplot.gnuplot -e --accept-source-agreements --accept-package-agreements
```

（後面兩個參數代表同意套件來源與套件的授權條款。請在計畫裡告訴學生這件事。）

Mac：

```
brew install gnuplot
```

驗證：

- Mac：跑 `gnuplot --version`，有版本號就完成。
- Windows：你現在用的終端機是安裝之前開的，通常還找不到剛裝好的程式，而且 gnuplot 的安裝程式不一定會把自己登記到 PATH（PATH 是 Windows 找程式的清單）。所以請直接用完整路徑驗證：

```
Test-Path "C:\Program Files\gnuplot\bin\gnuplot.exe"
& "C:\Program Files\gnuplot\bin\gnuplot.exe" --version
```

第一條回 `True`、第二條回版本號，就算完成。回 `False` 時不要重裝，先用 `winget list --id gnuplot.gnuplot` 確認有沒有裝成功，再找實際的安裝位置（例如 `Get-ChildItem "C:\Program Files" -Filter gnuplot.exe -Recurse -ErrorAction SilentlyContinue`）。

接著用白話問學生一次：「要不要讓你自己之後在終端機直接打 gnuplot 就能用？要的話我把 gnuplot 的位置加進你這個帳號的程式搜尋清單（PATH），只影響你這個帳號。」他同意才加，而且要保留清單原有的內容，只在後面多加一項：

```
$old = [Environment]::GetEnvironmentVariable("Path", "User")
[Environment]::SetEnvironmentVariable("Path", "$old;C:\Program Files\gnuplot\bin", "User")
```

加完告訴他：要把終端機（和 Antigravity）關掉重開，新設定才會生效。他不想加也沒關係，第 4 步用完整路徑跑就好。

## 第 3 步：安裝 Zotero

先檢查是不是已經有了（Windows：`winget list --id DigitalScholar.Zotero`；Mac：`ls /Applications/Zotero.app`）。已經有就不要重裝或升級，直接跳到「裝好之後」那一段。

Windows：

```
winget install --id DigitalScholar.Zotero -e --accept-source-agreements --accept-package-agreements
```

Mac：

```
brew install --cask zotero
```

驗證：

- Windows：`winget list --id DigitalScholar.Zotero` 有列出一筆。
- Mac：`ls /Applications/Zotero.app` 沒有報錯。

這只能證明檔案在。學生自己把 Zotero 打開之前，回報表裡這一項請寫「已安裝，待你打開確認」。

裝好之後，告訴學生下面三件事要他自己做（你做不了）：

1. 打開 Zotero。
2. 用 Chrome 打開 https://www.zotero.org/download/ ，在 Zotero Connector 那一塊點 Chrome 的連結，到 Chrome 線上應用程式商店按「加到 Chrome」。
3. 照學生頁第二部分的 Zotero 那張卡，從網頁收一篇論文進來。

## 第 4 步：用腳本畫兩張圖

起始包裡本來就附了這兩張圖。先記下它們現在的修改時間，再跑：

```
gnuplot figure-demo.gp
gnuplot figure-bar.gp
```

Windows 如果 `gnuplot` 還不在 PATH 裡，改用完整路徑：

```
& "C:\Program Files\gnuplot\bin\gnuplot.exe" figure-demo.gp
& "C:\Program Files\gnuplot\bin\gnuplot.exe" figure-bar.gp
```

看到 `warning: iconv failed to convert degree sign` 可以忽略，不影響出圖。

如果錯誤訊息提到 `pngcairo`（這台的 gnuplot 不支援這種輸出），就停下來告訴學生：今天先用起始包附的現成圖，並請他把錯誤訊息拿給老師看。不要自己改腳本。

驗證：兩條指令都正常結束，而且 `figure-demo.png` 和 `figure-bar.png` 的修改時間變成剛剛。時間沒變就是沒畫成功，不可以拿原本附的圖當成果。請學生自己打開這兩張圖看：一張是兩條折線，一張是長條圖。

## 第 5 步：回報

給學生一張表：

| 項目 | 結果 | 版本 | 裝在哪裡 | 之後怎麼移除 |
|---|---|---|---|---|

再列出：你實際跑過的指令、哪幾步是學生自己按的、有沒有哪一步沒做成。沒做成的要明講，不要寫成完成。

## 選做：本機版 LaTeX（學生說要才做）

先告訴學生：課堂上用 Overleaf 就夠了，本機版很大，下載要一段時間。他仍然要裝才繼續。

Windows（MiKTeX）：

```
winget install --id MiKTeX.MiKTeX -e --accept-source-agreements --accept-package-agreements
```

裝好後驗證。你現在的終端機可能還找不到剛裝好的 `xelatex`；找不到時請學生把 Antigravity 關掉重開，再叫你繼續：

```
xelatex --version
initexmf --set-config-value=[MPM]AutoInstall=1
```

第二條讓它編譯時自動補缺少的套件，不然會跳視窗一個一個問。接著在這個資料夾編範本（第一次會下載套件，可能要好幾分鐘，請先告訴學生）：

```
xelatex report-demo
bibtex report-demo
xelatex report-demo
xelatex report-demo
```

成功的樣子：資料夾多出 `report-demo.pdf`，一頁，裡面有圖 1、表 1、正文的 [1] 和文末一筆參考文獻。

Mac：本機版 LaTeX 的安裝要輸入電腦密碼，而且中文套件要另外補，今天不裝。請告訴學生 Mac 先用 Overleaf。

## 給 agent 的提醒

這份指引的第 4 步在 Mac 上實際跑過。Windows 的安裝指令是照 winget 官方套件目錄的名稱寫的，沒有在每一種電腦上試過。請以你實際看到的輸出為準，不要假設成功。
