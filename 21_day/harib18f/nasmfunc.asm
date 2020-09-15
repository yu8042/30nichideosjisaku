; nasmfunc
; TAB=4	

[BITS 32]						; 32ビットモード用の機械語を作らせる

section .text
	GLOBAL	io_hlt, io_cli, io_sti, io_stihlt
	GLOBAL  io_in8, io_in16, io_in32
	GLOBAL  io_out8, io_out16, io_out32
	GLOBAL  io_load_eflags, io_store_eflags
	GLOBAL  load_gdtr, load_idtr
	GLOBAL	load_cr0, store_cr0
	GLOBAL	load_tr
	GLOBAL	asm_inthandler20, asm_inthandler21
	GLOBAL	asm_inthandler27, asm_inthandler2c
	GLOBAL	asm_inthandler0d
	GLOBAL	memtest_sub
	GLOBAL	farjmp, farcall
	GLOBAL	asm_hrb_api, start_app
	EXTERN	inthandler20, inthandler21
	EXTERN	inthandler27, inthandler2c
	EXTERN	inthandler0d
	EXTERN	hrb_api

io_hlt:	; void io_hlt(void);
	HLT
	RET

io_cli: ; void io_cli(void);
	CLI
	RET

io_sti:		;void io_sti(void)
	STI
	RET

io_stihlt:			; void io_stihlt(void)
	STI
	HLT
	RET

io_in8:				; int io_in8(int port); おそらく８は８bitの８
	MOV	EDX,[ESP+4]	; port
	MOV	EAX,0
	IN	AL,DX
	RET
	
io_in16:			; int io_in16(int port); おそらく１６は１６bitの16
	MOV	EDX,[ESP+4]	; port
	MOV	EAX,0
	IN	AX,DX
	RET

io_in32:			; int io_in32(int port);
	MOV	EDX,[ESP+4]	; port
	IN	EAX,DX
	RET

io_out8:			; void io_out8(int port, int data);
	MOV	EDX,[ESP+4]	; port
	MOV	AL,[ESP+8]	; data
	OUT	DX,AL
	RET

io_out16:			; void io_out16(int port, int data);
	MOV	EDX,[ESP+4]	; port
	MOV	EAX,[ESP+8]	; data
	OUT	DX,AX
	RET

io_out32:			; void io_out32(int port, int data);
	MOV	EDX,[ESP+4]	; port
	MOV	EAX,[ESP+8]	; data
	OUT	DX,EAX
	RET

io_load_eflags:			; int io_load_eflags(void);
	PUSHFD			; PUSH EFLAGS という意味
	POP	EAX
	RET

io_store_eflags:		; void io_store_eflags(int eflags);
	MOV	EAX,[ESP+4]
	PUSH	EAX
	POPFD			; POP EFLAGS という意味
	RET

load_gdtr:			; void load_gdtr(int limit, int addr);
	MOV	AX,[ESP+4]	; limit
	MOV	[ESP+6],AX
	LGDT	[ESP+6]
	RET

load_idtr:			; void load_idtr(int limit, int addr);
	MOV	AX,[ESP+4]	; limit
	MOV	[ESP+6],AX
	LIDT	[ESP+6]
	RET

load_cr0:			; int load_cr0(void);
	MOV	EAX,CR0
	RET

store_cr0:			; void store_cr0(int cr0;
	MOV	EAX,[ESP+4]
	MOV	CR0,EAX
	RET

load_tr:		; void load_tr(int tr);
	LTR	[ESP+4]	; tr
	RET

asm_inthandler20:
		PUSH	ES
		PUSH	DS
		PUSHAD
		MOV		AX,SS
		CMP		AX,1*8
		JNE		.from_app
;	OSÇ™ìÆÇ¢ÇƒÇ¢ÇÈÇ∆Ç´Ç…äÑÇËçûÇ‹ÇÍÇΩÇÃÇ≈ÇŸÇ⁄ç°Ç‹Ç≈Ç«Ç®ÇË
		MOV		EAX,ESP
		PUSH	SS				; äÑÇËçûÇ‹ÇÍÇΩÇ∆Ç´ÇÃSSÇï€ë∂
		PUSH	EAX				; äÑÇËçûÇ‹ÇÍÇΩÇ∆Ç´ÇÃESPÇï€ë∂
		MOV		AX,SS
		MOV		DS,AX
		MOV		ES,AX
		CALL	inthandler20
		ADD		ESP,8
		POPAD
		POP		DS
		POP		ES
		IRETD
.from_app:
;	ÉAÉvÉäÇ™ìÆÇ¢ÇƒÇ¢ÇÈÇ∆Ç´Ç…äÑÇËçûÇ‹ÇÍÇΩ
		MOV		EAX,1*8
		MOV		DS,AX			; Ç∆ÇËÇ†Ç¶Ç∏DSÇæÇØOSópÇ…Ç∑ÇÈ
		MOV		ECX,[0xfe4]		; OSÇÃESP
		ADD		ECX,-8
		MOV		[ECX+4],SS		; äÑÇËçûÇ‹ÇÍÇΩÇ∆Ç´ÇÃSSÇï€ë∂
		MOV		[ECX  ],ESP		; äÑÇËçûÇ‹ÇÍÇΩÇ∆Ç´ÇÃESPÇï€ë∂
		MOV		SS,AX
		MOV		ES,AX
		MOV		ESP,ECX
		CALL	inthandler20
		POP		ECX
		POP		EAX
		MOV		SS,AX			; SSÇÉAÉvÉäópÇ…ñﬂÇ∑
		MOV		ESP,ECX			; ESPÇ‡ÉAÉvÉäópÇ…ñﬂÇ∑
		POPAD
		POP		DS
		POP		ES
		IRETD

asm_inthandler21:
		PUSH	ES
		PUSH	DS
		PUSHAD
		MOV		AX,SS
		CMP		AX,1*8
		JNE		.from_app
;	OSÇ™ìÆÇ¢ÇƒÇ¢ÇÈÇ∆Ç´Ç…äÑÇËçûÇ‹ÇÍÇΩÇÃÇ≈ÇŸÇ⁄ç°Ç‹Ç≈Ç«Ç®ÇË
		MOV		EAX,ESP
		PUSH	SS				; äÑÇËçûÇ‹ÇÍÇΩÇ∆Ç´ÇÃSSÇï€ë∂
		PUSH	EAX				; äÑÇËçûÇ‹ÇÍÇΩÇ∆Ç´ÇÃESPÇï€ë∂
		MOV		AX,SS
		MOV		DS,AX
		MOV		ES,AX
		CALL	inthandler21
		ADD		ESP,8
		POPAD
		POP		DS
		POP		ES
		IRETD
.from_app:
;	ÉAÉvÉäÇ™ìÆÇ¢ÇƒÇ¢ÇÈÇ∆Ç´Ç…äÑÇËçûÇ‹ÇÍÇΩ
		MOV		EAX,1*8
		MOV		DS,AX			; Ç∆ÇËÇ†Ç¶Ç∏DSÇæÇØOSópÇ…Ç∑ÇÈ
		MOV		ECX,[0xfe4]		; OSÇÃESP
		ADD		ECX,-8
		MOV		[ECX+4],SS		; äÑÇËçûÇ‹ÇÍÇΩÇ∆Ç´ÇÃSSÇï€ë∂
		MOV		[ECX  ],ESP		; äÑÇËçûÇ‹ÇÍÇΩÇ∆Ç´ÇÃESPÇï€ë∂
		MOV		SS,AX
		MOV		ES,AX
		MOV		ESP,ECX
		CALL	inthandler21
		POP		ECX
		POP		EAX
		MOV		SS,AX			; SSÇÉAÉvÉäópÇ…ñﬂÇ∑
		MOV		ESP,ECX			; ESPÇ‡ÉAÉvÉäópÇ…ñﬂÇ∑
		POPAD
		POP		DS
		POP		ES
		IRETD

asm_inthandler27:
		PUSH	ES
		PUSH	DS
		PUSHAD
		MOV		AX,SS
		CMP		AX,1*8
		JNE		.from_app
;	OSÇ™ìÆÇ¢ÇƒÇ¢ÇÈÇ∆Ç´Ç…äÑÇËçûÇ‹ÇÍÇΩÇÃÇ≈ÇŸÇ⁄ç°Ç‹Ç≈Ç«Ç®ÇË
		MOV		EAX,ESP
		PUSH	SS				; äÑÇËçûÇ‹ÇÍÇΩÇ∆Ç´ÇÃSSÇï€ë∂
		PUSH	EAX				; äÑÇËçûÇ‹ÇÍÇΩÇ∆Ç´ÇÃESPÇï€ë∂
		MOV		AX,SS
		MOV		DS,AX
		MOV		ES,AX
		CALL	inthandler27
		ADD		ESP,8
		POPAD
		POP		DS
		POP		ES
		IRETD
.from_app:
;	ÉAÉvÉäÇ™ìÆÇ¢ÇƒÇ¢ÇÈÇ∆Ç´Ç…äÑÇËçûÇ‹ÇÍÇΩ
		MOV		EAX,1*8
		MOV		DS,AX			; Ç∆ÇËÇ†Ç¶Ç∏DSÇæÇØOSópÇ…Ç∑ÇÈ
		MOV		ECX,[0xfe4]		; OSÇÃESP
		ADD		ECX,-8
		MOV		[ECX+4],SS		; äÑÇËçûÇ‹ÇÍÇΩÇ∆Ç´ÇÃSSÇï€ë∂
		MOV		[ECX  ],ESP		; äÑÇËçûÇ‹ÇÍÇΩÇ∆Ç´ÇÃESPÇï€ë∂
		MOV		SS,AX
		MOV		ES,AX
		MOV		ESP,ECX
		CALL	inthandler27
		POP		ECX
		POP		EAX
		MOV		SS,AX			; SSÇÉAÉvÉäópÇ…ñﬂÇ∑
		MOV		ESP,ECX			; ESPÇ‡ÉAÉvÉäópÇ…ñﬂÇ∑
		POPAD
		POP		DS
		POP		ES
		IRETD

asm_inthandler2c:
		PUSH	ES
		PUSH	DS
		PUSHAD
		MOV		AX,SS
		CMP		AX,1*8
		JNE		.from_app
;	OSÇ™ìÆÇ¢ÇƒÇ¢ÇÈÇ∆Ç´Ç…äÑÇËçûÇ‹ÇÍÇΩÇÃÇ≈ÇŸÇ⁄ç°Ç‹Ç≈Ç«Ç®ÇË
		MOV		EAX,ESP
		PUSH	SS				; äÑÇËçûÇ‹ÇÍÇΩÇ∆Ç´ÇÃSSÇï€ë∂
		PUSH	EAX				; äÑÇËçûÇ‹ÇÍÇΩÇ∆Ç´ÇÃESPÇï€ë∂
		MOV		AX,SS
		MOV		DS,AX
		MOV		ES,AX
		CALL	inthandler2c
		ADD		ESP,8
		POPAD
		POP		DS
		POP		ES
		IRETD
.from_app:
;	ÉAÉvÉäÇ™ìÆÇ¢ÇƒÇ¢ÇÈÇ∆Ç´Ç…äÑÇËçûÇ‹ÇÍÇΩ
		MOV		EAX,1*8
		MOV		DS,AX			; Ç∆ÇËÇ†Ç¶Ç∏DSÇæÇØOSópÇ…Ç∑ÇÈ
		MOV		ECX,[0xfe4]		; OSÇÃESP
		ADD		ECX,-8
		MOV		[ECX+4],SS		; äÑÇËçûÇ‹ÇÍÇΩÇ∆Ç´ÇÃSSÇï€ë∂
		MOV		[ECX  ],ESP		; äÑÇËçûÇ‹ÇÍÇΩÇ∆Ç´ÇÃESPÇï€ë∂
		MOV		SS,AX
		MOV		ES,AX
		MOV		ESP,ECX
		CALL	inthandler2c
		POP		ECX
		POP		EAX
		MOV		SS,AX			; SSÇÉAÉvÉäópÇ…ñﬂÇ∑
		MOV		ESP,ECX			; ESPÇ‡ÉAÉvÉäópÇ…ñﬂÇ∑
		POPAD
		POP		DS
		POP		ES
		IRETD

asm_inthandler0d:
		STI
		PUSH	ES
		PUSH	DS
		PUSHAD
		MOV		AX,SS
		CMP		AX,1*8
		JNE		.from_app
;	OSが動いているときに割り込まれたのでほぼ今までどおり
		MOV		EAX,ESP
		PUSH	SS				; 割り込まれたときのSSを保存
		PUSH	EAX				; 割り込まれたときのESPを保存
		MOV		AX,SS
		MOV		DS,AX
		MOV		ES,AX
		CALL	inthandler0d
		ADD		ESP,8
		POPAD
		POP		DS
		POP		ES
		ADD		ESP,4			; INT 0x0d では、これが必要
		IRETD
.from_app:
;	アプリが動いているときに割り込まれた
		CLI
		MOV		EAX,1*8
		MOV		DS,AX			; とりあえずDSだけOS用にする
		MOV		ECX,[0xfe4]		; OSのESP
		ADD		ECX,-8
		MOV		[ECX+4],SS		; 割り込まれたときのSSを保存
		MOV		[ECX  ],ESP		; 割り込まれたときのESPを保存
		MOV		SS,AX
		MOV		ES,AX
		MOV		ESP,ECX
		STI
		CALL	inthandler0d
		CLI
		CMP		EAX,0
		JNE		.kill
		POP		ECX
		POP		EAX
		MOV		SS,AX			; SSをアプリ用に戻す
		MOV		ESP,ECX			; ESPもアプリ用に戻す
		POPAD
		POP		DS
		POP		ES
		ADD		ESP,4			; INT 0x0d では、これが必要
		IRETD
.kill:
;	アプリを異常終了させることにした
		MOV		EAX,1*8			; OS用のDS/SS
		MOV		ES,AX
		MOV		SS,AX
		MOV		DS,AX
		MOV		FS,AX
		MOV		GS,AX
		MOV		ESP,[0xfe4]		; start_appのときのESPに無理やり戻す
		STI			; 切り替え完了なので割り込み可能に戻す
		POPAD	; 保存しておいたレジスタを回復
		RET

memtest_sub:	; unsigned int memtest_sub(unsigned int start, unsigned int end)
		PUSH	EDI						;（EBX, ESI, EDI も使いたいので）
		PUSH	ESI
		PUSH	EBX
		MOV		ESI,0xaa55aa55			; pat0 = 0xaa55aa55;
		MOV		EDI,0x55aa55aa			; pat1 = 0x55aa55aa;
		MOV		EAX,[ESP+12+4]			; i = start;
mts_loop:
		MOV		EBX,EAX
		ADD		EBX,0xffc				; p = i + 0xffc;
		MOV		EDX,[EBX]				; old = *p;
		MOV		[EBX],ESI				; *p = pat0;
		XOR		DWORD [EBX],0xffffffff	; *p ^= 0xffffffff;
		CMP		EDI,[EBX]				; if (*p != pat1) goto fin;
		JNE		mts_fin
		XOR		DWORD [EBX],0xffffffff	; *p ^= 0xffffffff;
		CMP		ESI,[EBX]				; if (*p != pat0) goto fin;
		JNE		mts_fin
		MOV		[EBX],EDX				; *p = old;
		ADD		EAX,0x1000				; i += 0x1000;
		CMP		EAX,[ESP+12+8]			; if (i <= end) goto mts_loop;
		JBE		mts_loop
		POP		EBX
		POP		ESI
		POP		EDI
		RET
mts_fin:
		MOV		[EBX],EDX				; *p = old;
		POP		EBX
		POP		ESI
		POP		EDI
		RET

farjmp:		; void farjmp(int eip, int cs);
		JMP		FAR	[ESP+4]				; eip, cs
		RET

farcall:		; void farcall(int eip, int cs);
		CALL	FAR	[ESP+4]				; eip, cs
		RET

asm_hrb_api:
		; ìsçáÇÃÇ¢Ç¢Ç±Ç∆Ç…ç≈èâÇ©ÇÁäÑÇËçûÇ›ã÷é~Ç…Ç»Ç¡ÇƒÇ¢ÇÈ
		PUSH	DS
		PUSH	ES
		PUSHAD		; ï€ë∂ÇÃÇΩÇﬂÇÃPUSH
		MOV		EAX,1*8
		MOV		DS,AX			; Ç∆ÇËÇ†Ç¶Ç∏DSÇæÇØOSópÇ…Ç∑ÇÈ
		MOV		ECX,[0xfe4]		; OSÇÃESP
		ADD		ECX,-40
		MOV		[ECX+32],ESP	; ÉAÉvÉäÇÃESPÇï€ë∂
		MOV		[ECX+36],SS		; ÉAÉvÉäÇÃSSÇï€ë∂

; PUSHADÇµÇΩílÇÉVÉXÉeÉÄÇÃÉXÉ^ÉbÉNÇ…ÉRÉsÅ[Ç∑ÇÈ
		MOV		EDX,[ESP   ]
		MOV		EBX,[ESP+ 4]
		MOV		[ECX   ],EDX	; hrb_apiÇ…ìnÇ∑ÇΩÇﬂÉRÉsÅ[
		MOV		[ECX+ 4],EBX	; hrb_apiÇ…ìnÇ∑ÇΩÇﬂÉRÉsÅ[
		MOV		EDX,[ESP+ 8]
		MOV		EBX,[ESP+12]
		MOV		[ECX+ 8],EDX	; hrb_apiÇ…ìnÇ∑ÇΩÇﬂÉRÉsÅ[
		MOV		[ECX+12],EBX	; hrb_apiÇ…ìnÇ∑ÇΩÇﬂÉRÉsÅ[
		MOV		EDX,[ESP+16]
		MOV		EBX,[ESP+20]
		MOV		[ECX+16],EDX	; hrb_apiÇ…ìnÇ∑ÇΩÇﬂÉRÉsÅ[
		MOV		[ECX+20],EBX	; hrb_apiÇ…ìnÇ∑ÇΩÇﬂÉRÉsÅ[
		MOV		EDX,[ESP+24]
		MOV		EBX,[ESP+28]
		MOV		[ECX+24],EDX	; hrb_apiÇ…ìnÇ∑ÇΩÇﬂÉRÉsÅ[
		MOV		[ECX+28],EBX	; hrb_apiÇ…ìnÇ∑ÇΩÇﬂÉRÉsÅ[

		MOV		ES,AX			; écÇËÇÃÉZÉOÉÅÉìÉgÉåÉWÉXÉ^Ç‡OSópÇ…Ç∑ÇÈ
		MOV		SS,AX
		MOV		ESP,ECX
		STI			; Ç‚Ç¡Ç∆äÑÇËçûÇ›ãñâ¬

		CALL	hrb_api

		MOV		ECX,[ESP+32]	; ÉAÉvÉäÇÃESPÇévÇ¢èoÇ∑
		MOV		EAX,[ESP+36]	; ÉAÉvÉäÇÃSSÇévÇ¢èoÇ∑
		CLI
		MOV		SS,AX
		MOV		ESP,ECX
		POPAD
		POP		ES
		POP		DS
		IRETD		; Ç±ÇÃñΩóﬂÇ™é©ìÆÇ≈STIÇµÇƒÇ≠ÇÍÇÈ

start_app:		; void start_app(int eip, int cs, int esp, int ds);
		PUSHAD		; 32ÉrÉbÉgÉåÉWÉXÉ^ÇëSïîï€ë∂ÇµÇƒÇ®Ç≠
		MOV		EAX,[ESP+36]	; ÉAÉvÉäópÇÃEIP
		MOV		ECX,[ESP+40]	; ÉAÉvÉäópÇÃCS
		MOV		EDX,[ESP+44]	; ÉAÉvÉäópÇÃESP
		MOV		EBX,[ESP+48]	; ÉAÉvÉäópÇÃDS/SS
		MOV		[0xfe4],ESP		; OSópÇÃESP
		CLI			; êÿÇËë÷Ç¶íÜÇ…äÑÇËçûÇ›Ç™ãNÇ´ÇƒÇŸÇµÇ≠Ç»Ç¢ÇÃÇ≈ã÷é~
		MOV		ES,BX
		MOV		SS,BX
		MOV		DS,BX
		MOV		FS,BX
		MOV		GS,BX
		MOV		ESP,EDX
		STI			; êÿÇËë÷Ç¶äÆóπÇ»ÇÃÇ≈äÑÇËçûÇ›â¬î\Ç…ñﬂÇ∑
		PUSH	ECX				; far-CALLÇÃÇΩÇﬂÇ…PUSHÅicsÅj
		PUSH	EAX				; far-CALLÇÃÇΩÇﬂÇ…PUSHÅieipÅj
		CALL	FAR [ESP]		; ÉAÉvÉäÇåƒÇ—èoÇ∑
;	ÉAÉvÉäÇ™èIóπÇ∑ÇÈÇ∆Ç±Ç±Ç…ãAÇ¡ÇƒÇ≠ÇÈ

		MOV		EAX,1*8			; OSópÇÃDS/SS
		CLI			; Ç‹ÇΩêÿÇËë÷Ç¶ÇÈÇÃÇ≈äÑÇËçûÇ›ã÷é~
		MOV		ES,AX
		MOV		SS,AX
		MOV		DS,AX
		MOV		FS,AX
		MOV		GS,AX
		MOV		ESP,[0xfe4]
		STI			; êÿÇËë÷Ç¶äÆóπÇ»ÇÃÇ≈äÑÇËçûÇ›â¬î\Ç…ñﬂÇ∑
		POPAD	; ï€ë∂ÇµÇƒÇ®Ç¢ÇΩÉåÉWÉXÉ^ÇâÒïú
		RET
