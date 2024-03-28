.data
board: .space 1024             # Allocate space for the board
bomb_timers: .space 4096       # Int matrix to keep track of bomb timers
bomb_to_detonate: .space 4096  # Keeps the indexes of the bombs that is going to detonate
input_second: .asciiz 	       "Enter the number of seconds:"
input_row: .asciiz	       "Enter the number of rows:"
input_column: .asciiz 	       "Enter the number of colums:"
input_board: .asciiz 	       "Enter the board as line (e.g. 3x2 board should be entered as ..O...):"
buffer: .space 256             # Buffer for user input; 16 characters per row + 16 newline characters
buffer_detonation: .asciiz     "Inside Detonation\n"
dot_second: .asciiz 	       ". Second"

.text
.globl main

main:
    # Get game board from the user
    jal get_inputs
    
    # Initialize the game board with user input
    jal initialize_board
    
    # Simulate game for the number of seconds which is taken from the user
    li $s1, 0                  # Current second counter
    addi $s1, $s1, 1           # Pass the first second
    jal update_bomb_timers     # Update bomb timers
    
    # Print current second and board state
    jal print_board_with_second
    
    # Simulation Loop
simulation_loop: #  The main loop of the program
    beq $s0, $s1, end_simulation   # End the simulation if current second counter is reached to desired time
    
    addi $s1, $s1, 1          # Decrement total simulation seconds 
    
    # Simulation for one second. All the game logic lies here.
    jal update_bomb_timers      # Updates bomb timers in every second. 
    jal plant_bombs          	# Plants bombs to the empty cells.
    jal determine_the_bombs     # Finds the bombs that needs to detonate in that second.       
    jal detonate_bombs   	# Detonates the bombs and their adjacent cells.
    jal print_board_with_second # Prints the board and current second.
    j simulation_loop

end_simulation:
    # Exit the program
    li $v0, 10
    syscall


# Subroutine to read the entire game board from user input
get_inputs:

    li $v0, 4                # Syscall for print_str
    la $a0, input_second     # Load the address of the prompt
    syscall                  # Print the prompt
    
    li $v0, 5                # Syscall for read integer
    syscall
    move $s0 $v0             # Save number of seconds in s1 register 
    
    li $v0, 4                # Syscall for print_str
    la $a0, input_row        # Load the address of the prompt
    syscall                  # Print the prompt
    
    li $v0, 5                # Syscall for read integer
    syscall
    move $s2 $v0             # Save row number in s2 register
    
    li $v0, 4                # Syscall for print_str
    la $a0, input_column        # Load the address of the prompt
    syscall                  # Print the prompt
    
    li $v0, 5                # Syscall for read integer
    syscall
    move $s3 $v0             # Save column number in s3 register 
    
    li $v0, 4                # Syscall for print_str
    la $a0, input_board       # Load the address of the prompt
    syscall                  # Print the prompt
    
    li $v0, 8                # Syscall for read_string
    la $a0, buffer           # Address of the buffer to store the input
    li $a1, 1024              # Max number of characters to read
    syscall                  # Read the string into buffer
    jr $ra                   # Return from subroutine


# Subroutine to initialize the game board with user input
initialize_board:
    li $t0, 0                # Index for the board array
    la $t3, buffer           # Load the address of the buffer

    move $t1, $s2            # Row counter
process_rows:
    move $t2, $s3            # Column counter
process_columns:
    lb $t4, 0($t3)           # Load the byte from buffer into $t4
    sb $t4, board($t0)       # Store the byte into the board array at index $t0
    
    # Check if the cell contains a bomb
    li $t5, 'O'
    beq $t4, $t5, set_bomb_timer
    li $t8, 0                # Initial empty cell value
    move $t9, $t0
    sll $t9, $t9, 2	     # multiply board adress by four becuase the new adress for an integer array
    sw $t8, bomb_timers($t9) # Set bomb timer
    j next_column            # Skip setting the bomb timer

set_bomb_timer:
    li $t7, 3                # Initial bomb timer value
    move $t9, $t0
    sll $t9, $t9, 2	     # multiply board adress by four becuase the new adress for an integer array
    sw $t7, bomb_timers($t9) # Set bomb time

next_column:
    addi $t0, $t0, 1         # Increment the board index
    addi $t3, $t3, 1         # Increment the buffer pointer
    addi $t2, $t2, -1        # Decrement the column counter
    bnez $t2, process_columns # If column counter is not zero, continue
    
    addi $t1, $t1, -1        # Decrement the row counter
    bnez $t1, process_rows   # If row counter is not zero, continue

    jr $ra                   # Return from subroutine


# Subroutine to print the game board
print_board:
    li $t0, 0              # Index for the board array
    move $t1, $s2          # Row counter

print_rows:
    move $t2, $s3          # Column counter

print_columns:
    lb $a0, board($t0)     # Load the byte from the board array into $a0
    li $v0, 11             # Syscall for print_char
    syscall                # Print the character

    addi $t0, $t0, 1       # Increment the board index
    addi $t2, $t2, -1      # Decrement the column counter
    bnez $t2, print_columns # If column counter is not zero, continue

    # Print a newline at the end of each row
    li $v0, 11             # Syscall for print_char
    li $a0, 10             # ASCII code for newline
    syscall                # Print the newline

    addi $t1, $t1, -1      # Decrement the row counter
    bnez $t1, print_rows   # If row counter is not zero, continue

    jr $ra                 # Return from subroutine


# Subroutine to print the game board timers
print_bomb_timers:
    la $t0, bomb_timers    # adreess of the bomb_timers
    move $t1, $s2          # Row counter

print_bomb_timers_rows:
    move $t2, $s3          # Column counter

print_bomb_timers_columns:
    lw $a0, 0($t0)     # Load the byte from the bomb_timers array into $a0
    li $v0, 1             # Syscall for print_int
    syscall                # Print the character

    addi $t0, $t0, 4       # Increment the board index
    addi $t2, $t2, -1      # Decrement the column counter
    bnez $t2, print_bomb_timers_columns # If column counter is not zero, continue

    # Print a newline at the end of each row
    li $v0, 11             # Syscall for print_char
    li $a0, 10             # ASCII code for newline
    syscall                # Print the newline

    addi $t1, $t1, -1      # Decrement the row counter
    bnez $t1, print_bomb_timers_rows   # If row counter is not zero, continue
    
    # Print a newline at the end of each row
    li $v0, 11             # Syscall for print_char
    li $a0, 10             # ASCII code for newline
    syscall                # Print the newline


    jr $ra                 # Return from subroutine


# Subroutine to update bomb timers
update_bomb_timers:
    la $t0, bomb_timers      # Address of the bomb_timers
    mul $t1, $s2, $s3        # Total cells in the board
    li $t2, 0                # Index for the array

update_timer_loop:
    beq $t2, $t1, end_timer_update # End loop if all cells are processed

    lw $t3, 0($t0)           # Load the bomb timer
    bgtz $t3, decrease_timer # If timer is greater than 0, decrease it

    # Move to next cell
    addi $t2, $t2, 1         # Increment index
    addi $t0, $t0, 4         # Move to next cell
    j update_timer_loop

decrease_timer:
    addi $t3, $t3, -1        # Decrease the timer
    sw $t3, 0($t0)          # Store the updated timer (-4 because $t0 already moved to next cell)
    # Move to next cell
    addi $t2, $t2, 1         # Increment index
    addi $t0, $t0, 4         # Move to next cell
    j update_timer_loop

end_timer_update:
    jr $ra


# Subroutine to plant bombs on all empty cells
plant_bombs:
    li $t0, 0                # Index for board
    la $t6, bomb_timers      # Address of the bomb_timers
    mul $t1, $s2, $s3        # Total cells in the board        
    li $t5, 3                # Set timer to 3

plant_loop:
    beq $t0, $t1, end_plant  # End loop if all cells are processed

    lb $t2, board($t0)       # Load the cell value
    li $t3, 'O'              # ASCII for 'O'
    li $t4, '.'              # ASCII for '.'
    beq $t2, $t4, plant_bomb # If cell is empty, plant a bomb

    # Move to next cell
    addi $t0, $t0, 1
    addi $t6, $t6 4
    j plant_loop

plant_bomb:
    sb $t3, board($t0)       # Plant a bomb
    sw $t5, 0($t6) # Initialize bomb timer
    # Move to next cell
    addi $t0, $t0, 1
    addi $t6, $t6 4
    j plant_loop

end_plant:
    jr $ra
    

# Subtroutine that keeps the indexes of the bombs that will detonate     
determine_the_bombs:
    li $t0, 0                # Index for board
    mul $t1, $s2, $s3        # Total cells in the board (rows * columns)
    la $t2, bomb_timers      # Address of the bomb_timers
    la $t3, bomb_to_detonate # Address of the bomb_to_detonate
    li $t8, 0     	     # Number of bombs that will detonate

determine_the_bombs_loop:
    beq $t0, $t1, end_determine # End loop if all cells are processed

    lw $t4, 0($t2)           # Load the bomb timer
    lb $t6, board($t0)       # Load the cell value from the board

    li $t7, 'O'              # ASCII for 'O'
    bne $t6, $t7, next_bomb_determine  # If cell is not 'O', skip to next bomb
    bnez $t4, next_bomb_determine      # If timer is not zero, skip to next bomb

    # If the cell is 'O' and timer is zero, keep the index
    sw $t0, 0($t3)           # Store the index in bomb_to_detonate
    addi $t3, $t3, 4         # Move to the next index in bomb_to_detonate
    addi $t8, $t8, 1	     # Increase number of bombs that will detonate by one

next_bomb_determine:
    addi $t0, $t0, 1         # Increment the board index
    addi $t2, $t2, 4         # Move to the next bomb timer
    j determine_the_bombs_loop

end_determine:
    move $s4, $t8            # Keep the number of bombs that will to detonate in s4 register.
    jr $ra
    

# Subroutine to detonate bombs
detonate_bombs:
    li $t0, 0                # Total bombs detonated
    la $t1, bomb_timers      # Address of the bomb_timers
    la $t2, bomb_to_detonate # Address of the bomb_to_detonate
    mul $s5, $s2, $s3        # Total cells in the board 

detonate_loop:
    beq $t0, $s4, end_detonate # End loop if all cells are processed

    lw $t3, 0($t2)          # Get the index of the bomb that will detonate

    # Clear the current cell
    li $t4, '.'              # ASCII for '.'
    sb $t4, board($t3)       # Set the current cell to empty
    sll $t5, $t3, 2          # Multiply index in $t4 by 4 to get byte offset
    add $t5, $t5, $t1        # Add the offset to the base address of bomb_timers
    sw $zero, 0($t5)         # Reset the bomb timer at the calculated address
    
    # Calculate indices for adjacent cells
    sub $t5, $t3, $s3        # Index for 'up' cell
    add $t6, $t3, $s3        # Index for 'down' cell
    addi $t7, $t3, -1        # Index for 'left' cell
    addi $t8, $t3, 1         # Index for 'right' cell
    
    # Check boundaries and clear cells
clear_cell_up:
    bgez $t5, clear_up
    j next_clear_up
clear_up:
    sb $t4, board($t5)      # Clear 'up' cell
    move $t9, $t5
    sll $t9, $t9, 2	    # Index for 'up' cell in bomb_timers    
    add $t9, $t9, $t1       # Add the offset to the base address of bomb_timers
    sw $zero, 0($t9) 	    # Reset bomb timer
next_clear_up:

clear_cell_down:
    blt $t6, $s5, clear_down
    j next_clear_down
clear_down:
    sb $t4, board($t6)      # Clear 'down' cell
    move $t9, $t6
    sll $t9, $t9, 2	    # Index for 'down' cell in bomb_timers    
    add $t9, $t9, $t1       # Add the offset to the base address of bomb_timers
    sw $zero, 0($t9) 	    # Reset bomb timer
next_clear_down:

clear_cell_left:
    rem $t9, $t3, $s3        
    bnez $t9, clear_left     
    j next_clear_left
clear_left:
    sb $t4, board($t7)      # Clear 'left' cell
    move $t9, $t7           # left cell of bomb_timers     
    sll $t9, $t9, 2	    # Index for 'left' cell in bomb_timers  
    add $t9, $t9, $t1       # Add the offset to the base address of bomb_timers
    sw $zero, 0($t9) 	    # Reset bomb timer
next_clear_left:

clear_cell_right:
    rem $t9, $t3, $s3        # Get column index of the current cell
    addi $t9, $t9, 1
    bne $t9, $s3, clear_right
    j next_clear_right
clear_right:
    sb $t4, board($t8)      # Clear 'right' cell
    move $t9, $t8,          # right cell of bomb_timers     
    sll $t9, $t9, 2	    # Index for 'right' cell in bomb_timers  
    add $t9, $t9, $t1       # Add the offset to the base address of bomb_timers 
    sw $zero, 0($t9) 	    # Reset bomb timer
next_clear_right:

next_bomb:
    addi $t0, $t0, 1        # Increment total bombs detonated
    addi $t2, $t2, 4
    j detonate_loop

end_detonate:
    jr $ra                   # Return from subroutine
    
    
# Subroutine to print the game board with current second
print_board_with_second:
    # Save the current second (in $a0) to a temporary register ($t7)
    move $t7, $s1

    # Save the original return address
    move $t9, $ra

    # Print the current second
    li $v0, 1              # Syscall for printing integer
    move $a0, $t7          # Move saved second to $a0
    syscall                # Print the current second
    
    li $v0, 4               # Syscall for print_str
    la $a0, dot_second      # Load the address of the prompt
    syscall                 # Print the prompt

    # Print newline to separate the second number
    li $v0, 11             # Syscall for print_char
    li $a0, 10             # ASCII code for newline
    syscall                # Print newline

    # Call print_board subroutine
    jal print_board

    # Restore the original return address
    move $ra, $t9

    # Return from subroutine
    jr $ra