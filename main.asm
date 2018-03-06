%include "functions64.inc"

section .data

  ;Initialized data definitions go here
section .bss
  ;Uninitialized memory reservations go here

section .text
global _start
_start:
  nop
  ; Put program code here

  ; End program code here
  nop

; Exit the program Linux Legally!
Exit:
  mov rax,  60
  mov rdi,  0
  syscall