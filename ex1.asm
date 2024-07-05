global _start #define starting point
_start: # create lable to use goto
	mov eax, 1 # we are making a system exit call, signal end of the program
	mov ebx, 42 # exit status for the program
	int 0x80 #interrupt handler?? this is for system call
