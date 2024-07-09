global main 
extern printf

section .data
	msg db "Hello, World!", 0x0a
	len equ $ - msg
	addr db "yellow"
	break_line db 0x0a
	print_msg db "Testing %i...", 0x0a, 0x00

section .text

main:
    mov ebp, esp; for correct debugging
	mov ebx, 12	; exit code
	mov eax, 1	; set to exit system call
	;jmp _subtraction
	;jmp _ex5
	push 21
	call _function_with_param
	jmp _allocate_msg_on_stack
	int 0x80
	call _print_with_printf

_exit:
	mov ebx, 0	; exit code 0
	mov eax, 1	; sys_exit
	int 0x80	; exit


_break_line:
	push ebp
	mov eax, 4	; sys_write
	mov ebx, 1	; stdout
	mov edx, 1	; size
	mov ecx, break_line	; break line simbol
	int 0x80	; execute instruction

	;pop eax	; retrieve call stack pointer from stack, and set the eax value to the pointer
	;jmp eax	; go back to where this function was called
	pop ebp
	ret		; this does the same as the two lines above

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
	call _function_with_stack_allocation
	jmp _exit

_function_with_stack_allocation:
	push ebp		; save the pointer from last function into the stack
	mov ebp, esp		; copy the stack pointer location to use to go back to code later
	sub esp, 2		; allocate 2 bytes on the stack
	mov [esp], byte 'H'	
	mov [esp+1], byte 'i'
	mov eax, 4		; sys_write system call
	mov ebx,1		; stdout file descriptor
	mov ecx, esp		; stack pointer to the message
	mov edx, 2		; message size
	int 0x80		; perform system call
	call _break_line	; this is probably a bad idea, if the ebp is replaced we are fucked
	mov esp, ebp
	pop ebp			; get pointer back from last function from the stack
	ret

_function_with_param:
	push ebp
	mov ebp, esp
	mov eax, [ebp+8]	; this will get the parameter that was pushed outside this function
	add eax, eax		; double the value
    	sub esp,1
	mov [esp], eax
	mov eax,4
	mov ebx,1
	mov ecx, esp
	mov edx, 1
	int 0x80
	mov esp, ebp
	pop ebp
	ret

_test:
	mov eax, 4	; sys_write system call
	mov ebx, 1	; stdout file descriptor
	mov ecx, msg	; message content
	mov edx, len	; message size
	int 0x80	; perform system call, execute code

	mov eax, 1	; system call to exit the program
	mov ebx, 0	; set the exit code
	int 0x80	; run exit system call

_print_with_printf:
	push ebp
	mov ebp, esp
	push 123
	push print_msg	
	call printf
	mov eax, 0
	mov esp, ebp
	pop ebp
	ret

