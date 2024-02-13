.global _start     ; Declare _start as a global symbol.

.section .text     ; Section declaration for code.

_start:            ; Entry point of the program.
    li a0, 1       ; Load immediate value 1 into register a0 (a0 = 1) - syscall for write.
    la a1, hello   ; Load address of the "hello" string into register a1.
    li a2, 13      ; Load immediate value 13 into register a2 (a2 = 13) - length of the string.
    li a7, 64      ; Load immediate value 64 (which typically represents the write system call) into register a7 (a7 = 64).
    ecall          ; Execute the system call specified by the value in register a7 (write syscall).

    li a0, 0       ; Load immediate value 0 into register a0 (a0 = 0) - syscall for exit.
    li a7, 93      ; Load immediate value 93 (which represents the exit system call) into register a7 (a7 = 93).
    ecall          ; Execute the system call specified by the value in register a7 (exit syscall).

.section .data     ; Section declaration for data.
hello: .ascii "Hello World!\n"   ; Define a string "Hello World!\n".
