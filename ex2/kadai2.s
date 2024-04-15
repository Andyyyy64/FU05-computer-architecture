    .data
A:
    .word 32    # A[0] = 32
    .word 28    # A[1] = 28
    .word 49
	.word 5
	.word 67
	.word 10
	.word 8
	.word 30
	.word 21    # A[8] = 21
ADDRESS_A:
    .word 20480 #00005000 の 10 進表現
N:
    .word 9     # The length of Array
S:
    .word 0     # for result
ONE:
    .word 1     # for constant 1
FOUR:
    .word 4     # for constant 4

    .text
main:
    or $t0, $0, $0          # i = 0
    lw $t1, N
    lw $t2, FOUR
    or $t3, $0, $0          # if ev 0, if odd 1, init 0
    or $t4, $0, $0          # load result register
    lw $t5, ADDRESS_A       # load array's addres
    lw $t6, ONE             # load constant 1

loop:
    beq $t0, $t1, loopend   # if i == n goto loopend
    add $t0, $t0, $t6       # i++
    beq $t3, $0, addfunc    # if i % 2 == 0 goto add
    beq $t3, $t6, subfunc    # else goto sub
    beq $0, $0, loop

addfunc:
    lw $t7, 0($t5)
    add $t4, $t4, $t7       # s += A[i]
    lw $t3, ONE
    add $t5, $t5, $t2       # i++(is array so +4byte)
    beq $0, $0 loop         # go back to loop

subfunc:
    lw $t7, 0($t5)
    sub $t4, $t4, $t7       # s -= A[i]
    or $t3, $0, $0
    add $t5, $t5, $t2       # i++(is array so +4byte)
    beq $0, $0, loop        # go back to loop
loopend:
    sw $t4, S
exit:
    beq $0, $0, exit
