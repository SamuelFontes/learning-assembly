; EX1
;global _start 
_start1: 
	mov eax, 1  	; exit system call
	mov ebx, 42 	; exit code
	sub ebx, 2	; subtract 2 from exit code ebx
	int 0x80 

; EX2
global _start

section .data
	msg db "Hello, World!", 0x0a
	len equ $ - msg

section .text
_start2:
	mov eax, 4	; sys_write system call
	mov ebx, 1	; stdout file descriptor
	mov ecx, msg	; message content
	mov edx, len	; message size
	int 0x80	; perform system call, execute code

	mov eax, 1	; system call to exit the program
	mov ebx, 0	; set the exit code
	int 0x80	; run exit system call

; EX3
; EIP instruction pointer, holds location of machine code the cpu is executing, we can jump around the code by changing this pointer

_start:
	mov ebx, 42	; exit code
	mov eax, 1	; set to exit system call
	jmp _start1
	int 0x80
