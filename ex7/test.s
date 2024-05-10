	 .data
A:		.word  0x335e	
B:	 	.word  0x0d21
C:	 	.word  0xc
SW_RSLT:	.word  0
ADD_RSLT:	.word  0		
SUB_RSLT:	.word  0	
ADDI_RSLT:	.word  0	
AND_RSLT:	.word  0
OR_RSLT:	.word  0
ANDI_RSLT:	.word  0
ORI_RSLT:	.word  0
J_RSLT:		.word  0
BEQ_NT_RSLT:	.word  0
BEQ_T_RSLT:	.word  0
SLT0_RSLT:	.word  0
SLT1_RSLT:	.word  0
SLTI0_RSLT:	.word  0
SLTI1_RSLT:	.word  0
	
	.text
main:
	lw   $t1, A		#  lw のテスト
	lw   $t2, B		#  lw のテスト
	lw   $t3, C		#  lw のテスト
	sw   $t1, SW_RSLT		#  sw のテスト (期待結果 = 0x335e) 

	add  $t4, $t1, $t2		#  add のテスト 
	sw   $t4, ADD_RSLT	#  期待結果 = 0x407f
	
	sub  $t5, $t1, $t2         #  sub のテスト 
	sw   $t5, SUB_RSLT	#  期待結果 = 0x263d

	addi $t6, $t1, 0x100     #  addi のテスト 
	sw   $t6, ADDI_RSLT	#  期待結果 = 0x345e
	
	and  $t7, $t1, $t2        #  and のテスト 
	sw   $t7, AND_RSLT	#  期待結果 = 0x100

	or   $t8, $t1, $t2        #  or のテスト 
	sw   $t8, OR_RSLT	#  期待結果 = 0x3f7f
	
	andi $t9, $t1, 0x1ff     #  andi のテスト
	sw   $t9, ANDI_RSLT	#  期待結果 = 0x15e

	ori  $t4, $t1, 0x1ff	#  ori のテスト
	sw   $t4, ORI_RSLT	#  期待結果 = 0x33ff
	
	ori  $t5, $0, 1		#  j のテストのための初期設定
	j skip1
	ori  $t5, $0, 0
skip1:
	sw   $t5, J_RSLT	#  期待結果 = 1
		
	ori  $t5, $0, 1        	#  beq のテストのための初期設定
	ori  $t7, $0, 2        	#  beq のテストのための初期設定
	beq  $t5, $t7, skip2    #  beq のテスト (not taken)
	ori  $t7, $0, 3
skip2:		
	sw   $t7, BEQ_NT_RSLT	#  期待結果 = 3
	
	ori  $t7, $0, 1
	beq  $t5, $t7, skip3    #  beq のテスト (taken)
	ori  $t7, $0, 3
skip3:	
	sw   $t7, BEQ_T_RSLT	#  期待結果 = 1
	
	slt  $t8, $t1, $t2        #  slt のテスト
	sw   $t8, SLT0_RSLT	#  期待結果 = 0
	slt  $t9, $t2, $t1        #
	sw   $t9, SLT1_RSLT	#  期待結果 = 1
	
	slti $t4, $t1, 0x1000    #  slti のテスト
	sw   $t4, SLTI0_RSLT	#  期待結果 = 0
	slti $t5, $t1, 0x5000    #
	sw   $t5, SLTI1_RSLT   	#  期待結果 = 1
exit:
	j    exit
