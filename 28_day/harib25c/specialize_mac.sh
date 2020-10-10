#!/bin/bash

find . -name "*.bat" -type f -delete
find . -name "TRANS.TBL" -type f -delete
mv haribote/naskfunc.nas haribote/nasmfunc.asm
find . -name "*.nas" -exec bash -c 'mv "$1" "${1%.nas}.asm"' _ {} \;

