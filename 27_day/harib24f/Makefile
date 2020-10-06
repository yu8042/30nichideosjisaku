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

hello5.bin : hello5.asm Makefile
	$(NASM) -f elf32 hello5.asm -o hello5.bin

nasmfunc.obj : nasmfunc.asm Makefile
	nasm -g -f elf nasmfunc.asm -o nasmfunc.obj

convertHankakuTxt : convertHankakuTxt.c
	gcc $< -o $@

hankaku.c : hankaku.txt convertHankakuTxt
	./convertHankakuTxt

%.bin : %.asm
	$(NASM) -f elf32 $*.asm -o $@

apilib.a : $(OBJS_API)
	i386-elf-ar r apilib.a $(OBJS_API)

%.obj : %.c
	i386-elf-gcc -c -march=i486 -m32 -nostdlib $*.c -o $@

a.hrb : apilib.a a.obj api.ld Makefile
	i386-elf-ld -o a.hrb -T api.ld a.obj apilib.a

hello3.hrb : apilib.a hello3.obj api.ld Makefile
	i386-elf-ld -o hello3.hrb -T api.ld hello3.obj apilib.a

hello4.hrb : apilib.a hello4.obj api.ld Makefile
	i386-elf-ld -Map hello4.map -o hello4.hrb -T api.ld hello4.obj apilib.a

hello5.hrb : apilib.a hello5.bin api.ld Makefile
	i386-elf-ld -Map hello5.map -o hello5.hrb -T api.ld hello5.bin apilib.a

winhelo.hrb : apilib.a winhelo.obj api.ld Makefile
	i386-elf-ld -Map winhelo.map -o winhelo.hrb -T api.ld winhelo.obj apilib.a

winhelo2.hrb : apilib.a winhelo2.obj api.ld Makefile
	i386-elf-ld -Map winhelo2.map -o winhelo2.hrb -T api.ld winhelo2.obj apilib.a

winhelo3.hrb : apilib.a winhelo3.obj api.ld Makefile
	i386-elf-ld -Map winhelo3.map -o winhelo3.hrb -T api.ld winhelo3.obj apilib.a

star1.hrb : apilib.a star1.obj api.ld Makefile
	i386-elf-ld -Map star1.map -o star1.hrb -T api.ld star1.obj apilib.a

stars.hrb : apilib.a stars.obj api.ld Makefile
	i386-elf-ld -Map stars.map -o stars.hrb -T api.ld stars.obj apilib.a

stars2.hrb : apilib.a stars2.obj api.ld Makefile
	i386-elf-ld -Map stars2.map -o stars2.hrb -T api.ld stars2.obj apilib.a

lines.hrb : apilib.a lines.obj api.ld Makefile
	i386-elf-ld -Map lines.map -o lines.hrb -T api.ld lines.obj apilib.a

walk.hrb : apilib.a walk.obj api.ld Makefile
	i386-elf-ld -Map walk.map -o walk.hrb -T api.ld walk.obj apilib.a

noodle.hrb : apilib.a mysprintf.obj noodle.obj api.ld Makefile
	i386-elf-ld -Map noodle.map -o noodle.hrb -T api.ld mysprintf.obj noodle.obj apilib.a

beepdown.hrb : apilib.a beepdown.obj api.ld Makefile
	i386-elf-ld -Map beepdown.map -o beepdown.hrb -T api.ld beepdown.obj apilib.a

color.hrb : apilib.a color.obj api.ld Makefile
	i386-elf-ld -Map color.map -o color.hrb -T api.ld color.obj apilib.a

color2.hrb : apilib.a color2.obj api.ld Makefile
	i386-elf-ld -Map color2.map -o color2.hrb -T api.ld color2.obj apilib.a

bootpack.hrb : bootpack.c hankaku.obj graphic.obj dsctbl.obj nasmfunc.obj mysprintf.obj mystrcmp.obj int.obj fifo.obj mouse.obj keyboard.obj memory.obj sheet.obj timer.obj mtask.obj window.obj console.obj file.obj har.ld Makefile
	i386-elf-gcc -march=i486 -m32 -nostdlib -T har.ld -g nasmfunc.obj mysprintf.obj mystrcmp.obj int.obj fifo.obj graphic.obj dsctbl.obj hankaku.obj mouse.obj keyboard.obj memory.obj sheet.obj timer.obj mtask.obj window.obj console.obj file.obj bootpack.c -o bootpack.hrb

haribote.sys : asmhead.bin bootpack.hrb Makefile
	cat asmhead.bin bootpack.hrb > haribote.sys

haribote.img : ipl10.bin haribote.sys a.hrb hello3.hrb hello4.hrb hello5.hrb winhelo.hrb winhelo2.hrb winhelo3.hrb star1.hrb stars.hrb stars2.hrb lines.hrb walk.hrb noodle.hrb beepdown.hrb color.hrb color2.hrb Makefile
	mformat -f 1440 -C -B ipl10.bin -i haribote.img ::
	mcopy -i haribote.img haribote.sys a.hrb hello3.hrb hello4.hrb hello5.hrb winhelo.hrb winhelo2.hrb winhelo3.hrb star1.hrb stars.hrb stars2.hrb lines.hrb walk.hrb noodle.hrb beepdown.hrb color.hrb color2.hrb ::

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
	-$(DEL) apilib.a

src_only :
	$(MAKE) clean
	-$(DEL) haribote.img
	-$(DEL) *.hrb
