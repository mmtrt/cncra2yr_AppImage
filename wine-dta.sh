#!/bin/sh

progWINE=cncra2yr-x.xx-x86_64.AppImage
progBin=gamemd-spawn.exe

if command -v "$OWD/$progWINE" > /dev/null 2>&1  ; then
"$OWD/$progWINE" "$progBin" "$*"
fi

if command -v "$HOME/Downloads/$progWINE" > /dev/null 2>&1  ; then
"$HOME/Downloads/$progWINE" "$progBin" "$*"
fi

if command -v "$HOME/$progWINE" > /dev/null 2>&1 ; then
"$HOME/$progWINE" "$progBin" "$*"
fi

if command -v "$HOME/Desktop/$progWINE" > /dev/null 2>&1 ; then
"$HOME/Desktop/$progWINE" "$progBin" "$*"
fi

if command -v "$HOME/bin/$progWINE" > /dev/null 2>&1 ; then
"$HOME/bin/$progWINE" "$progBin" "$*"
fi

if command -v "$HOME/.local/bin/$progWINE" > /dev/null 2>&1 ; then
"$HOME/.local/bin/$progWINE" "$progBin" "$*"
fi
