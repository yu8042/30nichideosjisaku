OBJS_API =	api001.obj api002.obj api003.obj api004.obj api005.obj api006.obj \
			api007.obj api008.obj api009.obj api010.obj api011.obj api012.obj \
			api013.obj api014.obj api015.obj api016.obj api017.obj api018.obj \
			api019.obj api020.obj

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
	$(MAKE) apilib.lib

# ファイル生成規則

apilib.lib : $(OBJS_API)
	i386-elf-ar r apilib.lib $(OBJS_API)

# 一般規則

%.obj : %.asm Makefile
	$(NASM) -f elf32 $*.asm -o $@ -l $*.lst

# コマンド

clean :
	-$(DEL) *.lst
	-$(DEL) *.obj

src_only :
	$(MAKE) clean
	-$(DEL) apilib.lib
