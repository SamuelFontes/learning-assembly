#!/bin/bash

nasm -f elf32 main.asm -o a.o
ld -m elf_i386 a.o -o a
