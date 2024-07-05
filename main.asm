; EX1
;global _start 
;_start: 
;mov eax, 1 ; a
;mov ebx, 42 
;sub ebx, 2
;int 0x80 

; EX2
global _start

section .data
	msg db "Hello, World!", 0x0a
	len equ $ - msg

section .text
_start:
	mov eax, 4	; sys_write system call
	mov ebx, 1	; stdout file descriptor
	mov ecx, msg	; message content
	mov edx, len	; message size
	int 0x80	; perform system call, execute code
