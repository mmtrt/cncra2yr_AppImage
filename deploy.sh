#!/bin/bash

cncra2yrs () {

# Download icon:
wget -q https://github.com/mmtrt/cncra2yr/raw/master/snap/gui/cncra2yr.png

wget -q "https://github.com/AppImageCrafters/appimage-builder/releases/download/v1.0.3/appimage-builder-1.0.3-x86_64.AppImage" -O builder ; chmod +x builder ; ./builder --appimage-extract &>/dev/null

# add custom mksquashfs
wget -q "https://github.com/mmtrt/WINE_AppImage/raw/master/runtime/mksquashfs" -O squashfs-root/usr/bin/mksquashfs

# force zstd format in appimagebuilder for appimages
rm builder ; sed -i 's|xz|zstd|' squashfs-root/usr/lib/python3.8/site-packages/appimagebuilder/modules/prime/appimage_primer.py

# Add static appimage runtime
mkdir -p appimage-build/prime
wget -q "https://github.com/mmtrt/WINE_AppImage/raw/master/runtime/runtime-x86_64" -O appimage-build/prime/runtime-x86_64

mkdir -p ra2yr-mp/usr/share/icons ra2yr-mp/winedata ; cp cncra2yr.desktop ra2yr-mp ; cp wrapper ra2yr-mp ; cp cncra2yr.png ra2yr-mp/usr/share/icons

YR_VERSION=$(wget -qO- https://github.com/CnCNet/cncnet-yr-client-package/releases | grep -Eo "/yr-.*" | head -1 | sed 's|-| |' | cut -d'"' -f1 | awk '{print $2}')

wget -q "https://dl.winehq.org/wine/wine-mono/4.7.5/wine-mono-4.7.5.msi"
wget -q "https://downloads.cncnet.org/CnCNet5_YR_Installer.exe"
wget -q "https://download.microsoft.com/download/9/5/A/95A9616B-7A37-4AF6-BC36-D6EA96C8DAAE/dotNetFx40_Full_x86_x64.exe"
wget -q "https://web.archive.org/web/20120325002813/https://download.microsoft.com/download/A/C/2/AC2C903B-E6E8-42C2-9FD7-BEBAC362A930/xnafx40_redist.msi"

cp -Rp ./*.exe ra2yr-mp/winedata ; cp -Rp ./*.msi ra2yr-mp/winedata
sed -i -e 's|progVer=|progVer='"$YR_VERSION"'|g' ra2yr-mp/wrapper

mkdir -p AppDir/winedata ; cp -r "ra2yr-mp/"* AppDir

# NVDV=$(wget "https://launchpad.net/~graphics-drivers/+archive/ubuntu/ppa/+packages?field.name_filter=&field.status_filter=published&field.series_filter=kinetic" -qO- | grep -Eo drivers-.*changes | sed -r "s|_| |g;s|-| |g" | tail -n1 | awk '{print $9}')

# sed -i "s|520|$NVDV|" cncra2yr.yml

./squashfs-root/AppRun --recipe cncra2yr.yml

}

cncra2yrswp () {

export WINEDLLOVERRIDES="mshtml="
export WINEARCH="win32"
export WINEPREFIX="/home/runner/work/cncra2yr_AppImage/cncra2yr_AppImage/AppDir/winedata/.wine"
export WINEDEBUG="-all"

# Download icon:
wget -q https://github.com/mmtrt/cncra2yr/raw/master/snap/gui/cncra2yr.png

wget -q "https://github.com/AppImageCrafters/appimage-builder/releases/download/v1.0.3/appimage-builder-1.0.3-x86_64.AppImage" -O builder ; chmod +x builder ; ./builder --appimage-extract &>/dev/null

# add custom mksquashfs
wget -q "https://github.com/mmtrt/WINE_AppImage/raw/master/runtime/mksquashfs" -O squashfs-root/usr/bin/mksquashfs

# force zstd format in appimagebuilder for appimages
rm builder ; sed -i 's|xz|zstd|' squashfs-root/usr/lib/python3.8/site-packages/appimagebuilder/modules/prime/appimage_primer.py

# Add static appimage runtime
mkdir -p appimage-build/prime
wget -q "https://github.com/mmtrt/WINE_AppImage/raw/master/runtime/runtime-x86_64" -O appimage-build/prime/runtime-x86_64

mkdir -p ra2yr-mp/usr/share/icons ra2yr-mp/winedata ; cp cncra2yr.desktop ra2yr-mp ; cp wrapper ra2yr-mp ; cp cncra2yr.png ra2yr-mp/usr/share/icons

YR_VERSION=$(wget -qO- https://github.com/CnCNet/cncnet-yr-client-package/releases | grep -Eo "/yr-.*" | head -1 | sed 's|-| |' | cut -d'"' -f1 | awk '{print $2}')

wget -q "https://downloads.cncnet.org/CnCNet5_YR_Installer.exe"
wget -q "https://download.microsoft.com/download/9/5/A/95A9616B-7A37-4AF6-BC36-D6EA96C8DAAE/dotNetFx40_Full_x86_x64.exe"
wget -q "https://web.archive.org/web/20120325002813/https://download.microsoft.com/download/A/C/2/AC2C903B-E6E8-42C2-9FD7-BEBAC362A930/xnafx40_redist.msi"

wget -q https://github.com/mmtrt/WINE_AppImage/releases/download/continuous-stable-4-multi/wine-stable-multi_4.0.4-x86_64.AppImage -O wine-stable.AppImage
chmod +x *.AppImage

# Create winetricks & wine cache
mkdir -p /home/runner/.cache/{wine,winetricks}/{dotnet40,ahk,xna40} ; cp dotNetFx40_Full_x86_x64.exe /home/runner/.cache/winetricks/dotnet40 ; cp xnafx40_redist.msi /home/runner/.cache/winetricks/xna40
rm wrapper

# Create WINEPREFIX
mkdir -p "$WINEPREFIX/drive_c/windows/assembly"
./wine-stable.AppImage winetricks -q xna40 vcrun2010; sleep 5

# Create empty files
mkdir -p "$WINEPREFIX/drive_c/Westwood/RA2" ; ( cd "$WINEPREFIX/drive_c/Westwood/RA2" || exit ; touch BINKW32.dll BLOWFISH.dll ra2.mix ra2md.mix language.mix langmd.mix )

# Install game
( ./wine-stable.AppImage CnCNet5_YR_Installer.exe /silent ; sleep 5 )

# Removing any existing user data
( cd "$WINEPREFIX/drive_c/" ; rm -rf users ) || true
( cd "$WINEPREFIX/drive_c/Westwood/RA2" ; rm BINKW32.dll BLOWFISH.dll ra2.mix ra2md.mix language.mix langmd.mix ) || true

rm ./*.AppImage ; echo "disabled" > $WINEPREFIX/.update-timestamp

mkdir -p AppDir/winedata ; cp -r "ra2yr-mp/"* AppDir

# NVDV=$(wget "https://launchpad.net/~graphics-drivers/+archive/ubuntu/ppa/+packages?field.name_filter=&field.status_filter=published&field.series_filter=kinetic" -qO- | grep -Eo drivers-.*changes | sed -r "s|_| |g;s|-| |g" | tail -n1 | awk '{print $9}')

# sed -i "s|520|$NVDV|" cncra2yr.yml

sed -i -e 's|progVer=|progVer='"${YR_VERSION}_WP"'|g' AppDir/wrapper

sed -i 's/stable|/stable-wp|/' cncra2yr.yml

./squashfs-root/AppRun --recipe cncra2yr.yml

}

if [ "$1" == "stable" ]; then
    cncra2yrs
    ( mkdir -p dist ; mv cncra2yr*.AppImage* dist/. ; cd dist || exit ; chmod +x ./*.AppImage )
elif [ "$1" == "stablewp" ]; then
    cncra2yrswp
    ( mkdir -p dist ; mv cncra2yr*.AppImage* dist/. ; cd dist || exit ; chmod +x ./*.AppImage )
fi
