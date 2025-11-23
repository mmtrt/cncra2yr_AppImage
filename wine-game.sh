#!/bin/sh

progWINE=cncra2yr-x.xx-x86_64.AppImage

if command -v "$OWD/$progWINE" > /dev/null 2>&1  ; then
"$OWD/$progWINE" Syringe.exe -i=Ares.dll -i=CnCNet-Spawner.dll -i=Phobos.dll \ "gamemd-spawn.exe" -SPAWN -LOG -CD -RA2ModeSaveID=0x8d113b94
fi

if command -v "$HOME/Downloads/$progWINE" > /dev/null 2>&1  ; then
"$HOME/Downloads/$progWINE" Syringe.exe -i=Ares.dll -i=CnCNet-Spawner.dll -i=Phobos.dll \ "gamemd-spawn.exe" -SPAWN -LOG -CD -RA2ModeSaveID=0x8d113b94
fi

if command -v "$HOME/$progWINE" > /dev/null 2>&1 ; then
"$HOME/$progWINE" Syringe.exe -i=Ares.dll -i=CnCNet-Spawner.dll -i=Phobos.dll \ "gamemd-spawn.exe" -SPAWN -LOG -CD -RA2ModeSaveID=0x8d113b94
fi

if command -v "$HOME/Desktop/$progWINE" > /dev/null 2>&1 ; then
"$HOME/Desktop/$progWINE" Syringe.exe -i=Ares.dll -i=CnCNet-Spawner.dll -i=Phobos.dll \ "gamemd-spawn.exe" -SPAWN -LOG -CD -RA2ModeSaveID=0x8d113b94
fi

if command -v "$HOME/bin/$progWINE" > /dev/null 2>&1 ; then
"$HOME/bin/$progWINE" Syringe.exe -i=Ares.dll -i=CnCNet-Spawner.dll -i=Phobos.dll \ "gamemd-spawn.exe" -SPAWN -LOG -CD -RA2ModeSaveID=0x8d113b94
fi

if command -v "$HOME/.local/bin/$progWINE" > /dev/null 2>&1 ; then
"$HOME/.local/bin/$progWINE" Syringe.exe -i=Ares.dll -i=CnCNet-Spawner.dll -i=Phobos.dll \ "gamemd-spawn.exe" -SPAWN -LOG -CD -RA2ModeSaveID=0x8d113b94
fi
