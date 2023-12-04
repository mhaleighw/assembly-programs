;M. Haleigh Wong


;INCLUDE Irvine32.inc
;32-bit program
.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
	bigEndian BYTE 10h, 20h, 30h, 40h	;initialize data
	littleEndian DWORD ?	;use DWORD data type

.code
main PROC
	mov al, [bigEndian +3]
	mov BYTE PTR [littleEndian], al
	
	mov al, [bigEndian +2]
	mov BYTE PTR [littleEndian + 1], al

	mov al, [bigEndian +1]
	mov BYTE PTR [littleEndian + 2], al

	mov al, [bigEndian]
	mov BYTE PTR [littleEndian +1], al

	INVOKE ExitProcess, 0

main ENDP
END main