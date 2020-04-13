; nasmfunc.asm
; TAB=4

section .text		; オブジェクトファイルではこれを書いてからプログラムを書く
	GLOBAL	io_hlt			; このプログラムに含まれる関数名


io_hlt:	; void io_hlt(void);
		HLT
		RET
