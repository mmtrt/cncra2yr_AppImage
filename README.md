<p align="center">
    <img src="https://github.com/mmtrt/cncra2yr/raw/master/snap/gui/cncra2yr.png" alt="cncra2yr logo" width=128 height=128>

<h2 align="center">cncra2yr AppImage</h2>

  <p align="center">cncra2yr Stable (unofficial) AppImages by GitHub Actions Continuous Integration
    <br>
    <a href="https://github.com/mmtrt/cncra2yr_AppImage/issues/new">Report bug</a>
    ·
    <a href="https://github.com/mmtrt/cncra2yr_AppImage/issues/new">Request feature</a>
    ·
    <a href="https://github.com/mmtrt/cncra2yr_AppImage/releases">Download AppImage</a>
  </p>
</p>

## Info
 * This AppImage does not have game files see requirements below before getting angry at me.
 * This AppImage uses [wine-devel_AppImage](https://github.com/mmtrt/WINE_AppImage/releases/tag/continuous-devel) which is included in the AppImage.
 * This AppImage uses [dotnet_runtime_AppImage](https://github.com/mmtrt/dotnet-runtime_AppImage/releases/tag/yr-asset) which is included in the AppImage.
 * This AppImage has two versions one stable only contains required files to install game with all redistributable which takes quite time to first boot as it installs all theses requirements and other one have all these preinstalled inside wineprefix which boots instant.

## Get Started

Download the latest release from

| Stable | Stable-WP |
| ------- | --------- |
| <img src="https://github.com/mmtrt/cncra2yr/raw/master/snap/gui/cncra2yr.png" height=100> | <img src="https://github.com/mmtrt/cncra2yr/raw/master/snap/gui/cncra2yr.png" height=100> |
| [Download](https://github.com/mmtrt/cncra2yr_AppImage/releases/tag/stable) | [Download](https://github.com/mmtrt/cncra2yr_AppImage/releases/tag/stable-wp) |


### Executing
#### File Manager
Just double click the `*.AppImage` file and you are done!

> In normal cases, the above method should work, but in some rare cases
the `+x` permissisions. So, right click > Properties > Allow Execution

#### Terminal
```bash
./cncra2yr-*.AppImage
```
```bash
chmod +x cncra2yr-*.AppImage
./cncra2yr-*.AppImage
```

In case, if FUSE support libraries are not installed on the host system, it is
still possible to run the AppImage

```bash
./cncra2yr-*.AppImage --appimage-extract
cd squashfs-root
./AppRun
```

## Requirements
 * Original game files of `Red Alert 2 Yuri's Revenge`.
```
BINKW32.dll
BLOWFISH.dll
ra2.mix
ra2md.mix
language.mix
langmd.mix
```
