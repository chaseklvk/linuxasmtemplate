%include "functions64.inc"

section .text

global calcvariance

calcvariance:
    push rbp                                        ; Push previous base pointer
    mov rbp, rsp                                    ; Move current stack pointer to base pointer
    sub rsp, 8                                      ; Create one local variables

    ; Push registers to use
    push r9                                         ; Push r9
    push r8                                         ; Push r8
    push rbx                                        ; Push rbx
    push rcx                                        ; Push rcx
    push rdx                                        ; Push rdx
    push rsi                                        ; Push rsi

    ; Calculate Mean
    xor rax, rax                                    ; Clear RAX

    mov rcx, [rbp + 16]                             ; Move parameter 2 to rcx (num elements)   
    mov rsi, [rbp + 24]                             ; Move parameter 1 to rsi (array address)

    ; Add all elements in array and put sum in rax
    addLoop:
        add rax, [rsi]
        add rsi, 8
    Loop addLoop

    cqo                                             ; Sign extend into rdx in prep for division
    mov rcx, [rbp + 16]                             ; Move paramter 2 to rcx (num elements)
    idiv rcx                                        ; divide rdx:rax by rcx

    mov [rbp-8], rax                                ; Set our local variable to the calculated mean

    ; Calculate Variance

    xor r8, r8                                      ; Clear r8
    xor rax, rax                                    ; Clear rax

    mov r9, [rbp-8]                                 ; Move mean into r9

    mov rcx, [rbp + 16]                             ; Move parameter 2 to rcx (num elements)
    mov rsi, [rbp + 24]                             ; Move parameter 1 to rsi (array address)

    sumLoop:
        mov rax, [rsi]                              ; Move value in rsi to rax
        sub rax, r9                                 ; Subtract the mean

        mov rbx, rax                                ; Move rax to rbx
        imul rbx                                    ; Multiply rax by rbx effectively squaring rax

        add r8, rax                                 ; Add rax to r8 (accumulating the sum of the squares)
        
        add rsi, 8                                  ; Increment rsi
    Loop sumLoop

    mov rax, r8                                     ; Move r8 to rax
    cqo                                             ; Sign extend into rdx
    mov rcx, [rbp + 16]                             ; Move parameter 2 (num elements) into rcx
    idiv rcx                                        ; Divide rdx:rax by rcx

    ; Result (variance) now stored in rax

    pop rsi                                         ; Pop rsi
    pop rdx                                         ; Pop rdx
    pop rcx                                         ; Pop rcx
    pop rbx                                         ; Pop rbx
    pop r8                                          ; Pop r8
    pop r9                                          ; Pop r9

    mov rsp, rbp                                    ; Reset the stack pointer to the location of the base pointer
    pop rbp                                         ; Pop the original base pointer
    ret 16                                          ; Return and "clear" first two parameters from stack