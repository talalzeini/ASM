
// TALAL EL ZEINI CIST 0039
// C-Strings and Byte Operations Program

.data

courseString: 			.string " TALAL EL ZEINI\t\tCIST 039\t\n"
stringInput: 			.string "\nEnter a string: "

inputBuffer: 			.SKIP 81

charsCounter: 			.string "There are %d characters in: \"%s\".\n"
vowelsCounter: 			.string "There are %d vowels in: \"%s\".\n"
upperFirst: 			.string "Upper case first characters: \"%s\".\n"
messageShout: 			.string "Shouting: \"%s\".\n"
spaceRemoverString: 	.string "Extra spaces removed: \"%s\".\n"

.text
.global main


// TALAL EL ZEINI CIST 0039

main:

	STMDB 		SP!, {LR}
	LDR 		R0, =courseString
	BL 			printf
	LDR 		R0, =stringInput
	BL 			printf
	
	
	
// user input entered and read

	LDR 		R0, =inputBuffer
	MOV 		R1, #81
	BL 			getLine
	
	
	
// printing number of characters  

	LDR 		R0, =inputBuffer
	BL 			countCharacter
	MOV 		R1, R0  
	LDR 		R2, =inputBuffer
	LDR 		R0, =charsCounter
	BL 			printf
	
	
	
// printing number of vowels

	LDR 		R0, =inputBuffer
	BL 			countVowels
	MOV 		R1, R0
	LDR 		R2, =inputBuffer
	LDR 		R0, =vowelsCounter
	BL			printf
	
	
	
// printing upper case 	

	LDR 		R0, =inputBuffer
	BL 			functionUpper
	LDR 		R1, =inputBuffer
	LDR 		R0, =upperFirst
	BL 			printf



// priting the shouting message 

	LDR 		R0, =inputBuffer
	BL 			shoutingFunction
	LDR 		R1, =inputBuffer
	LDR 		R0, =messageShout
	BL 			printf



// priting the message without extra spaces

	LDR 		R0, =inputBuffer
	BL 			removeSpaces
	LDR 		R1, =inputBuffer
	LDR 		R0, =spaceRemoverString
	BL 			printf
	LDMIA		SP!, {LR}
	MOV 		R0, #0
	BX			LR	











// Input:
// 	R0 is the base address of the start of the user string inputBuffer
//	and R1 is the length of the user string
// Output:
//	None

// getline function 

getLine:
      STMDB 	SP!, {R4, R5, LR}
      MOV 		R4, R0
      MOV 		R5, R1
	
secondGetline:
      BL 		getchar
      CMP 		R0, #'\n'
      BEQ 		Exit
      STRB 		R0, [R4]
      ADD 		R4, R4, #1
      CMP 		R5, #1
      SUB 		R5, R5, #1
      BGT 		secondGetline
	
Exit:
      MOV 		R0, #0
      STRB 		R0, [R4]
      LDMIA 	SP!, {R4, R5, LR}
      BX 		LR








// Input:
// 	R0 is the base address of the start of the user string inputBuffer
// Output:
//	R0 is the number of characters in the user string

// count characters function

countCharacter:
      MOV 		R2, #00
      MOV 		R1, R0
      
charCounterLoop:
      LDRB   	R0, [R1, R2]
      CMP    	R0, #00
      BEQ    	countingCharsDone
      
      ADD  		R2, R2, #01
      B    		charCounterLoop
       
countingCharsDone:
      MOV     	R0, R2
      BX 		LR












// Input:
// 	R0 is the base address of inputBuffer
// Output:
//	R0 is the numbers of vowels in the user string input


// counting vowels function

countVowels:
	STMDB 		SP!, {LR}
	MOV 		R1, #0        
	MOV 		R2, #00  
	MOV 		R3, R0    
	 
       
nextCountingVowels:
	LDRB   		R0, [R3, R2]
	BL 			toUpper    
	CMP    		R0, #00
	BEQ    		countingVowelsDone    
	ADD 		R2, R2, #1
	CMP 		R0, #'A'
	BEQ   		Vowel
	CMP 		R0, #'E'
	BEQ  		Vowel
	CMP 		R0, #'I'
	BEQ  		Vowel
	CMP 		R0, #'O'
	BEQ   		Vowel
	CMP 		R0, #'U'
	BEQ   		Vowel
	B		nextCountingVowels
Vowel:
	ADD 		R1, R1, #1
	B    		nextCountingVowels
         
countingVowelsDone:
       MOV     	R0, R1
       LDMIA 	SP!, {LR}
       BX 		LR
     















// Input:
// 	R0 is the base address of inputBuffer
// Output:
//	None

// first upper case function

functionUpper:
	STMDB 		SP!, { LR}
	MOV 		R1, R0    
	MOV 		R2, #00
	MOV 		R3, #' '
	LDRB 		R0, [R1]
	BL 			toUpper
	STRB 		R0, [R1] 
	
upperLoop:
	LDRB 		R0, [R1, R2]
	CMP 		R0, #00
	BEQ 		upperDone
	ADD 		R2, R2, #1
	CMP 		R0, #' '
	BEQ  		UpperCase
	B 			upperLoop
		
UpperCase:
	LDRB 		R0, [R1, R2]
	BL 			toUpper
	STRB 		R0, [R1, R2] 
	B 			upperLoop
		
upperDone:
	LDMIA 		SP!, {LR}
	BX 			LR

















// Input:
// 	R0 is the base address of inputBuffer
// Output:
//	None

//  shouting function

shoutingFunction:
	STMDB 		SP!, { LR}
	MOV 		R1, R0    
	MOV 		R2, #00
		
shoutingLoop:
	LDRB 		R0, [R1, R2]
	CMP 		R0, #00
	BEQ 		shoutingDone
	BL 			toUpper
	STRB 		R0, [R1, R2] 
	ADD 		R2, R2, #1
	B 			shoutingLoop
		
shoutingDone:
	LDMIA 		SP!, {LR}
	BX 			LR















// Input:
// 	R0 is the base address of inputBuffer
// Output:
//	None

// remove space function

removeSpaces:
	STMDB 		SP!, { LR}
	LDR 		R1, =inputBuffer
	LDR 		R2, =inputBuffer

spaceRemoverLoop:
	LDRB 		R0, [R1]
	CMP 		R0, #0
	BEQ 		RemovingDone	
	CMP 		R0, #' '
	BNE 		SPACE
	LDRB 		R3, [R1, #1]
	CMP 		R3, #' '
	BNE 		SPACE
	ADD 		R1, R1, #1
	B 			spaceRemoverLoop
	
SPACE:
	LDRB 		R3, [R1]
	STRB 		R3, [R2]
	ADD 		R1, R1, #1
	ADD 		R2, R2, #1
	B 			spaceRemoverLoop
		
RemovingDone:
	MOV 		R3, #0
	STRB 		R3, [R2]
	LDMIA 		SP!, {LR}
	BX 			LR






// Input:
// 	R0 is the base address of inputBuffer
// Output:
//	R0 is the upper case character


// to upper function

toUpper:
       CMP			R0, #'a'
       BXLO 		LR
       CMP 		R0, #'z'
       BXHI 		LR
       AND 		R0, R0, #0b01011111
       BX 			LR
	




// TALAL EL ZEINI CIST 0039
