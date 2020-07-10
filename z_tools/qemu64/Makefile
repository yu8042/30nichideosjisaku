QEMU		= qemu-system-x86_64
QEMU_ARGS	= -accel hvf -L . -m 32 -rtc base=localtime -vga std -drive file=fdimage0.bin,index=0,if=floppy,format=raw

default:
	$(QEMU) $(QEMU_ARGS)
