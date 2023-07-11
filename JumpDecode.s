.PSIZE 50, 100
.TITLE		"ARM Jump Decoding"
.SBTTL		"Data Section"	


.DATA
courseSTR:		.ASCIZ	"Talal El Zeini\t\t\tCIST 39\n"
pgmSTR:			.ASCIZ	"This program will Decode a subset of ARM instructions\n"
titleSTR:		.ASCIZ	"Address\t\tM Language\tInstruction"

printSTR:		.ASCIZ	"0x%08X\t%08X\t"
printBranchOff:	.STRING	"\t<%+d>"
printSTRing:	.STRING	"%s"
unknownIns:		.STRING "UNKNOWN INSTRUCTION"
/*
branchMnemonics:
				.STRING	"EQ "	// 0000
				.STRING	"NE "	// 0001
				.STRING	"CS "	// 0010
				.STRING	"CC "	// 0011
				.STRING	"MI "	// 0100
				.STRING	"PL "	// 0101
				.STRING	"VS "	// 0110
				.STRING	"VC " 	// 0111
				.STRING	"HI "	// 1000
				.STRING	"LS "	// 1001
				.STRING	"GE "	// 1010
				.STRING	"LT "	// 1011
				.STRING	"GT "	// 1100
				.STRING	"LE "	// 1101
				.STRING	"   "	// 1110		// Just a Branch B / BL
				.STRING	"xx "	// 1111		// Reserved, never use
*/		
branchMnemonics: .STRING	"EQ ", "NE ", "CS ", "CC ", "MI ", "PL ", "VS ", "VC ", "HI ", "LS ", "GE ", "LT ", "GT ", "LE ", "AL ", "xx "
			
							
.EJECT			// Form feed / New Page
.SBTTL		"The Code for the Program"
.TEXT
.GLOBAL	main

main:
	SUB		SP, SP, #20
	STR		R4, [SP, #0]
	STR		R5, [SP, #4]
	STR		R6, [SP, #8]
	STR		R7, [SP, #12]
	STR		LR, [SP, #16]

	LDR		R0, =courseSTR
	BL		puts
	LDR		R0, =pgmSTR
	BL		puts
	LDR		R0, =titleSTR
	BL		puts
	
	LDR		R5, =testCodeToDecode
	LDR		R7, =branchMnemonics
	MOV		R4, #0

LOOP:
	ADD		R1, R5, R4, lsl #2
	LDR 	R6, [R1]
	LDR		R0, =printSTR
	MOV		R2, R6
	BL		printf
	
	MOV 	R1, R6
	LSL 	R1, #4
	LSR 	R1, #29
	CMP 	R1, #0b101
	BEQ 	linkLoop
notBranchInstruction:
	LDR		R0, =unknownIns
	BL		printf
	B 		LoopNext

linkLoop:
	MOV		R0, #'B'
	BL		putchar
	
	MOV 	R1, R6
	LSLS 	R1, #8
	BCC 	ccLoop
link:
	MOV 	R0, #'L'
	BL 		putchar

ccLoop:
	MOV 	R2, R6
	LSR 	R2, #28
	LSL		R2, #2
	ADD		R1, R7, R2
	LDR		R0, =printSTRing
	BL		printf

offset:
	MOV 	R1, R6
	LSL		R1, #8
	ASR		R1, #8
	LDR		R0, =printBranchOff
	BL		printf

LoopNext:
	MOV		R0, #'\n'
	BL		putchar
	
	ADD		R4, R4, #1
	CMP		R4, #20
	BLT		LOOP

ProgramExit:
	LDR		R4, [SP, #0]
	LDR		R5, [SP, #4]
	LDR		R6, [SP, #8]
	LDR		R7, [SP, #12]
	LDR		LR, [SP, #16]
	ADD		SP, SP, #20
	
	MOV		R0, #0
	BX		LR
	
	
testCodeToDecode:
	BEQ		T2
	BLNE	testCodeToDecode
	BMI		T2
	MOV		R1, R2
	BLPL	T2
	BCS		T2
	BLHI	testCodeToDecode
	BLS		T2
	BLGT	T2
	BGE		T2
	.ASCII	"ABCD"
	BLCC	T2
	BVS		T2
	BLVC	T2
	BLE		T2
	B		T2
	BL		testCodeToDecode
T2:
	ANDS	R3, R5, R9, ASR	#7
	CMP		R5, R7
	CMP		R6, #25

	CMN		R11, R13
	ADD		R0,R7,R2
	ORR		R11,R12,R10
