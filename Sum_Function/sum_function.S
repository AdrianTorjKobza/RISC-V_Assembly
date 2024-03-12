# Define variables.
.EQU  VAR1, 0
.EQU  VAR2, 8
.EQU  SUM,  16

sum_function:
    addi    sp, sp, -48         # Allocate space on the stack, rounded up to the next multiple of 16. Decrease the stack pointer by 48 bytes, effectively reserving 48 bytes of space.
    sd      ra, 32(sp)          # Save the return address (ra) onto the stack, at an offset of 32 bytes from the current stack pointer (sp).
    sd      fp, 24(sp)          # Save s0/fp (frame pointer) onto the stack, at an offset of 24 bytes from the current stack pointer. The frame pointer is used to reference local variables.
    addi    fp, sp, 48          # Set the frame pointer (fp) to point to the top of the current function's stack frame by adding 48 to the current stack pointer (sp).
    sd      a0, VAR1(fp)        # Store the first paramater onto the stack, by an offset of 0.
    sd      a1, VAR2(fp)        # Store the second paramater onto the stack, by an offset of 8.

    ld      t0, VAR1(fp)        # Load in t0 register, the value stored at the memory address specified by fp and the offset VAR1 (0).
    ld      t1, VAR2(fp)        # Load in t1 register, the value stored at the memory address specified by fp and the offset VAR2 (8).
    add     t2, t0, t1          # Add t0 and t1 (t0 + t1) and store the result in t2 register.
    sd      t2, SUM(fp)         # Save the sum result (t2) onto the stack, by an offset of 16.


    ld      a0, SUM(fp)         # Load in a0 register (return register), the sum stored in stack, at the memory address specified by fp and the offset SUM (16).
    ld      fp, 24(sp)          # Restore the original value of the frame pointer (fp).
    ld      ra, 32(sp)          # Restore the return address (ra).
    addi    sp, sp, 48          # Release the stack storage by adding 48 bytes.
    ret                         # Jump to return address (ra) and resumes execution from there. End the function and returns control to the calling code.
