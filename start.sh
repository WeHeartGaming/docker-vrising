#!/bin/bash

d=/app/data
s=/app/steamcmd
v=/app/vrisingserver

cd "$s"
curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -
./steamcmd.sh +@sSteamCmdForcePlatformType windows +force_install_dir $v +login anonymous +app_update 1829350 validate +quit

if [ ! -f "$d/Settings/ServerGameSettings.json" ]; then
        echo "$d/Settings/ServerGameSettings.json not found. Copying default file."
        cp "$v/VRisingServer_Data/StreamingAssets/Settings/ServerGameSettings.json" "$d/Settings/"
fi
if [ ! -f "$d/Settings/ServerHostSettings.json" ]; then
        echo "$d/Settings/ServerHostSettings.json not found. Copying default file."
        cp "$v/VRisingServer_Data/StreamingAssets/Settings/ServerHostSettings.json" "$d/Settings/"
fi

cd "$v"
rm -r /tmp/.X0-lock
echo "Starting Xvfb"
Xvfb :0 -screen 0 1024x768x16 &

echo "Launching V Rising server"
echo " "
WINEPREFIX=/app/.wine WINEARCH=win64 DISPLAY=:0.0 wine VRisingServer.exe -persistentDataPath $d
