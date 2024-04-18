 .data
A: .word 123
 .word 234
 .word 345
 .word 456
S: .word 0
 .text
main:
     or $t0, $0, $0 # 和を 0 に初期化
     la $t1, A # A のアドレスを $t1 に入れる (実際には ori 命令を使用)．
	 lw $t2, 0($t1)
	 add $t0, $t0, $t2
	 lw $t2, 4($t1)
	 add $t0, $t0, $t2
	 lw $t2, 8($t1)
	 add $t0, $t0, $t2
	 lw $t2, 12($t1)
	 add $t0, $t0, $t2
	 sw $t0,S
exit:    j exit
