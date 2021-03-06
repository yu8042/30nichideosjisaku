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

hello.hrb : hello.asm Makefile
	$(NASM) hello.asm -o hello.hrb

hello2.hrb : hello2.asm Makefile
	$(NASM) hello2.asm -o hello2.hrb

hello5.bin : hello5.asm Makefile
	$(NASM) -f elf32 hello5.asm -o hello5.bin

a_nasm.bin : a_nasm.asm Makefile
	$(NASM) -f elf32 a_nasm.asm -o a_nasm.bin

nasmfunc.obj : nasmfunc.asm Makefile
	nasm -g -f elf nasmfunc.asm -o nasmfunc.obj

convertHankakuTxt : convertHankakuTxt.c
	gcc $< -o $@

hankaku.c : hankaku.txt convertHankakuTxt
	./convertHankakuTxt

%.obj : %.c
	i386-elf-gcc -c -march=i486 -m32 -nostdlib $*.c -o $@

a.hrb : a_nasm.bin a.obj api.ld Makefile
	i386-elf-ld -o a.hrb -T api.ld a_nasm.bin a.obj

hello3.hrb : a_nasm.bin hello3.obj api.ld Makefile
	i386-elf-ld -o hello3.hrb -T api.ld a_nasm.bin hello3.obj

hello4.hrb : a_nasm.bin hello4.obj api.ld Makefile
	i386-elf-ld -Map hello4.map -o hello4.hrb -T api.ld a_nasm.bin hello4.obj

hello5.hrb : a_nasm.bin hello5.bin api.ld Makefile
	i386-elf-ld -Map hello5.map -o hello5.hrb -T api.ld a_nasm.bin hello5.bin

bug1.hrb : a_nasm.bin bug1.obj api.ld Makefile
	i386-elf-ld -o bug1.hrb -T api.ld a_nasm.bin bug1.obj

bug2.hrb : a_nasm.bin bug2.obj api.ld Makefile
	i386-elf-ld -o bug2.hrb -T api.ld a_nasm.bin bug2.obj

bug3.hrb : a_nasm.bin bug3.obj api.ld Makefile
	i386-elf-ld -o bug3.hrb -T api.ld a_nasm.bin bug3.obj

winhelo.hrb : a_nasm.bin winhelo.obj api.ld Makefile
	i386-elf-ld -Map winhelo.map -o winhelo.hrb -T api.ld a_nasm.bin winhelo.obj

bootpack.hrb : bootpack.c hankaku.obj graphic.obj dsctbl.obj nasmfunc.obj mysprintf.obj mystrcmp.obj int.obj fifo.obj mouse.obj keyboard.obj memory.obj sheet.obj timer.obj mtask.obj window.obj console.obj file.obj har.ld Makefile
	i386-elf-gcc -march=i486 -m32 -nostdlib -T har.ld -g nasmfunc.obj mysprintf.obj mystrcmp.obj int.obj fifo.obj graphic.obj dsctbl.obj hankaku.obj mouse.obj keyboard.obj memory.obj sheet.obj timer.obj mtask.obj window.obj console.obj file.obj bootpack.c -o bootpack.hrb

haribote.sys : asmhead.bin bootpack.hrb Makefile
	cat asmhead.bin bootpack.hrb > haribote.sys

haribote.img : ipl10.bin haribote.sys hello.hrb hello2.hrb a.hrb hello3.hrb bug1.hrb bug2.hrb bug3.hrb hello4.hrb hello5.hrb winhelo.hrb Makefile
	mformat -f 1440 -C -B ipl10.bin -i haribote.img ::
	mcopy -i haribote.img haribote.sys hello.hrb hello2.hrb a.hrb hello3.hrb bug1.hrb bug2.hrb bug3.hrb hello4.hrb hello5.hrb winhelo.hrb ::

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
	-$(DEL) *.map
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
	-$(DEL) *.hrb
