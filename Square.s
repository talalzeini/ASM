.data 
tempRet:	.word	0
saveLoc:	.word	0
str1: .asciz "Talal El Zeini CIST039\n"
str2: .asciz "Number\t\tSquares\n"
printStr: .asciz	"%d\t\t%d\n"

.text
.global main
.func main

main:
		mov R4, #0		    // initialized R4
		
		ldr R1, =tempRet	
		str	R4,[R1] 		// save R4
		
		ldr R1, =saveLoc	
		str LR, [R1]
		
		ldr	R0, =str1
		bl	puts	
		
		ldr	R0, =str2
		bl	puts	


	LOOP:	
		add R4, R4, #1
		mov R1, R4
		mul R2, R1, R1
		mov R2, R2
		ldr r0, =printStr
		bl printf
		
		CMP	R4, #99
		BNE	LOOP	
		
		ldr R1, =saveLoc
		ldr LR, [R1]
			
		mov R0, #0
		ldr	R1, =tempRet	// restore R4
		ldr R4, [R1]
		bx	LR
		.data 		

