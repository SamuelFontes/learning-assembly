; EX1
global _start 
_subtraction: 
	mov eax, 1  	; exit system call
	cmp ebx, 42	; if(ebx == 42)
	jl _loop
	sub ebx, 2	; subtract 2 from exit code ebx
	int 0x80 

;je A, B ;jump if equal
; EX2

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
	mov ebx, 12	; exit code
	mov eax, 1	; set to exit system call
	;jmp _subtraction
	;jmp _ex5
	jmp _allocate_msg_on_stack
	int 0x80

_exit:
	mov ebx, 0	; exit code 0
	mov eax, 1	; sys_exit
	int 0x80	; exit

; 
_loop:
	inc ebx
	jmp _subtraction



;ex5
section .data
	addr db "yellow"
	break_line db 0x0a

_break_line:
	mov eax, 4	; sys_write
	mov ebx, 1	; stdout
	mov edx, 1	; size
	mov ecx, break_line	; break line simbol
	int 0x80	; execute instruction

	pop eax		; retrieve call stack pointer from stack
	jmp eax		; go back to where this function was called

_ex5:
	mov [addr], byte 'H'
	mov [addr+5], byte '!'
	mov eax, 4	; sys_write system call
	mov ebx, 1	; stdout file descriptor
	mov ecx, addr 	; set string location
	mov edx, 6	; set string size
	int 0x80	; execute the system call
	
	call _break_line
	jmp _exit



_allocate_msg_on_stack:
; allocate memory
	sub esp, 4		; move stack pointer 4 bytes, allocate memory on the stack
; write message to memory 
	mov [esp], byte 'H'
	mov [esp+1], byte 'e'
	mov [esp+2], byte 'y'
	mov [esp+3], byte '!'
; write message from memory to stdout
	mov eax, 4	; sys_write system call
	mov ebx, 1	; stdout file descriptor
	mov ecx, esp	; pointer to bytes to write
	mov edx, 4	; size in bytes for the message we weill write
	int 0x80	; peform system call
	call _break_line
	jmp _exit
