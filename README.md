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
 * This AppImage uses [WINE AppImage Devel](https://github.com/mmtrt/WINE_AppImage/releases/tag/continuous-devel) which is separate AppImage and requires it to function as it does not have any WINE, So Download WINE AppImage make it executable also make sure you have single copy of it present any of these path `"$HOME/Downloads"` `"$HOME/bin"` `"$HOME/.local/bin"`.
 * This AppImage has two versions one stable only contains required files to install game with all redistributable which takes quite time to first boot as it installs all theses requirements and other one have all these preinstalled inside wineprefix which boots instant.

## Note
 * If you get `Microsoft.Xna.Framework.dll` error then do `mkdir -p $HOME/.cncra2yr/.wine/drive_c/windows/Microsoft.NET/assembly/GAC_32` in terminal.

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
