TOOLPATH = ../../z_tools/
INCPATH  = ../../z_tools/haribote/

MAKE     = make -r
NASM     = nasm
IMGTOL   = $(TOOLPATH)imgtol
COPY     = cp
DEL      = rm -f

# デフォルト動作

default :
	$(MAKE) img

# ファイル生成規則

ipl10.bin : ipl10.asm Makefile
	$(NASM) ipl10.asm -o ipl10.bin -l ipl10.lst

asmhead.bin : asmhead.asm Makefile
	$(NASM) asmhead.asm -o asmhead.bin -l asmhead.lst

nasmfunc.obj : nasmfunc.asm Makefile
	nasm -g -f elf nasmfunc.asm -o nasmfunc.obj

convertHankakuTxt : convertHankakuTxt.c
	gcc $< -o $@

hankaku.c : hankaku.txt convertHankakuTxt
	./convertHankakuTxt

%.obj : %.c
	i386-elf-gcc -c -march=i486 -m32 -nostdlib $*.c -o $@

bootpack.hrb : bootpack.c hankaku.obj graphic.obj dsctbl.obj nasmfunc.obj mysprintf.obj mystrcmp.obj int.obj fifo.obj mouse.obj keyboard.obj memory.obj sheet.obj timer.obj mtask.obj har.ld Makefile
	i386-elf-gcc -march=i486 -m32 -nostdlib -T har.ld -g nasmfunc.obj mysprintf.obj mystrcmp.obj int.obj fifo.obj graphic.obj dsctbl.obj hankaku.obj mouse.obj keyboard.obj memory.obj sheet.obj timer.obj mtask.obj bootpack.c -o bootpack.hrb

haribote.sys : asmhead.bin bootpack.hrb Makefile
	cat asmhead.bin bootpack.hrb > haribote.sys

haribote.img : ipl10.bin haribote.sys Makefile
	mformat -f 1440 -C -B ipl10.bin -i haribote.img ::
	mcopy -i haribote.img haribote.sys ::

# コマンド

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
	-$(DEL) *.bin
	-$(DEL) *.lst
	-$(DEL) *.gas
	-$(DEL) *.obj
	-$(DEL) bootpack.nas
	-$(DEL) bootpack.map
	-$(DEL) bootpack.bim
	-$(DEL) bootpack.hrb
	-$(DEL) haribote.sys
	-$(DEL) convertHankakuTxt
	-$(DEL) hankaku.c

src_only :
	$(MAKE) clean
	-$(DEL) haribote.img
