; Program Description: This project will copy a and its contents to a specified location using heap memory.

; Author: Chase Zimmerman

; Creation Date: 5/8/18

; Revisions: N/A

; Date: N/A              Modified by: N/A

; Operating System: Ubuntu

; IDE/Compiler: VSCode/NASM

%include "functions64.inc"

section .data
  ;Initialized data definitions go here
  ; Error/Success Messages
  notEnoughArguments  db  "You've entered an invalid number of arguments. Please specify a path to the source and destination file.", 0x0
  inputFileError      db  "Error opening input file. Verify your path is correct.", 0x0
  outputFileError     db  "Error opening output file. Verify your path is correct.", 0x0
  copyMessage1        db  "Copying ", 0x0
  copyMessage2        db  " to ", 0x0
  totalBytesMessage   db  "Total bytes copied: ", 0x0

  ; Byte Counter
  totalBytes          dq  0
section .bss
  ;Uninitialized memory reservations go here
  inputFileAddress     resq 1
  outputFileAddress    resq 1
  inputFileDescriptor  resq 1
  outputFileDescriptor resq 1
  originalAddress      resq 1
  currentAddress       resq 1
section .text
global _start
_start:
  nop
  ; Put program code here

  ; Verify the user has entered only 2 arguments
  pop rax                                                           ; Pop number of arguments into rax
  cmp rax, 3                                                        ; If there are only 2 arguments, rax will be 3
  je argumentsVerified                                              ; Jump to argumentsVerified if equal 

  ; User has not entered 2 arguments
  push notEnoughArguments
  call PrintString
  call Printendl

  jmp Exit                                                          ; Program needs to end in order to specify the arguments

  argumentsVerified:
  ; User has entered 2 arguments, continue with program
  ; First, lets save the address of the source and dest path
  pop rax                                                           ; Pop first argument (not needed) 
  pop QWORD [inputFileAddress]                                      ; Save input address
  pop QWORD [outputFileAddress]                                     ; Save output address


  ; Attempt to open the input file
  mov rax, 0x2                                                      ; Set the function
  mov rdi, [inputFileAddress]                                       ; Move input file location to rdi
  mov rsi, 0x0                                                      ; Move 0 to rsi
  mov rdx, 0x2                                                      ; Move 2 to rdx, read/write
  syscall                                                           ; Call Kernel

  cmp rax, 0
  jns inputFileSuccess                                              ; If sign flag is not on, input file is successful

  ; Input file was not opened successfully, end program and throw error
  push inputFileError
  call PrintString
  call Printendl

  jmp Exit

  inputFileSuccess:
  ; Input file has opened successfully, lets open or create the output file 
  
  mov [inputFileDescriptor], rax                                    ; First save file descriptor of input file

  ; Attempt to open/create the output file
  mov rax, 0x55                                                     ; Set the function 0x55
  mov rdi, [outputFileAddress]                                      ; Move output file location to rdi
  mov rsi, 777o                                                     ; Set file permissions
  syscall                                                           ; Call the Kernel

  cmp rax, 0
  jns outputFileSuccess                                             ; If sign flag is not on, output file is successful

  ; Output file was not opened successfully, end program and throw error
  push outputFileError
  call PrintString
  call Printendl

  jmp Exit

  outputFileSuccess:
  ; Output file has opened successfully
  
  mov [outputFileDescriptor], rax                                    ; First save the file descriptor of output file

  ; Let the user know the copying has started
  push copyMessage1
  call PrintString
  push QWORD [inputFileAddress]
  call PrintString
  push copyMessage2
  call PrintString
  push QWORD [outputFileAddress]
  call PrintString
  call Printendl

  ; Reserve memory for input buffer
  ; Get current address
  mov rax, 0x0c                                                      ; Set function
  mov rdi, 0x0                                                       ; Bytes to add
  syscall                                                            ; Call Kernel

  mov [originalAddress], rax                                         ; Save original address

  ; Allocate our buffer
  mov rdi, [originalAddress]                                         ; Put original address in rdi
  add rdi, 0x0ffff                                                   ; Allocate ffff bytes of memory
  mov rax, 0x0c                                                      ; Set function
  syscall                                                            ; Call Kernel

  mov [currentAddress], rax                                          ; Save new bottom address

  ; Start reading from file ffff bytes at a time
  readLoop:
    ; Add total bytes to original address
    ; Read from the input file
    mov rax, 0x0                                                     ; Set the function
    mov rdi, [inputFileDescriptor]                                   ; Move file descriptor to rdi
    mov rsi, [originalAddress]                                       ; Set the original address
    add rsi, [totalBytes]                                            ; Add total bytes to rsi
    mov rdx, 0x0ffff                                                 ; Set the size of the input buffer
    syscall                                                          ; Call the Kernel

    push rax                                                         ; Save number of bytes read

    ; Write the data in the buffer to the output file
    mov rax, 0x1                                                     ; Set the function
    mov rdi, [outputFileDescriptor]                                  ; Move file descriptor to rdi
    mov rsi, [originalAddress]                                       ; Where to write data from
    add rsi, [totalBytes]                                            ; Add total bytes to rsi
    pop rdx                                                          ; Pop number of bytes read into rdx
    syscall                                                          ; Call the Kernel

    add QWORD [totalBytes], rdx                                      ; Update the total bytes

    ; Check if the number of bytes read is less than ffff, if it is we're done w/ the loop
    cmp rdx, 0x0ffff
    jb exitLoop                                                      ; Jump to the exit if ra

    ; Not less than ffff, allocate more memory and continue loop
    mov rdi, [currentAddress]
    add rdi, 0x0ffff
    mov rax, 0x0c
    syscall 

    mov [currentAddress], rax                                         ; Update the current address

  Loop readLoop

  exitLoop:
  ; Loop finished, close both files, output total bytes, and deallocate memory

  ; Close input file
  mov rax, 0x3                                                        ; Set function
  mov rdi, [inputFileDescriptor]                                      ; Move file descriptor to rdi
  syscall 

  ; Close output file
  mov rax, 0x3
  mov rdi, [outputFileDescriptor]
  syscall

  push totalBytesMessage
  call PrintString
  push QWORD [totalBytes]                                             ; Push total bytes
  call Print64bitNumDecimal                                           ; Print total bytes
  call Printendl

  ; Clean up the memory
  mov rdi, [originalAddress]                                          ; Move original address into rdi
  mov rax, 0x0c                                                       ; sys_brk
  syscall                                                             ; Call Kernel

  ; End program code here
  nop

; Exit the program Linux Legally!
Exit:
  mov rax,  60
  mov rdi,  0
  syscall