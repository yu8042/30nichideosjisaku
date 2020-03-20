TOOLPATH = ../../z_tools/
MAKE     = make -r
NASM     = nasm
EDIMG    = mformat
IMGTOL   = $(TOOLPATH)imgtol
COPY     = cp
DEL      = rm -f

# デフォルト動作

default :
	$(MAKM) img

# ファイル生成規則

ipl.bin : ipl.asm Makefile
	$(NASM) ipl.asm -o ipl.bin -l ipl.lst

haribote.img : ipl.bin Makefile
	$(EDIMG) -f 1440 -C -B ipl.bin -i haribote.img ::

# コマンド

asm :
	$(MAKE) ipl.bin

img :
	$(MAKE) haribote.img

run :
	$(MAKE) img
	$(COPY) haribote.img ../../z_tools/qemu/fdimage0.bin
	$(MAKE) -C ../../z_tools/qemu

install :
	$(MAKE) img
	$(IMGTOL) w a: haribote.img

clean :
	-$(DEL) ipl.bin
	-$(DEL) ipl.lst

src_only :
	$(MAKE) clean
	-$(DEL) haribote.img
