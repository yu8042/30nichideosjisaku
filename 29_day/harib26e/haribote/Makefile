OBJS_BOOTPACK = bootpack.obj nasmfunc.obj hankaku.obj graphic.obj dsctbl.obj \
		int.obj fifo.obj keyboard.obj mouse.obj memory.obj sheet.obj timer.obj \
		mtask.obj window.obj console.obj file.obj mysprintf.obj mystrcmp.obj mystrlen.obj

TOOLPATH = ../../../z_tools/
INCPATH  = ../../../z_tools/haribote/

MAKE     = make -r
NASM     = nasm
CC1      = $(TOOLPATH)gocc1 -I$(INCPATH) -Os -Wall -quiet
GAS2NASK = $(TOOLPATH)gas2nask -a
OBJ2BIM  = $(TOOLPATH)obj2bim
MAKEFONT = $(TOOLPATH)makefont
BIN2OBJ  = $(TOOLPATH)bin2obj
BIM2HRB  = $(TOOLPATH)bim2hrb
RULEFILE = ../haribote.rul
EDIMG    = $(TOOLPATH)edimg
IMGTOL   = $(TOOLPATH)imgtol
GOLIB    = $(TOOLPATH)golib00
COPY     = cp
DEL      = rm -f

# デフォルト動作

default :
	$(MAKE) ipl20.bin
	$(MAKE) haribote.sys

# ファイル生成規則

ipl20.bin : ipl20.asm Makefile
	$(NASM) ipl20.asm -o ipl20.bin -l ipl20.lst

asmhead.bin : asmhead.asm Makefile
	$(NASM) asmhead.asm -o asmhead.bin -l asmhead.lst

convertHankakuTxt : convertHankakuTxt.c
	gcc $< -o $@

hankaku.c : hankaku.txt convertHankakuTxt
	./convertHankakuTxt

bootpack.hrb : $(OBJS_BOOTPACK) har.ld Makefile
	i386-elf-gcc -march=i486 -m32 -nostdlib -T har.ld -g $(OBJS_BOOTPACK) -o bootpack.hrb

haribote.sys : asmhead.bin bootpack.hrb Makefile
	cat asmhead.bin bootpack.hrb > haribote.sys

# 一般規則

%.obj : %.asm Makefile ../app_make.txt
	$(NASM) -f elf32 $*.asm -o $@

%.obj : %.c ../apilib.h Makefile ../app_make.txt
	i386-elf-gcc -c -march=i486 -m32 -I../ -nostdlib $*.c -o $@

# �R�}���h

clean :
	-$(DEL) asmhead.bin
	-$(DEL) hankaku.bin
	-$(DEL) *.lst
	-$(DEL) *.obj
	-$(DEL) *.map
	-$(DEL) *.bim
	-$(DEL) *.hrb
	-$(DEL) hankaku.c
	-$(DEL) convertHankakuTxt

src_only :
	$(MAKE) clean
	-$(DEL) ipl20.bin
	-$(DEL) haribote.sys
