global _start 
_start: 
mov eax, 1 ; a
mov ebx, 42 
sub ebx, 2
int 0x80 
