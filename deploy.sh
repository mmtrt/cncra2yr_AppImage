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
mkdir -p appimage-build/prime AppDir/winedata
wget -q "https://github.com/mmtrt/WINE_AppImage/raw/master/runtime/runtime-x86_64" -O appimage-build/prime/runtime-x86_64

mkdir -p ra2yr-mp/usr/share/icons ra2yr-mp/winedata/yr ; cp cncra2yr.desktop ra2yr-mp ; cp wrapper ra2yr-mp ; cp cncra2yr.png ra2yr-mp/usr/share/icons

YR_VERSION=$(wget -qO- https://github.com/CnCNet/cncnet-yr-client-package/releases/latest | grep -Eo "/yr-.*" | head -1 | sed 's|-| |' | cut -d'"' -f1 | awk '{print $2}')

wget -q "https://github.com/CnCNet/cncnet-yr-client-package/releases/download/yr-${YR_VERSION}/package_$(wget -qO- https://github.com/CnCNet/cncnet-yr-client-package/releases/expanded_assets/yr-${YR_VERSION} | grep -Eo "/package_.*.tar.gz" | cut -d'_' -f2)"

wget -q "https://github.com/mmtrt/dotnet-runtime_AppImage/releases/download/yr-asset/dotnet-runtime-$(wget -qO- https://github.com/mmtrt/dotnet-runtime_AppImage/releases/expanded_assets/continuous | grep -Eo me-.* | tail -1 | sed 's|-| |g' | awk '{print $2}')-x86_64.AppImage" -O AppDir/winedata/dotnet ; chmod +x AppDir/winedata/dotnet

tar -xf package*.tar.gz -C ra2yr-mp/winedata/yr ; rm package*.tar.gz

sed -i -e 's|progVer=|progVer='"${YR_VERSION}-dotnet"'|g' ra2yr-mp/wrapper

wget -q https://github.com/mmtrt/WINE_AppImage/releases/download/continuous-devel/wine-devel_$(wget -qO- https://github.com/mmtrt/WINE_AppImage/releases/expanded_assets/continuous-devel | grep -Eo 'devel_[0-9].*' | cut -d'_' -f2 | cut -d'-' -f1 | head -1)-x86_64.AppImage -O wine-stable.AppImage
chmod +x *.AppImage ; cp wine-stable.AppImage ra2yr-mp/winedata/

cp -r "ra2yr-mp/"* AppDir ; cp wine-dta.sh AppDir/winedata/

chmod +x AppDir/winedata/yr/YRLauncherUnix.sh AppDir/winedata/wine-dta.sh

# NVDV=$(wget "https://launchpad.net/~graphics-drivers/+archive/ubuntu/ppa/+packages?field.name_filter=&field.status_filter=published&field.series_filter=kinetic" -qO- | grep -Eo drivers-.*changes | sed -r "s|_| |g;s|-| |g" | tail -n1 | awk '{print $9}')

# sed -i "s|520|$NVDV|" cncra2yr.yml

./squashfs-root/AppRun --recipe cncra2yr.yml

}

cncra2yrswp () {

export WINEDLLOVERRIDES="mscoree,mshtml="
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
mkdir -p appimage-build/prime AppDir/winedata
wget -q "https://github.com/mmtrt/WINE_AppImage/raw/master/runtime/runtime-x86_64" -O appimage-build/prime/runtime-x86_64

mkdir -p ra2yr-mp/usr/share/icons ra2yr-mp/winedata ; cp cncra2yr.desktop ra2yr-mp ; cp wrapper ra2yr-mp ; cp cncra2yr.png ra2yr-mp/usr/share/icons

wget -q "https://github.com/mmtrt/dotnet-runtime_AppImage/releases/download/yr-asset/dotnet-runtime-$(wget -qO- https://github.com/mmtrt/dotnet-runtime_AppImage/releases/expanded_assets/continuous | grep -Eo me-.* | tail -1 | sed 's|-| |g' | awk '{print $2}')-x86_64.AppImage" -O AppDir/winedata/dotnet ; chmod +x AppDir/winedata/dotnet

YR_VERSION=$(wget -qO- https://github.com/CnCNet/cncnet-yr-client-package/releases/latest | grep -Eo "/yr-.*" | head -1 | sed 's|-| |' | cut -d'"' -f1 | awk '{print $2}')

wget -q "https://github.com/CnCNet/cncnet-yr-client-package/releases/download/yr-${YR_VERSION}/package_$(wget -qO- https://github.com/CnCNet/cncnet-yr-client-package/releases/expanded_assets/yr-${YR_VERSION} | grep -Eo "/package_.*.tar.gz" | cut -d'_' -f2)"

wget -q https://github.com/mmtrt/WINE_AppImage/releases/download/continuous-devel/wine-devel_$(wget -qO- https://github.com/mmtrt/WINE_AppImage/releases/expanded_assets/continuous-devel | grep -Eo 'devel_[0-9].*' | cut -d'_' -f2 | cut -d'-' -f1 | head -1)-x86_64.AppImage -O wine-stable.AppImage
chmod +x *.AppImage ; cp wine-stable.AppImage ra2yr-mp/winedata/

# Remove wrapper
rm wrapper

# Create WINEPREFIX
./wine-stable.AppImage wineboot -i ; sleep 5
./wine-stable.AppImage reg add "HKCU\\Software\\Wine\\AppDefaults\\gamemd-spawn.exe\\DllOverrides" /t REG_SZ /v ddraw /d native,builtin

# Removing any existing user data
( cd "$WINEPREFIX/drive_c/" ; rm -rf users ) || true

rm ./*.AppImage ; echo "disabled" > $WINEPREFIX/.update-timestamp ; ls -al AppDir/winedata ; ls -al AppDir/winedata/.wine

mkdir -p AppDir/winedata/yr ; cp -r "ra2yr-mp/"* AppDir ; tar -xf package*.tar.gz -C AppDir/winedata/yr ; rm package*.tar.gz ; cp wine-dta.sh AppDir/winedata/

chmod +x AppDir/winedata/yr/YRLauncherUnix.sh AppDir/winedata/wine-dta.sh

sed -i -e 's|progVer=|progVer='"${YR_VERSION}-dotnet_WP"'|g' AppDir/wrapper

sed -i 's/dotnet|/dotnet-wp|/' cncra2yr.yml

./squashfs-root/AppRun --recipe cncra2yr.yml

}

if [ "$1" == "stable" ]; then
    cncra2yrs
    ( mkdir -p dist ; mv cncra2yr*.AppImage* dist/. ; cd dist || exit ; chmod +x ./*.AppImage )
elif [ "$1" == "stablewp" ]; then
    cncra2yrswp
    ( mkdir -p dist ; mv cncra2yr*.AppImage* dist/. ; cd dist || exit ; chmod +x ./*.AppImage )
fi
