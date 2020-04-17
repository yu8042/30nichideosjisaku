; nasmfunc
; TAB=4	

section .text
	GLOBAL	io_hlt,write_mem8	

io_hlt:	; void io_hlt(void);
	HLT
	RET

write_mem8:	; void write_mem8(int addr, int data);
	MOV		ECX,[ESP+4]		; [ESP+4]‚Éaddr‚ª“ü‚Á‚Ä‚¢‚é‚Ì‚Å‚»‚ê‚ğECX‚É“Ç‚İ‚Ş
	MOV		AL,[ESP+8]		; [ESP+8]‚Édata‚ª“ü‚Á‚Ä‚¢‚é‚Ì‚Å‚»‚ê‚ğAL‚É“Ç‚İ‚Ş
	MOV		[ECX],AL
	RET
