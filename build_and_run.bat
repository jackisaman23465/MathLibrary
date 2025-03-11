#!/bin/bash

# 設定變數
MATHLIB_DIR="MathLibrary"
MathLibTest_DIR="MathLibraryTest"

# 確保 .NET SDK 可用
if ! command -v dotnet &> /dev/null; then
    echo "錯誤: 未安裝 .NET SDK，請安裝後重試。"
    exit 1
fi

# 編譯 MathLibrary.dll
echo "🔧 正在編譯 MathLibrary..."
cd $MATHLIB_DIR || exit
dotnet build
cd ..

# 檢查是否成功產生 DLL
DLL_PATH="$MATHLIB_DIR/bin/Debug/net8.0/MathLibrary.dll"
if [ ! -f "$DLL_PATH" ]; then
    echo "❌ 錯誤: 無法找到 MathLibrary.dll，請確認編譯過程無誤。"
    exit 1
fi
echo "✅ MathLibrary.dll 編譯完成！"

# 參考 DLL（如果MathLibraryTest未參考則自動添加）
cd $MathLibTest_DIR || exit
if ! grep -q "MathLibrary" MathLibraryTest.csproj; then
    echo "🔗 新增 MathLibrary 參考..."
    dotnet add reference ../$MATHLIB_DIR/MathLibrary.csproj
fi

# 執行 MathLibraryTest
echo "🚀 執行 MathLibraryTest..."
dotnet run

# 判斷作業系統
OS_TYPE=$(uname)

if [[ "$OS_TYPE" == "MINGW"* || "$OS_TYPE" == "CYGWIN"* || "$OS_TYPE" == "MSYS"* ]]; then
    echo "📦 產生執行檔 (Windows)..."
    dotnet publish -c Release -r win-x64 --self-contained true

    # 設定可執行檔的路徑
    EXE_PATH="MathLibraryTest/bin/Release/net8.0/win-x64/publish/MathLibraryTest.exe"

    # 確認執行檔是否存在
    if [ -f "$EXE_PATH" ]; then
        echo "✅ 執行檔產生成功！位置: $EXE_PATH"
    else
        echo "❌ 錯誤: 無法產生 .exe 檔案。"
        exit 1
    fi
else
    echo "⚠️ 當前作業系統不是 Windows，跳過 .exe 產生步驟。"
fi
