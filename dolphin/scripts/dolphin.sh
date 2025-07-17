#!/bin/bash

directory=$(dirname "$1" | cut -d "/" -f2)

rm -rf ~/.local/share/dolphin-emu/GC
rm -rf ~/.local/share/dolphin-emu/Wii
rm -rf ~/.local/share/dolphin-emu/StateSaves
rm -rf ~/.local/share/dolphin-emu/ScreenShots

if [[ ! -d "/$directory/gc/GC" ]]; then
  mkdir /$directory/gc/GC
fi

if [[ ! -d "/$directory/gc/Wii" ]]; then
  mkdir /$directory/gc/Wii
fi

if [[ ! -d "/$directory/gc/StateSaves" ]]; then
  mkdir /$directory/gc/StateSaves
fi

if [[ ! -d "/$directory/gc/ScreenShots" ]]; then
  mkdir /$directory/gc/ScreenShots
fi

ln -s /$directory/gc/GC ~/.local/share/dolphin-emu/
ln -s /$directory/gc/Wii ~/.local/share/dolphin-emu/
ln -s /$directory/gc/StateSaves ~/.local/share/dolphin-emu/
ln -s /$directory/gc/ScreenShots ~/.local/share/dolphin-emu/

export DOLPHIN_EMU_USERPATH="${HOME}/.local/share/dolphin-emu/"

/opt/dolphin/dolphin-emu-nogui -p drm -a HLE -e "${1}"

