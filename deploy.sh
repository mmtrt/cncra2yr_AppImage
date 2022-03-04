#!/bin/bash

cncra2yrs () {

# Convert and copy icon which is needed for desktop integration into place:
wget -q https://github.com/mmtrt/cncra2yr/raw/master/snap/gui/cncra2yr.png
for width in 8 16 22 24 32 36 42 48 64 72 96 128 192 256; do
    dir=icons/hicolor/${width}x${width}/apps
    mkdir -p $dir
    convert cncra2yr.png -resize ${width}x${width} $dir/cncra2yr.png
done

wget -q "https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage"
chmod +x ./appimagetool-x86_64.AppImage
./appimagetool-x86_64.AppImage --appimage-extract &>/dev/null

mkdir -p ra2yr-mp/usr ra2yr-mp/winedata ; cp cncra2yr.desktop ra2yr-mp ; cp AppRun ra2yr-mp ;
cp -r icons ra2yr-mp/usr/share ; cp cncra2yr.png ra2yr-mp

WINE_VER=$(wget -qO- "https://github.com/mmtrt/WINE_AppImage/releases/tag/continuous-devel" | grep x86_64 | cut -d'"' -f2 | sed 's|_| |g;s|-| |g' |awk '{print $5}'| head -1)
MONO_VER=$(wget 2>/dev/null "https://source.winehq.org/source/dlls/appwiz.cpl/addons.c?%21v=wine-${WINE_VER}" -qSO- | grep -Po 'MONO_VERSION</a>.*[0-9]"' addon | cut -d'"' -f4)

wget -q "https://dl.winehq.org/wine/wine-mono/${MONO_VER}/wine-mono-${MONO_VER}-x86.msi"
wget -q "https://downloads.cncnet.org/CnCNet5_YR_Installer.exe"
wget -q "https://download.microsoft.com/download/9/5/A/95A9616B-7A37-4AF6-BC36-D6EA96C8DAAE/dotNetFx40_Full_x86_x64.exe"
wget -q "https://download.microsoft.com/download/b/a/4/ba4a7e71-2906-4b2d-a0e1-80cf16844f5f/dotnetfx45_full_x86_x64.exe"
wget -q "https://web.archive.org/web/20120325002813/https://download.microsoft.com/download/A/C/2/AC2C903B-E6E8-42C2-9FD7-BEBAC362A930/xnafx40_redist.msi"

cp -Rp ./*.exe ra2yr-mp/winedata ; cp -Rp ./*.msi ra2yr-mp/winedata

export ARCH=x86_64; squashfs-root/AppRun -v ./ra2yr-mp -u "gh-releases-zsync|mmtrt|cncra2yr_AppImage|stable|cncra2yr*.AppImage.zsync" cncra2yr_${ARCH}.AppImage &>/dev/null

}

cncra2yrswp () {

export WINEDLLOVERRIDES="mshtml="
export WINEARCH="win32"
export WINEPREFIX="/home/runner/.wine"
export WINEDEBUG="-all"

cncra2yrs ; rm ./*AppImage*

WINE_VER="$(wget -qO- https://github.com/mmtrt/WINE_AppImage/releases/tag/continuous-devel | grep x86_64 | cut -d'"' -f2 | sed 's|_| |g;s|-| |g' |awk '{print $5}'| head -1)"
wget -q https://github.com/mmtrt/WINE_AppImage/releases/download/continuous-devel/wine-devel_${WINE_VER}-x86_64.AppImage
chmod +x *.AppImage ; mv wine-devel_${WINE_VER}-x86_64.AppImage wine-devel.AppImage

# Create winetricks & wine cache
mkdir -p /home/runner/.cache/{wine,winetricks}/{dotnet40,dotnet45,ahk,xna40} ; cp dotNetFx40_Full_x86_x64.exe /home/runner/.cache/winetricks/dotnet40 ; cp dotnetfx45_full_x86_x64.exe /home/runner/.cache/winetricks/dotnet45 ; cp xnafx40_redist.msi /home/runner/.cache/winetricks/xna40
cp -Rp ./wine*.msi /home/runner/.cache/wine/

# Create WINEPREFIX
./wine-devel.AppImage winetricks -q xna40 dotnet45 ; sleep 5

# Create empty files
mkdir -p "$WINEPREFIX/drive_c/Westwood/RA2" ; ( cd "$WINEPREFIX/drive_c/Westwood/RA2" || exit ; touch BINKW32.dll BLOWFISH.dll ra2.mix ra2md.mix language.mix langmd.mix )

# Install game
( ./wine-devel.AppImage wine CnCNet5_YR_Installer.exe /silent ; sleep 5 )

# Removing any existing user data
( cd "$WINEPREFIX/drive_c/" ; rm -rf users ) || true
( cd "$WINEPREFIX/drive_c/Westwood/RA2" ; rm BINKW32.dll BLOWFISH.dll ra2.mix ra2md.mix language.mix langmd.mix ) || true

cp -Rp $WINEPREFIX ra2yr-mp/ ; rm -rf $WINEPREFIX ; rm -rf ./ra2yr-mp/winedata ; rm ./*.AppImage

( cd ra2yr-mp || exit ; wget -qO- 'https://gist.github.com/mmtrt/b9c4b31672a36ece26d07bea0e9b7a17/raw/e0d4f329e4e380073e17c6a0c584068030390364/cncra2yrswp.patch' | patch -p1 )

export ARCH=x86_64; squashfs-root/AppRun -v ./ra2yr-mp -n -u "gh-releases-zsync|mmtrt|cncra2yr_AppImage|stable-wp|cncra2yr*.AppImage.zsync" cncra2yr_WP-${ARCH}.AppImage &>/dev/null

}

if [ "$1" == "stable" ]; then
    cncra2yrs
    ( mkdir -p dist ; mv cncra2yr*.AppImage* dist/. ; cd dist || exit ; chmod +x ./*.AppImage )
elif [ "$1" == "stablewp" ]; then
    cncra2yrswp
    ( mkdir -p dist ; mv cncra2yr*.AppImage* dist/. ; cd dist || exit ; chmod +x ./*.AppImage )
fi
