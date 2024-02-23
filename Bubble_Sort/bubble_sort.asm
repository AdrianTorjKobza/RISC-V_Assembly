.data
  array: .word 5, 2, 7, 3, 8, 9, 1, 4     # Array of numbers to be sorted.
	array_size: .word 8                     # Size of the array.
	newline: .asciiz "\n"                   # Newline character for printing.
	comma_space: .asciiz ", "               # Comma and space for printing.
	.text
	.global main

main:
  lw $t0, array_size                      # Load array size in register t0.

# Sort the numbers using Bubble Sort algo.
outer_loop:
 	li $t1, 1                               # Load Immediate value 1 in register t1. Flag (value 1) indicates if any swaps occur. If no swap occurs during the inner loop iteration, the flag will be reset to 0, indicating that the array is already sorted.
	li $t2, 0                               # Initialize index to 0.


inner_loop:
  bge $t2, $t0, check_flag                # If index >= array_size, go to check_flag.	
  lw $t3, array($t2*4)                    # Load current number (e.g. 5).
  lw $t4, array($t2*4 + 4)                # Load the next number (e.g. 2).
  ble $t3, $t4, no_swap                   # If current element <= next element, no swap is required.

  # Swap elements if current element > next element.
  sw $t4, array($t2*4)
  sw $t3, array($t2*4 + 4)
  li $t1, 0                               # Set flag to 0, to indicate that swap occurred.

no_swap:
	addi $t2, $t2, 1                        # Increment index by 1.
	j inner_loop                            # Jump back to inner_loop.

check_flag:
	bne $t1, 1, outer_loop                  # If flag != 1, go to outer_loop.

  # Print the sorted array.
	li $v0, 4                               # Load the system call for printing string.
	la $a0, newline                         # Load address of newline character.
	syscall	                                # Print newline.

  li $t2, 0                               # Initialize index to 0.

print_loop:
	bge $t2, $t0, exit_program              # If index  >= array size, exit program.
	lw $a0, array($t2*4)                    # Load current number to be printed.
  li $v0, 1                               # Load system call for printing integer.
	syscall                                 # Print current number.
	
  li $v0, 4                               # Load system call for printing string.
	li $a0, comma_space                     # Load address of command_space.
  syscall                                 # Print comma and space.

  addi $t2, $t2, 1                        # Increment index.
  j print_loop                            # Jump to print_loop.

exit_program:
  li $v0, 10                              # Load system call code for exit.
  syscall                                 # Exit program.