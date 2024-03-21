.data
# First matrix.
A:  .word   3, 1, 1
    .word   4, 2, 6
    .word   9, 8, 5

# Second matrix.
B:  .word   6, 2, 1
    .word   5, 3, 4
    .word   3, 2, 7

# Result matrix, with 9 elements of 4-byte size, initialized to 0.
C:  .fill   9, 4, 0

# Define a string in memory. "%3d" is a format for printing integers that occupies at least 3 characters.
prtstr: .asciz  "%3d  %3d  %3d\n"

.global main
    .equ    N, 3                # Define matrix dimension.
    .equ    WDSIZE, 4           # Define the size of matrix element.

main:
    addi    sp, sp, -48         # Allocate space on the stack for saving registers.
    sd      ra, 32(sp)          # Save the return address to the stack.
    sd      s1, 24(sp)          # Save registers s1-s4 to the stack.
    sd      s2, 16(sp)
    sd      s3, 8(sp)
    sd      s4, 0(sp)

    li      t0, N               # Load the matrix dimension into t0 (row index).
    la      t2, A               # Load the address of the first row of matrix A into t2.
    la      s1, C               # Load the address of the result matrix C into s1.

row_loop:
    la      t3, B               # Load the address of the first column of matrix B into t3.
    li      t1, N               # Load the matrix dimension into t1 (column index).

col_loop:
    li      t4, 0               # Initialize to 0, the accumulator for the dot product.
    mv      s3, t2              # Copy the current row address from t2 to s3.
    mv      s4, t3              # Copy the current column address from t3 to s4.

dot_loop:
    lw      t5, 0(s3)           # Load the current element of matrix A into t5.
    lw      t6, 0(s4)           # Load the current element of matrix B into t6.
    
    mul     t5, t5, t6          # Multiply the corresponding elements of A and B.
    add     t4, t4, t5          # Accumulate the result in t4.

    addi    s3, s3, WDSIZE      # Move to the next element in the current row of A.
    addi    s4, s4, WDSIZE      # Move to the next element in the current column of B.
    
    addi    t1, t1, -1          # Decrement the column index.
    bnez    t1, dot_loop        # Repeat dot product until the column index is not zero.

    sw      t4, 0(s1)           # Store the result of the dot product, in the result matrix C.
    add     s1, s1, WDSIZE      # Move to the next column in the result matrix.
    add     t3, t3, WDSIZE      # Move to the next column in matrix B.
    addi    t0, t0, -1          # Decrement the row index.
    bnez    t0, row_loop        # Repeat row loop until the row index is not zero.

    li      s2, N               # Initialize the loop counter for printing.
    la      s1, C               # Load the address of the result matrix C into s1.

print_loop:
    la      a0, prtstr          # Load the format string for printing.
    lw      a1, 0(s1)           # Load the first element of the current row.
    lw      a2, WDSIZE(s1)      # Load the second element of the current row.
    lw      a3, 2*WDSIZE(s1)    # Load the third element of the current row.
    add     s1, s1, WDSIZE      # Move to the next row in the result matrix.
    
    call    printf              # Call printf to print the current row. The printf function is invoked from an external library.
    addi    s2, s2, -1          # Decrement the loop counter.
    bnez    s2, print_loop      # Repeat printing until the loop counter is not zero.
    
    li      a0, 0               # Set the return code to 0.
    ld      ra, 32(sp)          # Restore registers ra, s1-s4 from the stack.
    ld      s1, 24(sp)
    ld      s2, 16(sp)
    ld      s3, 8(sp)
    ld      s4, 0(sp)
    addi    sp, sp, 48          # Deallocate space on the stack.
    ret                         # Return from the main function.
