;M. Haleigh Wong

INCLUDE Irvine32.inc

.data
	;display menu prompt
	menuDisplay BYTE "1) x AND y", 0dh, 0ah
				BYTE "2) x OR y", 0dh, 0ah
				BYTE "3) NOT x", 0dh, 0ah
				BYTE "4) x XOR y", 0dh, 0ah
				BYTE "5) Exit Program.",0
	num1 BYTE "Enter signed 32-bit integer: ",0
	num2 BYTE "Enter another signed 32-bit integer: ",0
	sum BYTE "The sum of the values is: ",0

	;popup table

	table BYTE '1'
		DWORD operationAND
	entrySize = ($ - table)
		BYTE '2'
		DWORD operationOR
		BYTE '3'
		DWORD operationNOT
		BYTE '4'
		DWORD operationXOR
		BYTE '5'
		DWORD exitMenu

		entryAmt = ($-table) / entrySize
.code
main PROC
	call Clrscr ;clear screen

PROMPT:
	mov EDX, OFFSET menuDisplay
	call WriteString
	call Crlf

USERINPUT:
	call ReadChar
	CMP AL, '5'
	ja USERINPUT
	CMP AL, '1'
	jb USERINPUT
	call Crlf
	call Procedure
	jc QUIT
	call Crlf
	jmp PROMPT ;shows the prompt/display again
QUIT: exit
main ENDP

Procedure PROC ;Procedure implentation to display name of operation
	push EBX
	push ECX
	mov EBX, OFFSET table
	mov ECX, entryAmt

L1:
	CMP AL, [EBX] ;compare values in registers
	jne L2
	call Near PTR [EBX +1]
	jmp L3
L2:
	add EBX, entrySize ;increment
	loop L1
L3:
	pop ECX
	pop EBX
	RET
Procedure ENDP

operationAND PROC
	pushad
	mov EDX, OFFSET num1
	call WriteString
	call ReadDec

	mov EBX, EAX
	mov EDX, OFFSET num2
	call WriteString
	call ReadDec
	and EAX, EBX ;AND operation implemented for two integers

	mov EDX, OFFSET sum ;gives user sum
	call WriteString
	call WriteDec
	call Crlf
	popad
	RET
operationAND ENDP

;basically the same process...
operationOR PROC
	pushad
	mov EDX, OFFSET num1
	call WriteString
	call ReadDec

	mov EBX, EAX
	mov EDX, OFFSET num2
	call WriteString
	call ReadDec
	or EAX, EBX ;OR operation

	mov EDX, OFFSET sum
	call WriteString
	call WriteDec
	call Crlf
	popad
	RET
operationOR ENDP

;repeat process for NOT operation
operationNOT PROC
	pushad
	mov EDX, OFFSET num1
	call WriteString
	call ReadDec
	not EAX ;NOT operation

	mov EDX, OFFSET sum
	call WriteString
	call WriteDec
	call Crlf
	popad
	RET
operationNOT ENDP

operationXOR PROC
	pushad
	mov EDX, OFFSET num1
	call WriteString
	call ReadDec
	
	mov EBX, EAX
	mov EDX, OFFSET num2
	call WriteString
	call ReadDec
	xor EAX, EBX ;XOR operation
	mov EDX, OFFSET sum
	call WriteString
	call WriteDec
	call Crlf
	popad
	RET
operationXOR ENDP

exitMenu PROC
	STC ;adjust Carry flag and set it
	RET
exitMenu ENDP
END main