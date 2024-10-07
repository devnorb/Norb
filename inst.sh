#!/bin/bash

main() {
   json=$(curl -s "https://clientsettingscdn.roblox.com/v2/client-version/MacPlayer")

  local version=$(echo "$json" | grep -o '"clientVersionUpload":"[^"]*' | grep -o '[^"]*$')
    echo -e "[...] Installing Roblox - ($version)"
    curl "https://setup.rbxcdn.com/mac/$version-RobloxPlayer.zip" -o "./RobloxPlayer.zip"

    unzip -o -q "./RobloxPlayer.zip"
    rm -rf /Applications/Roblox.app
    mv ./RobloxPlayer.app /Applications/Roblox.app
    rm ./RobloxPlayer.zip
    xattr -c /Applications/Roblox.app
    echo -e "[...] Downloading main executable"
    curl "https://raw.githubusercontent.com/devnorb/Norb/refs/heads/main/macsploit.zip" -o "./macsploit.zip"
    curl "https://raw.githubusercontent.com/devnorb/Norb/refs/heads/main/libdiscord-rpc.zip" -o "./discord.zip"
    unzip -o -q "./macsploit.zip"
    unzip -o -q "./discord.zip"
    mv ./macsploit.dylib /Applications/Roblox.app/Contents/MacOS/macsploit.dylib
    mv ./libdiscord-rpc.dylib /Applications/Roblox.app/Contents/MacOS/libdiscord-rpc.dylib
    curl "https://raw.githubusercontent.com/devnorb/Polaris/main/ClientPatcher" -o "ClientPatcher"
    chmod +x ClientPatcher
    ./ClientPatcher "/Applications/Roblox.app/Contents/MacOS/macsploit.dylib" "/Applications/Roblox.app/Contents/MacOS/RobloxPlayer" --strip-codesig --all-yes >/dev/null 2>&1
    mv "/Applications/Roblox.app/Contents/MacOS/RobloxPlayer_patched" "/Applications/Roblox.app/Contents/MacOS/RobloxPlayer"
    echo -e "[...] Installed MacSploit"
    exit
}

main
