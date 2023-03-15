		; STORES 2 in R0 IF VALID AND 1 in R0 if not valid
		;DONE IN 22 INSTUCTIONS
		AREA proj, CODE, READONLY
		ENTRY
		ldr r1, =UPC ;load ldr with UPC to perform calculations
loop 	ldrb r3, [r1, r7] ;Move digit r0(from counter) of the string into r3 and also set loop
		LSL r3, r3,#28
		LSR r3, r3,#28
		CMP R7,#11
		BEQ break; BREAKS OUT OF LOOP WHEN COUNTER IS = to 11 BREAK IS PLACED HERE SO WE CAN STILL LSL AND LSR THE CHECK DIGIT
		TST r7, #1
		ADDNE r8,r8,r3; IF ODD WE USE r8 TO STORE SUM OF EVEN NUMBERS
		ADDEQ r9, r9, r3; IF EVEN WE USE r9 TO STORE SUM OF EVEN NUMBERS
		ADD r7,r7,#1; INCREMENTS COUNTER
		B loop
break   RSB r6, r9, r9, LSL #2 ;SUBTRACTS r9X4 BY r9 TO GET r9X3 AND STORES IT IN R6
		ADD r6, r8; ADDS SUM1X3 AND SUM2
		ADD R6, R3; ADDS CHECK DIGIT TO SUM
loop2   CMP R6, #0
		MOVMI R0, #2
		MOVEQ R0, #1
		BEQ halt
		BMI halt
		SUB r6, #10
	    b loop2
halt      B     halt
UPC 	DCB "060383755577" ;correct UPC string
		END