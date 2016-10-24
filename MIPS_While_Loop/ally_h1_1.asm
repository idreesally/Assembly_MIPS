##################################################################################
#  
#   IDREES ALLY
#
#   Last modified date: 6/19/15
# 
#   Program name: ally_h1_1
#
#------DESCRIPTION------
#Repeat: cout<<"Enter a negative number from -20 to 0: ";
#	cin>>int1;
#	while((int1<-20) || (int1>0)){
#		cout<<"Number out of range.";
#		cout<<"Enter a negative number from -20 to 0: ";
#		cin>>a;
#	}
#
#	cout<<"Enter a positive number from 0 to 10: ";
#	cin>>int2;
#	while((int2<0) || (int2>10)){
#		cout<<"Number out of range.";
#		cout<<"Enter a positive number from 0 to 10: ";
#		cin>>int2;
#	}
#
#	int a = (int1 - 4*int2)*8;
#	cout>>a;
#	goto Repeat;
# 
#
#  Registers Use:
#	$s0 = -20
#	$s1 = 0
#	$s2 = 10
#	$s3 = int1
#	$s4 = int2
#	$s5 = final calculation
#	$t1, t2, t4, t5, t6, t7 used for checking ranges and for calculation.
#
##################################################################################

.data
	prompt1: .asciiz "\nEnter a negative number from the range -20 to 0: "
	prompt2: .asciiz "\nEnter a positive number from the range 0 to 10: "
	message: .asciiz "\nAfter calculation, your result is : "
	messageError: .asciiz "\nYour input number is out of range."
	
.text
	# Load range values
	li $s0, -20
	li $s1, 0
	li $s2, 10
	
Negative:	# Prompt the user for the negative number
	li $v0, 4
	la $a0, prompt1
	syscall
	
	# Read the negative number
	li $v0, 5
	syscall
	
	# Free $v0,  $s3 gets value of NEGATIVE input
	move $s3, $v0
	
	# Check for range
	slt $t1, $s3, $s0            # t1=1 if s3 < -20, OTW $t1 = 0
	beq $t1, 1, PrintError1
	slt $t2, $s3, $s1            # check if >0
	beq $t2, 0, PrintError1
	J Positive
	
	# Print an error if value is not in correct range
PrintError1: 
	li $v0, 4
	la $a0, messageError
	syscall
	J Negative
	
Positive: # Prompt for positive number
	li $v0, 4
	la $a0, prompt2
	syscall
	
	# Read the positive number
	li $v0, 5
	syscall
	
	# Free $v0,  $t3 gets value of POSITIVE input
	move $s4, $v0
	
	# Check for range
	slt $t4, $s4, $s1            # t4=1 if s4 < 0, OTW $t4 = 0
	beq $t4, 1, PrintError2
	slt $t5, $s4, $s2            # check if >10
	beq $t5, 0, PrintError2
	J Calculation
	
	# Print an error if value is not in correct range
PrintError2: 
	li $v0, 4
	la $a0, messageError
	syscall
	J Positive
	
	# At this point, $s3 contains our negative integer and $s4 contains our positive integer
Calculation:
	sll $t6, $s4, 2    # 4*int2
	sub $t7, $s3, $t6  # (int1 - 4*int2)
	sll $s5, $t7, 3    # (int1 - 4*int2)*8
	
	# Display message
	li $v0, 4
	la $a0, message
	syscall
	
	# Print computed value
	move $a0, $s5
	li $v0, 1
	#li $v0, 1
	#move $a0, $s5
	syscall
	
	# Repeat
	J Negative
