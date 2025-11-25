#!/bin/sh

progWINE=cncra2yr-x.xx-x86_64.AppImage

if command -v "$OWD/$progWINE" > /dev/null 2>&1  ; then
"$OWD/$progWINE" ./Qt/CnCNetQM.exe
fi

if command -v "$HOME/Downloads/$progWINE" > /dev/null 2>&1  ; then
"$HOME/Downloads/$progWINE" ./Qt/CnCNetQM.exe
fi

if command -v "$HOME/$progWINE" > /dev/null 2>&1 ; then
"$HOME/$progWINE" ./Qt/CnCNetQM.exe
fi

if command -v "$HOME/Desktop/$progWINE" > /dev/null 2>&1 ; then
"$HOME/Desktop/$progWINE" ./Qt/CnCNetQM.exe
fi

if command -v "$HOME/bin/$progWINE" > /dev/null 2>&1 ; then
"$HOME/bin/$progWINE" ./Qt/CnCNetQM.exe
fi

if command -v "$HOME/.local/bin/$progWINE" > /dev/null 2>&1 ; then
"$HOME/.local/bin/$progWINE" ./Qt/CnCNetQM.exe
fi
