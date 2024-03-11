.data
i_string:  .asciz  "Test string that Will be converted to UPPER CASE.\n"
o_string_uc: fill  255, 1, 0    # Allocate 255 bytes for the output string filled with zeroes.

.global _start

_start:
    la    x5, o_string_uc       # Address of the upper-case output string.
    la    x6, i_string          # Start address of the input string.

loop:
    lb    x7, 0(x6)             # Load character from input string. (e.g. Load the first character)
    addi  x6, x6, 1             # Increment the memory address by 1. (e.g. Points to the 2nd character)

    # Check if character is already upper case: < 'a' or > 'z'.
    li    x28, 'z'              # Load character 'z' for comparison.
    bgt   x7, x28, cont         # Branch to "cont" if letter > 'z'.
    li    x28, 'a'              # Load character 'a' for comparison.
    blt   x7, x28, cont         # Branch to "cont" if letter < 'a'.

    addi  x7, x7, ('A'-'a')     # Convert lower-case character to upper-case character.

cont:
    sb    x7, 0(x5)             # Store character to output string.
    addi  x5, x5, 1             # Increment the memory address by 1. Increment buffer for the next character.
    li    x28, 0                # load 0 character for comparison.
    bne   x7, x28, loop         # Loop if character isn't null: \0. (If we didn't reach the end of string)

    # Print the upper-case output string.
    li    a0, 1                 # Load the StdOut (1) function.
    la    a1, o_string_uc       # Load the output string to a1 register.
    sub   a2, x5, a1            # Get the length of the string. a1 - start of the string adress, x5 - end of string adress.
    li    a7, 64                # Load the Linux write system call. (a0 - file descriptor, a1 - buffer address, a2 - buffer length)
    ecall                       # Call Linux to output the string.

    # Terminate the program.
    li    a0, 0                 # Load 0 return code.
    li    a7, 93                # Load service code 93 to terminate the program.
    ecall                       # Call Linux to terminate the program.
