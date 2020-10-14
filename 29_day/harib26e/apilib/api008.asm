[BITS 32]

		GLOBAL	api_initmalloc

SECTION .text

api_initmalloc:	; void api_initmalloc(void);
		PUSH	EBX
		MOV		EDX,8
		MOV		EBX,[CS:0x0020]		; malloc�̈�̔Ԓn
		MOV		EAX,EBX
		ADD		EAX,32*1024			; 32KB�𑫂�
		MOV		ECX,[CS:0x0000]		; �f�[�^�Z�O�����g�̑傫��
		SUB		ECX,EAX
		INT		0x40
		POP		EBX
		RET
