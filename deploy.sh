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

wget -q "https://dl.winehq.org/wine/wine-mono/5.1.1/wine-mono-5.1.1-x86.msi"
wget -q "https://downloads.cncnet.org/CnCNet5_YR_Installer.exe"
wget -q "https://download.microsoft.com/download/9/5/A/95A9616B-7A37-4AF6-BC36-D6EA96C8DAAE/dotNetFx40_Full_x86_x64.exe"
wget -q "https://download.microsoft.com/download/b/a/4/ba4a7e71-2906-4b2d-a0e1-80cf16844f5f/dotnetfx45_full_x86_x64.exe"
wget -q "https://web.archive.org/web/20120325002813/https://download.microsoft.com/download/A/C/2/AC2C903B-E6E8-42C2-9FD7-BEBAC362A930/xnafx40_redist.msi"
wget -q "https://github.com/AutoHotkey/AutoHotkey/releases/download/v1.0.48.05/AutoHotkey104805_Install.exe"

cp -Rp ./*.exe ra2yr-mp/winedata ; cp -Rp ./*.msi ra2yr-mp/winedata

export ARCH=x86_64; squashfs-root/AppRun -v ./ra2yr-mp -u "gh-releases-zsync|mmtrt|cncra2yr_AppImage|stable|cncra2yr*.AppImage.zsync" cncra2yr_${ARCH}.AppImage &>/dev/null

}

cncra2yrswp () {

export WINEDLLOVERRIDES="mshtml="
export WINEARCH="win32"
export WINEPREFIX="/home/runner/.wine"
export WINEDEBUG="-all"

cncra2yrs ; rm ./*AppImage*

WINE_VER="$(wget -qO- https://dl.winehq.org/wine-builds/ubuntu/dists/focal/main/binary-i386/ | grep wine-devel | sed 's|_| |g;s|~| |g' | awk '{print $5}' | tail -n1)"
wget -q https://github.com/mmtrt/WINE_AppImage/releases/download/continuous-devel/wine-devel_${WINE_VER}-x86_64.AppImage
chmod +x *.AppImage ; mv wine-devel_${WINE_VER}-x86_64.AppImage wine-devel.AppImage

# Create winetricks & wine cache
mkdir -p /home/runner/.cache/{wine,winetricks}/{dotnet40,dotnet45,ahk,xna40} ; cp dotNetFx40_Full_x86_x64.exe /home/runner/.cache/winetricks/dotnet40 ; cp dotnetfx45_full_x86_x64.exe /home/runner/.cache/winetricks/dotnet45 ; cp xnafx40_redist.msi /home/runner/.cache/winetricks/xna40
cp -Rp ./wine*.msi /home/runner/.cache/wine/ ; cp -Rp AutoHotkey104805_Install.exe /home/runner/.cache/winetricks/ahk

# Create WINEPREFIX
./wine-devel.AppImage winetricks -q xna40 dotnet45 ; sleep 5

# Create empty files
mkdir -p Westwood/RA2 ; ( cd Westwood/RA2 || exit ; touch BINKW32.dll BLOWFISH.dll ra2.mix ra2md.mix language.mix langmd.mix )

# Install game
( ./wine-devel.AppImage wine CnCNet5_YR_Installer.exe /silent ; sleep 5 )

# cp -Rp tmp/* TiberianSun_Online/ ; rm ./*.7z
cp -Rp ./Westwood "$WINEPREFIX"/drive_c/

# Removing any existing user data
( cd "$WINEPREFIX/drive_c/" ; rm -rf users ) || true

cp -Rp $WINEPREFIX ra2yr-mp/ ; rm -rf $WINEPREFIX ; rm -rf ./ra2yr-mp/winedata ; rm ./*.AppImage

# ( cd ra2yr-mp || exit ; wget -qO- 'https://gist.github.com/mmtrt/49df9fc50ae567a3d5d89791bdb65d45/raw/74fc5c9d2ad9e00b27db408ca0c68be612e31dc6/cncra2yrswp.patch' | patch -p1 )

export ARCH=x86_64; squashfs-root/AppRun -v ./ra2yr-mp -n -u "gh-releases-zsync|mmtrt|cncra2yr_AppImage|stable-wp|cncra2yr*.AppImage.zsync" cncra2yr_WP-${ARCH}.AppImage &>/dev/null

}

if [ "$1" == "stable" ]; then
    cncra2yrs
    ( mkdir -p dist ; mv cncra2yr*.AppImage* dist/. ; cd dist || exit ; chmod +x ./*.AppImage )
elif [ "$1" == "stablewp" ]; then
    cncra2yrswp
    ( mkdir -p dist ; mv cncra2yr*.AppImage* dist/. ; cd dist || exit ; chmod +x ./*.AppImage )
fi
