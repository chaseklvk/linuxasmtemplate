%include "functions.inc"

bits 32
section .data
  ;Initialized data definitions go here
  closePrompt db "Program ending, have a nice day!", 00h 
section .bss
  ;Uninitialized memory reservations go here

section .text

global _start
_start:
  nop
  ;Code starts here



  push closePrompt
  call PrintString
  call Printendl
  ;Code ends here
  nop
  mov eax,1 ; Exit system call value
  mov ebx,0 ; Exit return code
  int 80h ; Call the kernel