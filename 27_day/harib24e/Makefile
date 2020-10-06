TOOLPATH = ../../z_tools/
INCPATH  = ../../z_tools/haribote/

MAKE     = make -r
NASM     = nasm
IMGTOL   = $(TOOLPATH)imgtol
COPY     = cp
DEL      = rm -f
OBJS_API = api001.bin api002.bin api003.bin api004.bin api005.bin api006.bin api007.bin api008.bin api009.bin api010.bin api011.bin api012.bin api013.bin api014.bin api015.bin api016.bin api017.bin api018.bin api019.bin api020.bin

# �f�t�H���g����

default :
	$(MAKE) img

# �t�@�C�������K��

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

crack7.bin : crack7.asm Makefile
	$(NASM) -f elf32 crack7.asm -o crack7.bin

nasmfunc.obj : nasmfunc.asm Makefile
	nasm -g -f elf nasmfunc.asm -o nasmfunc.obj

convertHankakuTxt : convertHankakuTxt.c
	gcc $< -o $@

hankaku.c : hankaku.txt convertHankakuTxt
	./convertHankakuTxt

%.bin : %.asm
	$(NASM) -f elf32 $*.asm -o $@

%.obj : %.c
	i386-elf-gcc -c -march=i486 -m32 -nostdlib $*.c -o $@

a.hrb : $(OBJS_API) a.obj api.ld Makefile
	i386-elf-ld -o a.hrb -T api.ld $(OBJS_API) a.obj

hello3.hrb : $(OBJS_API) hello3.obj api.ld Makefile
	i386-elf-ld -o hello3.hrb -T api.ld $(OBJS_API) hello3.obj

hello4.hrb : $(OBJS_API) hello4.obj api.ld Makefile
	i386-elf-ld -Map hello4.map -o hello4.hrb -T api.ld $(OBJS_API) hello4.obj

hello5.hrb : $(OBJS_API) hello5.bin api.ld Makefile
	i386-elf-ld -Map hello5.map -o hello5.hrb -T api.ld $(OBJS_API) hello5.bin

crack7.hrb : $(OBJS_API) crack7.bin api.ld Makefile
	i386-elf-ld -Map crack7.map -o crack7.hrb -T api.ld $(OBJS_API) crack7.bin

winhelo.hrb : $(OBJS_API) winhelo.obj api.ld Makefile
	i386-elf-ld -Map winhelo.map -o winhelo.hrb -T api.ld $(OBJS_API) winhelo.obj

winhelo2.hrb : $(OBJS_API) winhelo2.obj api.ld Makefile
	i386-elf-ld -Map winhelo2.map -o winhelo2.hrb -T api.ld $(OBJS_API) winhelo2.obj

winhelo3.hrb : $(OBJS_API) winhelo3.obj api.ld Makefile
	i386-elf-ld -Map winhelo3.map -o winhelo3.hrb -T api.ld $(OBJS_API) winhelo3.obj

star1.hrb : $(OBJS_API) star1.obj api.ld Makefile
	i386-elf-ld -Map star1.map -o star1.hrb -T api.ld $(OBJS_API) star1.obj

stars.hrb : $(OBJS_API) stars.obj api.ld Makefile
	i386-elf-ld -Map stars.map -o stars.hrb -T api.ld $(OBJS_API) stars.obj

stars2.hrb : $(OBJS_API) stars2.obj api.ld Makefile
	i386-elf-ld -Map stars2.map -o stars2.hrb -T api.ld $(OBJS_API) stars2.obj

lines.hrb : $(OBJS_API) lines.obj api.ld Makefile
	i386-elf-ld -Map lines.map -o lines.hrb -T api.ld $(OBJS_API) lines.obj

walk.hrb : $(OBJS_API) walk.obj api.ld Makefile
	i386-elf-ld -Map walk.map -o walk.hrb -T api.ld $(OBJS_API) walk.obj

noodle.hrb : $(OBJS_API) mysprintf.obj noodle.obj api.ld Makefile
	i386-elf-ld -Map noodle.map -o noodle.hrb -T api.ld $(OBJS_API) mysprintf.obj noodle.obj

beepdown.hrb : $(OBJS_API) beepdown.obj api.ld Makefile
	i386-elf-ld -Map beepdown.map -o beepdown.hrb -T api.ld $(OBJS_API) beepdown.obj

color.hrb : $(OBJS_API) color.obj api.ld Makefile
	i386-elf-ld -Map color.map -o color.hrb -T api.ld $(OBJS_API) color.obj

color2.hrb : $(OBJS_API) color2.obj api.ld Makefile
	i386-elf-ld -Map color2.map -o color2.hrb -T api.ld $(OBJS_API) color2.obj

bootpack.hrb : bootpack.c hankaku.obj graphic.obj dsctbl.obj nasmfunc.obj mysprintf.obj mystrcmp.obj int.obj fifo.obj mouse.obj keyboard.obj memory.obj sheet.obj timer.obj mtask.obj window.obj console.obj file.obj har.ld Makefile
	i386-elf-gcc -march=i486 -m32 -nostdlib -T har.ld -g nasmfunc.obj mysprintf.obj mystrcmp.obj int.obj fifo.obj graphic.obj dsctbl.obj hankaku.obj mouse.obj keyboard.obj memory.obj sheet.obj timer.obj mtask.obj window.obj console.obj file.obj bootpack.c -o bootpack.hrb

haribote.sys : asmhead.bin bootpack.hrb Makefile
	cat asmhead.bin bootpack.hrb > haribote.sys

haribote.img : ipl10.bin haribote.sys hello.hrb hello2.hrb a.hrb hello3.hrb hello4.hrb hello5.hrb winhelo.hrb winhelo2.hrb winhelo3.hrb star1.hrb stars.hrb stars2.hrb lines.hrb walk.hrb noodle.hrb beepdown.hrb color.hrb color2.hrb crack7.hrb Makefile
	mformat -f 1440 -C -B ipl10.bin -i haribote.img ::
	mcopy -i haribote.img haribote.sys hello.hrb hello2.hrb a.hrb hello3.hrb hello4.hrb hello5.hrb winhelo.hrb winhelo2.hrb winhelo3.hrb star1.hrb stars.hrb stars2.hrb lines.hrb walk.hrb noodle.hrb beepdown.hrb color.hrb color2.hrb crack7.hrb ::

# �R�}���h

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
