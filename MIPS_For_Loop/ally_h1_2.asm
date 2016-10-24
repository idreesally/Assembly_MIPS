#############################################################################
#
#	IDREES ALLY
#
#	Last date modified: 6/19/15
#
#	Program name: ally_h1_2
#
#	Psuedo Code:
#		for(int j=5; j<15; j++){
#			total=j - constant;
#			println(“for j equal ” +j + “, total equal ” + total);
#		}
#
#	REGISTERS:
#		$s0 = value of j
#		$s1 = constant
#		$s2 = total
# add s0, s0, 1
#############################################################################

.data
	prompt: .asciiz "Enter a constant value: "
	print1: .asciiz "\nFor j equals "
	print2: .asciiz ", total equals "

.text
	# Start from 5, end at 15
	li $s0, 5     # j
		
	# Prompt for constant
	li $v0, 4
	la $a0, prompt
	syscall
	
	# Read the negative number
	li $v0, 5
	syscall
	
	# Free $v0,  $s1 gets value of CONSTANT
	move $s1, $v0
	
LOOP: 
	#Check to see if j has reached 15
	beq $s0, 15, EXIT
	
	# Compute
	sub $s2, $s0, $s1
	
	# Display first part of message
	li $v0, 4
	la $a0, print1
	syscall
	
	# Print J
	move $a0, $s0
	li $v0, 1
	syscall
	
	# Display second part of message
	li $v0, 4
	la $a0, print2
	syscall
	
	# Print total
	move $a0, $s2
	li $v0, 1
	syscall
	
	# Increase value of j
	add $s0, $s0, 1
	J LOOP

EXIT: