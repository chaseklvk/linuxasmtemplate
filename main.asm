; Program Description: This program will calculate and print the variance of an array of numbers

; Author: Chase Zimmerman 

; Creation Date: 4/17/18

; Revisions: N/A

; Date: N/A             Modified by: N/A

; Operating System: Ubuntu

; IDE/Compiler: VSCode/NASM

%include "functions64.inc"

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
global findMean
global calculateVariance
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

  ; Run procedures to calculate variance

  call findMean
  call calculateVariance

  ; Print variance
  push varianceLabel
  call PrintString

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


; CUSTOM PROCEDURES
; Calculate the variance with mean in rax
calculateVariance:
  xor r8, r8                                        ; Clear r8 register and use it to store sum
  mov r9, rax                                       ; Store mean in r9, because rax will be used for multiplication

  mov rcx, SampleArray.numElements                  ; Move number of array elements to rcx
  mov rsi, SampleArray                              ; Move address of array to rsi

  sumLoop:
    mov rax, [rsi]                                  ; Move array value into rax
    sub rax, r9                                     ; Subtract the mean from array value

    mov rbx, rax                                    ; Move the same value into rbx
    imul rbx                                        ; Multiply rax by rbx effectively squaring rax, result in rax

    add r8, rax                                     ; Add to r8, the value in rax

    add rsi, 8                                      ; Increment to the next value
  Loop sumLoop

  ; Now, sum of squares is in r8
  ; Divide by numElements to calculate variance
  mov rax, r8                                       ; Move sum into rax
  cqo                                               ; Sign extend RAX to RDX
  mov rcx, SampleArray.numElements                  ; Move number of elements into rcx
  idiv rcx                                          ; divide by rcx, result in rax

  ret

; Calculates mean and returns value in rax
findMean:
  xor rax, rax                                      ; Clear rax

  mov rcx, SampleArray.numElements                  ; Move number of elements to rcx
  mov rsi, SampleArray                              ; Move address of array to rsi

  ; Add everything together into rax
  addLoop:
    add rax, [rsi]

    add rsi, 8
  Loop addLoop

  ; Now rax contains our sum
  cqo                                                ; Sign extend RAX to RDX
  mov rcx, SampleArray.numElements                   ; Move number to divide into rcx
  idiv rcx                                           ; Divide by rcx, result in rax

  ret
