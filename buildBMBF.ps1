# Builds a .zip file for loading with BMBF
$NDKPath = Get-Content $PSScriptRoot/ndkpath.txt

$buildScript = "$NDKPath/build/ndk-build"
if (-not ($PSVersionTable.PSEdition -eq "Core")) {
    $buildScript += ".cmd"
}

& $buildScript NDK_PROJECT_PATH=$PSScriptRoot APP_BUILD_SCRIPT=$PSScriptRoot/Android.mk NDK_APPLICATION_MK=$PSScriptRoot/Application.mk
Remove-Item .\custom-fail-text_v0.1.3.zip
Compress-Archive -Path "./libs/arm64-v8a/libcustom-fail-text.so","./bmbfmod.json","./include/libs/libbeatsaber-hook_0_5_7.so" -DestinationPath "./custom-fail-text_v0.1.3.zip" -Update
