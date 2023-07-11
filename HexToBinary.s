.data
tempRet: .word 1
saveLoc: .word 0
saveAdd: .word 0
myTemp:  .word 0
hexTable: .word 0x12345678
		  .word 0xFEDCBA98
		  .word 0x01010101
		  .word 0x6dB6dB6d
		  .word 0xFFFFFFFF
		  .word 0x00000000
studentName: .asciz "Talal El Zeini\tCIST 039\n"
hexStr: .asciz "\nHex:\t%#010X\tBinary:\t"
emptyStr: .asciz ""

.text
.global main
.func main

main:
	SUB		SP, SP, #20
	STR		R7, [SP,#16]
	STR		R6,[SP,#12]
	STR		R5, [SP,#8]
	STR		R4, [SP, #4]
	STR		LR, [SP, #0]
	
	LDR R0, =studentName			
	BL puts
	
	MOV	R6,#0
	LDR R5, =hexTable

myLoop:		
	LDR R4, [R5,R6,LSL #2]
	MOV	R1,R4 	
	LDR R0, =hexStr
	BL printf	
	MOV	R7, #0
	B secondLoop

secondLoop:	
		
	LSLS R4, R4, #1			
	BCS PRINT_A_ONE			
	MOV R0, #'0'
	BL putchar
	B next

PRINT_A_ONE:

	MOV R0, #'1'
	BL putchar
	
next:
	
	ADD	R7, R7,#1
	CMP	R7, #32
	BNE	secondLoop
	ADD	R6,R6,#1
	CMP	R6,#6
	BNE	myLoop


	
	LDR		LR, [SP,#0]
	LDR		R4,[SP,#4]
	LDR		R5, [SP,#8]
	LDR		R6, [SP, #12]
	LDR		R7, [SP, #16]
	ADD		SP, SP, #20
	
	
	MOV R0, #0
	BX LR

