%include "functions64.inc"

section .data
  ;Initialized data definitions go here
  aName db  "Abraham Lincoln", 0h
  nameSize EQU ($-aName) - 1
section .bss
  ;Uninitialized memory reservations go here

section .text
global _start
_start:
  nop
  ; Put program code here
  push aName
  call PrintString
  call Printendl

  mov rcx, nameSize
  mov rsi, 0
  
  L1: 
    movzx rax, BYTE [aName + rsi]
    push rax
    inc rsi
  Loop L1

  mov rcx, nameSize
  mov rsi, 0
  L2: 
    pop rax
    mov [aName + rsi], al
    inc rsi
  Loop L2

  push aName
  call PrintString
  call Printendl
  ; End program code here
  nop

; Exit the program Linux Legally!
Exit:
  mov rax,  60
  mov rdi,  0
  syscall