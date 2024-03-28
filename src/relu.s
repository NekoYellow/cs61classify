.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 (int*) is the pointer to the array
#	a1 (int)  is the # of elements in the array
# Returns:
#	None
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 78.
# ==============================================================================
relu:
    ble a1, zero, termi78

    addi sp, sp, -4
    sw ra, 0(sp)
    
    add t0, zero, zero # t0: i

loop_start:
    beq t0, a1, loop_end
    jal relu_ele
    addi t0, t0, 1
    addi a0, a0, 4
    j loop_start

loop_end:
    lw ra, 0(sp)
    addi sp, sp, 4
    
	ret # equivalent to jr ra


# ==============================================================================
# FUNCTION: Performs an inplace ReLU on an int
# Arguments:
# 	a0 (int*) is the pointer to the int
# Returns:
#	None
# ==============================================================================
relu_ele:
    addi sp, sp, -4
    sw s0, 0(sp)

    lw s0, 0(a0)
    blt zero, s0, relu_finish
    sw zero, 0(a0)

relu_finish:
    lw s0, 0(sp)
    addi sp, sp, 4
    jr ra


termi78:
    li a1, 78
    j exit2
