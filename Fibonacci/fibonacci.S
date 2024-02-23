# Entry point of the program.
main:
  addi sp, sp, -4  # Reserve space on the stack for one word.
  sw ra, 0(sp)     # Store the return address on the stack.

  la a0, array     # Load the address of the array into a0.
  li a1, 10        # Load the immediate value 10 into a1.
  call fib         # Call the fib function.

  la a0, array     # Load the address of the array into a0 again.
  lw a0, 36(a0)    # Load the 9th element of the array into a0.

  lw ra, 0(sp)     # Restore the return address from the stack.
  addi sp, sp, 4   # Free the allocated space on the stack.
  ret              # Return from the main function.

# Function to calculate the Fibonacci sequence.
fib:
  li t1, 2         # Load the immediate value 2 into t1.
  slt t0, a1, t1   # Check if a1 < 2, set t0 to 1 if true, else set it to 0.
  beq t0, x0, L0   # Branch to L0 if t0 is 0 (i.e., if a1 >= 2), otherwise return. Return if a1 < 2.

L0:
  li t3, 1         # Load the immediate value 1 into t3.
  sw t3, 0(a0)     # Store t3 in the 0th and 4th elements of the array.
  sw t3, 4(a0)
  li t0, 2         # Load the immediate value 2 into t0.
  
loop_body:
  slt t1, t0, a1           # Check if t0 < a1.
  beq t1, x0, loop_done    # If t0 is not less than a1, jump to loop_done.

  slli t1, t0, 2   # Calculate the index in the array.
  add t1, a0, t1
  
  lw t2, -4(t1)    # Load the previous two Fibonacci numbers from the array.
  lw t3, -8(t1)

  add t4, t2, t3   # Calculate the sum and store it in the current index.
  sw t4, 0(t1)

  addi t0, t0, 1   # Increment t0.
  j loop_body      # Jump back to loop_body.

loop_done:
  ret              # Return from the function.

.data
array: .space 40   # Allocate 40 bytes of space for the array.
