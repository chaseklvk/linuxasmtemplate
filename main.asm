; Program Description: 32 bit Linux application that adds and subtracts different hex values
; Author: Chase Zimmerman
; Creation Date: 2/16/18
; Revisions: N/A
; Date: N/A          Modified by: N/A
; Operating System: Ubuntu
; IDE/Compiler: VSCode/NASM

%include "functions.inc"

bits 32
section .data
  ;Initialized data definitions go here
  varA  db  10h           ; Initialize one byte with value 10h
  varB  dw  2000h         ; Initialize two bytes with value 2000h
  varC  dd  30000h        ; Initialize four bytes with value 30000h

  desc db "A + (B + C) = D: ", 0ah, 0dh, 00h      ; Initialize first description
  desc2 db "(A + C) - B = D: ", 0ah, 0dh, 00h     ; Initialize second description

  varALabel db "VarA (Hex): ", 0ah, 0dh, 00h      ; Initialize varA label
  varBLabel db "VarB (Hex): ", 0ah, 0dh, 00h      ; Initialize varB label
  varCLabel db "VarC (Hex): ", 0ah, 0dh, 00h      ; Initialize varC label
  varDLabel db "VarD (Hex): ", 0ah, 0dh, 00h      ; Initialize varD label
section .bss
  ;Uninitialized memory reservations go here
  varD  resd  1           ; Reserve 4 bytes
section .text

global _start
_start:
  nop
  ;Code starts here
  mov eax, 00h            ; Clear the EAX register

  push varALabel          ; Push varA label to stack
  call PrintString        ; Print the label

  mov al, [varA]          ; Move varA to al 

  push eax                ; Push value of eax to stack
  call Print32bitNumHex   ; Print varA      
  call Printendl          ; Print new line

  mov eax, 00h            ; Clear the EAX register

  push varBLabel          ; Push varB label to stack
  call PrintString        ; Print the label

  mov ax, [varB]          ; Move the value of varB to ax

  push eax                ; Push value of eax to stack
  call Print32bitNumHex   ; Print the value of eax
  call Printendl          ; Print new line

  mov eax, 00h            ; Clear the EAX register

  push varCLabel          ; Push varC label to stack
  call PrintString        ; Print the label

  mov eax, [varC]         ; Move the value of varC to eax

  push eax                ; Push the value of eax to the stack
  call Print32bitNumHex   ; Print the value of eax
  call Printendl          ; Print a new line

  mov eax, 00h            ; Clear the EAX register

  call Printendl          ; Print a new line

  push desc               ; Push description to stack
  call PrintString        ; Print the description

  mov ax, [varB]          ; Move varB to ax
  add eax, [varC]         ; Add varC to eax
  add al, [varA]          ; Add varA to al
  mov [varD], eax         ; Move value in eax to varD

  push DWORD [varD]       ; Push value in varD to stack
  call Print32bitNumHex   ; Print the value of varD
  call Printendl          ; Print new line
  call Printendl          ; Print new line

  mov eax, 00h            ; Clear the EAX register

  push desc2              ; Push the second description to stack
  call PrintString        ; Print the second description

  mov al, [varA]          ; Move value of varA to al
  add eax, [varC]         ; Add varC to eax
  sub eax, [varB]         ; Subtract varB from eax
  mov [varD], eax         ; Move value in eax to varD

  push DWORD [varD]       ; Push value of varD to stack
  call Print32bitNumHex   ; CPrint the value in varD
  call Printendl          ; Print new line

  mov eax, 00h            ; Clear the EAX register

  ;Code ends here
  nop
  mov eax,1 ; Exit system call value
  mov ebx,0 ; Exit return code
  int 80h ; Call the kernel