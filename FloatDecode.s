

.title	"Float Decode Program"



.data
courseStr:		.string	"Talal El Zeini\tCIST 039\n"
explanationStr:	.string	"This program will input and decode an IEEE-754 Floating Point Numbers.\nIt will square the number and decode it. Next, if possible, it will take\nthe square root of the number and decode it. This will repeat until the \nuser enters Zero."
inputPrompt:	.string	"\nEnter the single precision floating point value (0 to exit): "
initVal:		.string "The initial value is:\t  "
squaredVal:		.string	"\nThe value squared is:\t  "
rootVal:		.string	"\nThe root of the value is: "
.balign 4
floatInp:		.skip 4

floatVal:		.string "%f"
intVal:			.string "%d"
exponentStr:	.string " E%d"			

.text
.global	main
.func main
// main starts here

main:
	STMDB		SP!, {R4, LR}
	LDR			R0, =courseStr
	BL			puts
	LDR			R0, =explanationStr
	BL			puts
	
myLoop:
	LDR			R0, =inputPrompt
	BL			printf

	LDR			R0, =floatVal
    LDR		    R1, =floatInp
	BL			scanf

	LDR			R0, =floatInp
	LDR			R4, [R0]
	CMP 		R4, #0
	BEQ			Exit

	MOV			R0, #'\n'
	BL			putchar

// initial 
	LDR			R0, =initVal
	BL			printf

	MOV			R0, R4
	BL			floatDecode

// squared
	LDR			R0, =squaredVal
	BL			printf
	VMOV		S1, R4
	VMUL.F32	S0, S1,S1
	VMOV		R0, S0
	BL			floatDecode
// root
	MOVS		R4,R4
	BMI			branchToLoop
	LDR			R0, =rootVal
	BL 			printf
	VSQRT.F32	S0,S1
	VMOV		R0,S0
	BL			floatDecode
	
branchToLoop:
	B			myLoop
	
// exit loop

Exit:
	LDMIA		SP!, {R4,LR}
	MOV			R0, #0
	BX			LR

// main ends here


floatDecode:
	STMDB		SP!, {R4,LR}
	MOVS		R4, R0
	BMI			PRINT_A_MINUS
	MOV			R0, #'+'
	BL			putchar
	B			printFunc
	
PRINT_A_MINUS:
	MOV			R0, #'-'
	BL			putchar
	
printFunc:
	MOV			R0, #'1'
	BL			putchar
	MOV			R0, #'.'
	BL			putchar


	LSL			R0, R4, #9
	BL			PRINT_A_BINARY

	LDR			R0, =exponentStr
	MOV			R1, R4
	BL			printExponent

	LDMIA		SP!,{R4,LR}
	BX			LR
	

printExponent:
	STMDB		SP!, {LR}
	LSR			R1, R1, #23
	AND			R1, R1, #0b11111111
	SUB			R1, R1, #127
	BL			printf
	LDMIA		SP!, {LR}
	BX			LR

PRINT_A_BINARY:
		
	STMDB		SP!, {R4, R5, LR}
	MOV			R5, R0
	MOV			R4, #23

binLoop:
		
	MOV			R0, #'0'
	LSLS		R5, R5, #1
	ADC			R0, R0, #0
	BL			putchar
	SUBS		R4, R4, #1
	BNE			binLoop
	LDMIA		SP!, {R4, R5, LR}
	BX			LR

