.data   
A:          .word   100                 # A[0] = 100
            .word   10                  # A[1] = 10
            .word   23
            .word   65
            .word   4
            .word   74
            .word   45
            .word   9                   # A[7] = 9
            .word   38                  # A[8] = 38

ADDRESS_A:  .word   20480               # 00005000 の 10 進表現 = 20480
N:          .word   9                   # The length of Array

ADDRESS_B:  .word   20512               # 00005024 の 10 進表現(ADDRESS_A + 8 * 4 + 4) = 20520
B:          .space  36                  # 配列 B の格納先 大きさは 36 バイト

ONE:        .word   1                   # constant for 1

FOUR:       .word   4                   # constant for 4(for byte addresing)

ID:         .word   107                 # s1300107 = 107

.text   
main:       
    lw      $t0,    N                   # $t0 = N
    lw      $t1,    ONE                 # $t1 = 1
    lw      $t2,    ADDRESS_A           # $t2 = ADDRESS_A
    lw      $t3,    ADDRESS_B           # $t3 = ADDRESS_B
    lw      $t4,    FOUR                # $t4 = FOUR
    lw      $t5,    ID                  # $t5 = 107
    or      $t7,    $0,         $0      # i = 0

loop:       
    beq     $t7,    $t0,        exit    # if i == N, goto loopend
    add     $t7,    $t7,        $t1     # i = i + 1
    beq     $0,     $0,         copy    # goto copy
    beq     $0,     $0,         loop

copy:       
    lw      $t8,    0($t2)              # $t8 = Memory A[i]
    lw      $t9,    0($t3)              # $t9 = Memory B[i]
    add     $t9,    $t8,        $t5     # B[i] = A[i] + 107
    add     $t2,    $t2,        $t4     # $t2 = $t2 + 4
    add     $t3,    $t3,        $t4     # $t3 = $t3 + 4
    sw      $t9,    0($t3)              # Resister B[i] = Memory B[i]
    beq     $0,     $0,         loop    # goto loop

exit:       
    beq     $0,     $0,         exit    # exit
