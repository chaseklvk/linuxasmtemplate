%include "functions64.inc"

section .data
  ;Initialized data definitions go here
   prompt_str db "Please input an integer: ", 0h
   reversed_str db "Here is the reversed number list: ", 0h
   
section .bss
  ;Uninitialized memory reservations go here
  buffer resq  3
section .text

global _start
_start:
  nop
  push prompt_str
  call PrintString
  call Printendl
  
  mov rcx, 3
  L1:
      call InputUInt
      push rax
  Loop L1
 
 mov rcx, 3
 mov rdi, buffer

 L2:
    pop rax
    mov [rdi], rax
    
    add rdi, 8h
 Loop L2
 
 push reversed_str
 call PrintString
 call PrintSpace
 
 mov rcx, 3
 mov rdi, 0

 L3: 
  push rcx

  mov rax, [buffer + rdi]
  push rax
  call Print64bitNumDecimal
  pop rcx

  add rdi, 8
 Loop L3

 call Printendl
  
  ;Code starts here
    
  ;Code ends here
  nop
  mov rax,60 ; Exit system call value
  mov rdi,0 ; Exit return code
  syscall ; Call the kernel