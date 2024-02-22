.data
prompt_number1: .asciiz "Enter the first number: "
prompt_number2: .asciiz "Enter the second number: "
prompt_operation: .asciiz "Choose operation:\n1. Addition\n2. Subtraction\n3. Multiplication\n4. Division\n"
result_msg: .asciiz "Result: "
newline: .asciiz "\n"
.text
.global main

main:
    # Capture the first number from user.
    li $v0, 4                    # Load system call code for printing string.
    la $a0, prompt_number1       # Load address of prompt_number1 into $a0.
    syscall                      # Print prompt_number1 string.
    li $v0, 5                    # Load system call code for printing string.
    syscall                      # Read the first number.
    move $s0, %v0                # Save the first number in $s0.
    
    # Capture the second number from user.
    li $v0, 4                    # Load system call code for printing string.
    la $a0, prompt_number2       # Load address of prompt_number2 into $a0.
    syscall                      # Print prompt_number1 string.
    li $v0, 5                    # Load system call code for printing string.
    syscall                      # Read the second number.
    move $s1, %v0                # Save the second number in $s1.
    
    ; Select operation (+, -, *, /).
    li $v0, 4                    # Load system call code for printing string.
    la $a0, prompt_operation     # Load address of prompt_operation into $a0.
    syscall                      # Print prompt_operation string.
    li $v0, 5                    # Load system call code for printing string.
    syscall                      # Read operation choice.
    move $s2, %v0                # Save the operation choice in $s2.
    
    # Perform the selected operation.
    li $t0, 1                    # Load 1 (addition) into $t0.
    beq $s2, $t0, addition       # Trigger the addition if choice is 1.
    li $t0, 2                    # Load 2 (substraction) into $t0.
    beq $s2, $t0, substraction   # Trigger the substraction if choice is 2.
    li $t0, 3                    # Load 3 (substraction) into $t0.
    beq $s2, $t0, multiplication # Trigger the multiplication if choice is 3.
    li $t0, 4                    # Load 4 (division) into $t0.
    beq $s2, $t0, division       # Trigger the division if choice is 3.
    
addition:
    # Perform addition.
    add $s3, $s0, $s1            # Add the first and second number.
    j print_result               # Jump to print_result.
    
subtraction:
    # Perform subtraction.
    sub $s3, $s0, $s1            # Subtract second number from first number.
    j print_result               # Jump to print_result.
    
multiplication:
    # Perform multiplication.
    mul $s3, $s0, $s1            # Multiply the first number by second number.
    j print_result               # Jump to print_result.

division:
    # Perform division.
    div $s0, $s1                 # Divide first number by second number.
    mflo $s3                     # Move quotient to $s3.
    j print_result               # Jump to print_result.
    
print_result:
    # Print the result.
    li $v0, 4                    # Load system call code for printing string.
    la $a0, result_msg           # Load address of result into $a0.
    syscall                      # Print result_msg.
    li $v0, 1                    # Load system call code for printing integer.
    move $a0, $s3                # Move result to $a0.
    syscall                      # Print result.
    j exit                       # Jump to exit.
    
exit:
    # Exit program.
    li $v0, 10                   # Load system call code for exit.
    syscall                      # Exit program.
