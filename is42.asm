global is42
global return4
is42:
	push ebp; save base pointer to stack
	mov ebp, esp; copy our current code location to base pointer
	mov eax, [ebp+8]; get value from parameter
	cmp eax, 42; check if number is 42
	je _true; if true will return 1 in another part
	mov eax, 0;
	pop ebp; get the base pointer back to what it was
	ret

_true:
	mov eax, 1
	pop ebp
	ret

return4:
	push ebp
	mov ebp, esp
	mov eax, 4
	pop ebp
	ret
