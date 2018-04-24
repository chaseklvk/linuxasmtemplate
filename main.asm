; Program Description: This program will calculate and print the variance of an array of numbers

; Author: Chase Zimmerman 

; Creation Date: 4/17/18

; Revisions: N/A

; Date: N/A             Modified by: N/A

; Operating System: Ubuntu

; IDE/Compiler: VSCode/NASM

%include "functions64.inc"
%include "stats.inc"

section .data
  ;Initialized data definitions go here
  SampleArray dq -999, 878, 776, -580, 768, 654
    .numElements equ ($ - SampleArray) / 8

  ; Prompts and labels
  welcomePrompt db "This program will calculate and print the variance of an array of numbers", 0x0
  closingPrompt db "Program ending, have a nice day!", 0x0
  arrayLabel    db "Here are the values in the array:", 0x0
  varianceLabel db "The variance is: ", 0x0
section .bss
  ;Uninitialized memory reservations go here

section .text
global _start
_start:
  nop
  ; Put program code here

  ; Open prompt
  push welcomePrompt
  call PrintString
  call Printendl
  call Printendl

  ; Print array
  push arrayLabel
  call PrintString
  call Printendl

  ; Loop through array and print
  mov rcx, SampleArray.numElements
  mov rsi, SampleArray

  printLoop:
    push QWORD [rsi]                              ; Push value in rsi to stack
    call Print64bitSNumDecimal                    ; Print the value

    cmp rcx, 1                                    ; Check if our counter is at 1
    jbe skipComma                                 ; If not, skip printing the comma

    call PrintComma                               ; Print comma
    call PrintSpace                               ; Print space

    skipComma:

    add rsi, 8                                    ; Increment rsi to next number
  Loop printLoop

  call Printendl
  call Printendl

  ; Print variance
  push varianceLabel
  call PrintString

  push SampleArray
  push SampleArray.numElements
  call calcvariance


  push rax
  call Print64bitSNumDecimal
  call Printendl
  call Printendl


  ; Closing prompt
  push closingPrompt
  call PrintString
  call Printendl

  ; End program code here
  nop

; Exit the program Linux Legally!
Exit:
  mov rax,  60
  mov rdi,  0
  syscall
