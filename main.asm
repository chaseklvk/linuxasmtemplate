%include "functions64.inc"

section .data
  ;Initialized data definitions go here
  bufferSize    dq      0x0ffff
section .bss
  ;Uninitialized memory reservations go here
  oldAddress    resq    1
  memoryAddress resq    1
  totalBytes    resq    1
section .text
global _start
_start:
  nop
  ; Put program code here

  ; Get current memory limit
  mov rax, 0x0c
  mov rdi, 0x0
  syscall                     

  mov [oldAddress], rax                 ; Save original mem limit

  ; Extend our memory 
  mov rdi, [oldAddress]                 ; Place old bottom address in rdi
  add rdi, 0x100                        ; Allocate 256 bytes by adding 0x100 to address in rdi
  mov rax, 0x0c                         ; sys_brk
  syscall                               ; Call kernel

  mov [memoryAddress], rax              ; Put new memory address into memory address variable


  ; Print to test
  push QWORD [oldAddress]
  call Print64bitNumHex
  call Printendl

  push QWORD [memoryAddress]
  call Print64bitNumHex
  call Printendl


  ; Clean up the memory
  mov rdi, [oldAddress]                  ; Put original limit into rdi
  mov rax, 0x0c                          ; sys_brk 
  syscall                                ; Call kernel, this will restore unused memory

  ; End program code here
  nop

; Exit the program Linux Legally!
Exit:
  mov rax,  60
  mov rdi,  0
  syscall