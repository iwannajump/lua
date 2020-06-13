format ELF executable
entry _start
_start:
mov al, 4
mov bl, 1
mov ecx, msg
mov dl, len
int 128
mov al, 1
xor bl, bl
int 128
msg db "Ы", 0xA, 0
len = $ - msg