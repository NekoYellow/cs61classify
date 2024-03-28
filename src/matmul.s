.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
# Arguments:
# 	a0 (int*)  is the pointer to the start of m0 
#	a1 (int)   is the # of rows (height) of m0
#	a2 (int)   is the # of columns (width) of m0
#	a3 (int*)  is the pointer to the start of m1
# 	a4 (int)   is the # of rows (height) of m1
#	a5 (int)   is the # of columns (width) of m1
#	a6 (int*)  is the pointer to the the start of d
# Returns:
#	None (void), sets d = matmul(m0, m1)
# Exceptions:
#   Make sure to check in top to bottom order!
#   - If the dimensions of m0 do not make sense,
#     this function terminates the program with exit code 72.
#   - If the dimensions of m1 do not make sense,
#     this function terminates the program with exit code 73.
#   - If the dimensions of m0 and m1 don't match,
#     this function terminates the program with exit code 74.
# =======================================================
matmul:
    ble a1, zero, termi72
    ble a2, zero, termi72
    ble a4, zero, termi73
    ble a5, zero, termi73
    bne a2, a4, termi74

    addi sp, sp, -32
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    sw s4, 16(sp)
    sw s5, 20(sp)
    sw s6, 24(sp)
    sw ra, 28(sp)

    mv s0, a0 # s0: A
    mv s1, a1 # s1: n
    mv s2, a2 # s2: m
    mv s3, a3 # s3: B
    mv s4, a4 # s4: m
    mv s5, a5 # s5: p
    mv s6, a6 # s6: C

    slli s2, s2, 2 # *= 2
    slli s5, s5, 2
    li t0, 0 # t0: i

outer_loop_start:
    beq t0, s1, outer_loop_end
    li t1, 0 # t1: j

inner_loop_start:
    beq t1, s5, inner_loop_end

    mv a0, s0
    mv a1, s3
    mv a2, s4
    li a3, 1
    mv a4, s4

    addi sp, sp, -8
    sw t0, 0(sp)
    sw t1, 4(sp)

    jal dot

    lw t0, 0(sp)
    lw t1, 4(sp)
    addi sp, sp, 8

    sw a0, 0(s6)

    addi s3, s3, 4
    addi s6, s6, 4

    addi t1, t1, 4
    j inner_loop_start

inner_loop_end:
    sub s3, s3, s5
    add s0, s0, s2
    addi t0, t0, 1
    j outer_loop_start

outer_loop_end:
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw s4, 16(sp)
    lw s5, 20(sp)
    lw s6, 24(sp)
    lw ra, 28(sp)
    addi sp, sp, 32
    
    ret


termi72:
    li a1, 72
    j exit2

termi73:
    li a1, 73
    j exit2

termi74:
    li a1, 74
    j exit2

