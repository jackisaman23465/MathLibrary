# MathLibrary SDK 安裝與執行說明

## 1. 介紹
`MathLibrary` 是一個簡單的數學計算 SDK，包含基本的加法、減法與除法運算，並封裝為 DLL。

## 2. 安裝

### 2.1. 下載與編譯

#### **步驟 1：下載程式碼**
請從 GitHub 或其他來源取得 `MathLibrary` 原始碼，並確保專案結構如下：

```
MathLibrary/
├── MathLibrary/       # SDK 原始碼
├── MathLibraryTest/ # 測試專案
├── README.md          # 安裝與執行說明
```

#### **步驟 2：使用 .NET 進行編譯**
請使用以下指令編譯 `MathLibrary.dll`：
```sh
cd MathLibrary
 dotnet build
```
編譯完成後，`MathLibrary.dll` 會出現在：
```
MathLibrary/bin/Debug/net8.0/MathLibrary.dll
```

### 2.2. 參考 DLL（在你的應用程式中使用 `MathLibrary.dll`）

如果你要在 C# 專案中使用 `MathLibrary.dll`，請按照以下步驟：

#### **方法 1：手動加入 DLL**
1. 將 `MathLibrary.dll` 複製到你的專案目錄（例如 `libs/`）。
2. 在你的 C# 專案 (`.csproj`) 中加入參考：
   ```xml
   <ItemGroup>
       <Reference Include="MathLibrary">
           <HintPath>libs/MathLibrary.dll</HintPath>
       </Reference>
   </ItemGroup>
   ```
3. 在 `Program.cs` 中引用 `MathLibrary` 命名空間：
   ```csharp
   using MathLibrary;
   ```

#### **方法 2：使用 `dotnet add reference`**
如果你的應用程式與 `MathLibrary` 在同一個解決方案內，可以直接添加專案參考：
```sh
cd ConsoleApp
 dotnet add reference ../MathLibrary/MathLibrary.csproj
```

---
## 3. 執行 Console 應用程式測試

### **3.1. 執行 Console 測試程式**

確保 `ConsoleApp` 已參考 `MathLibrary.dll`，然後執行：
```sh
cd ConsoleApp
 dotnet run
```

如果編譯成功，應該會看到如下輸出：
```
Add(3, 5) = 8
Subtract(10, 4) = 6
Divide(10, 2) = 5.0
Divide(5, 0) = NaN (已記錄錯誤)
```

### **3.2. 產生可執行 `.exe`**
如果你想要建立 Windows 可執行檔，請使用以下指令：
```sh
cd ConsoleApp
 dotnet publish -c Release -r win-x64 --self-contained true
```
執行成功後，`ConsoleApp.exe` 會出現在：
```
ConsoleApp/bin/Release/net8.0/win-x64/publish/ConsoleApp.exe
```
你可以直接執行：
```sh
cd bin/Release/net8.0/win-x64/publish/
ConsoleApp.exe
```

---
## 4. 錯誤處理與日誌記錄

- 若 `Divide(int a, int b)` 方法的除數 `b = 0`，則：
  - 回傳 `double.NaN`
  - 並寫入 `log.txt` 記錄錯誤

日誌檔案預設會儲存在 `ConsoleApp/log.txt`，可使用以下指令檢視：
```sh
cat log.txt
```

---
## 5. 常見問題

### **Q1：執行 `dotnet build` 時找不到 `MathLibrary.dll`？**
請確保：
1. `MathLibrary` 已正確編譯 (`dotnet build` 在 `MathLibrary/` 內執行)
2. `ConsoleApp` 正確參考 `MathLibrary.dll`，可嘗試重新執行：
   ```sh
   dotnet add reference ../MathLibrary/MathLibrary.csproj
   ```

### **Q2：如何在 macOS/Linux 執行？**
由於 `.exe` 只能在 Windows 執行，若要在 **macOS/Linux** 運行，請使用 `dotnet run`：
```sh
cd ConsoleApp
 dotnet run
```

---
## 6. 版本資訊

- **MathLibrary SDK** 版本：v1.0.0
- **支援平台**：Windows、macOS、Linux
- **.NET 版本**：.NET 6/7/8

---
## 7. 聯絡資訊
若有任何問題，請聯絡 [你的聯絡方式] 或提交 Issue。

