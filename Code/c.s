FUNCTION dist :
PARAM v1
PARAM v2
PARAM v3
PARAM v4
t6 := v3
t7 := v1
t4 := t6 - t7
t8 := v3
t9 := v1
t5 := t8 - t9
t2 := t4 * t5
t12 := v4
t13 := v2
t10 := t12 - t13
t14 := v4
t15 := v2
t11 := t14 - t15
t3 := t10 * t11
t1 := t2 + t3
RETURN t1
RETURN #0
FUNCTION check :
PARAM v5
PARAM v6
PARAM v7
PARAM v8
PARAM v9
PARAM v10
PARAM v11
PARAM v12
t16 := #0
t22 := v8
t21 := v7
t20 := v6
t19 := v5
ARG t22
ARG t21
ARG t20
ARG t19
t17 := CALL dist
t18 := #0
IF t17 > t18 GOTO label6
GOTO label2
LABEL label6 :
t28 := v8
t27 := v7
t26 := v6
t25 := v5
ARG t28
ARG t27
ARG t26
ARG t25
t23 := CALL dist
t32 := v10
t31 := v9
t30 := v8
t29 := v7
ARG t32
ARG t31
ARG t30
ARG t29
t24 := CALL dist
IF t23 == t24 GOTO label5
GOTO label2
LABEL label5 :
t38 := v10
t37 := v9
t36 := v8
t35 := v7
ARG t38
ARG t37
ARG t36
ARG t35
t33 := CALL dist
t42 := v12
t41 := v11
t40 := v10
t39 := v9
ARG t42
ARG t41
ARG t40
ARG t39
t34 := CALL dist
IF t33 == t34 GOTO label4
GOTO label2
LABEL label4 :
t48 := v12
t47 := v11
t46 := v10
t45 := v9
ARG t48
ARG t47
ARG t46
ARG t45
t43 := CALL dist
t52 := v6
t51 := v5
t50 := v12
t49 := v11
ARG t52
ARG t51
ARG t50
ARG t49
t44 := CALL dist
IF t43 == t44 GOTO label3
GOTO label2
LABEL label3 :
t58 := v10
t57 := v9
t56 := v6
t55 := v5
ARG t58
ARG t57
ARG t56
ARG t55
t53 := CALL dist
t62 := v12
t61 := v11
t60 := v8
t59 := v7
ARG t62
ARG t61
ARG t60
ARG t59
t54 := CALL dist
IF t53 == t54 GOTO label1
GOTO label2
LABEL label1 :
t16 := #1
LABEL label2 :
RETURN t16
RETURN #0
FUNCTION main :
DEC v13 8
DEC v14 8
DEC v15 8
DEC v16 8
READ t64
t63 := &v13
t65 := #0
t65 := t65 * #4
t63 := t63 + t65
*t63 := t64
READ t67
t66 := &v13
t68 := #1
t68 := t68 * #4
t66 := t66 + t68
*t66 := t67
READ t70
t69 := &v14
t71 := #0
t71 := t71 * #4
t69 := t69 + t71
*t69 := t70
READ t73
t72 := &v14
t74 := #1
t74 := t74 * #4
t72 := t72 + t74
*t72 := t73
READ t76
t75 := &v15
t77 := #0
t77 := t77 * #4
t75 := t75 + t77
*t75 := t76
READ t79
t78 := &v15
t80 := #1
t80 := t80 * #4
t78 := t78 + t80
*t78 := t79
READ t82
t81 := &v16
t83 := #0
t83 := t83 * #4
t81 := t81 + t83
*t81 := t82
READ t85
t84 := &v16
t86 := #1
t86 := t86 * #4
t84 := t84 + t86
*t84 := t85
t95 := &v16
t96 := #1
t96 := t96 * #4
t95 := t95 + t96
t95 := *t95
t94 := &v16
t97 := #0
t97 := t97 * #4
t94 := t94 + t97
t94 := *t94
t93 := &v15
t98 := #1
t98 := t98 * #4
t93 := t93 + t98
t93 := *t93
t92 := &v15
t99 := #0
t99 := t99 * #4
t92 := t92 + t99
t92 := *t92
t91 := &v14
t100 := #1
t100 := t100 * #4
t91 := t91 + t100
t91 := *t91
t90 := &v14
t101 := #0
t101 := t101 * #4
t90 := t90 + t101
t90 := *t90
t89 := &v13
t102 := #1
t102 := t102 * #4
t89 := t89 + t102
t89 := *t89
t88 := &v13
t103 := #0
t103 := t103 * #4
t88 := t88 + t103
t88 := *t88
ARG t95
ARG t94
ARG t93
ARG t92
ARG t91
ARG t90
ARG t89
ARG t88
t87 := CALL check
v17 := t87
t112 := &v16
t113 := #1
t113 := t113 * #4
t112 := t112 + t113
t112 := *t112
t111 := &v16
t114 := #0
t114 := t114 * #4
t111 := t111 + t114
t111 := *t111
t110 := &v14
t115 := #1
t115 := t115 * #4
t110 := t110 + t115
t110 := *t110
t109 := &v14
t116 := #0
t116 := t116 * #4
t109 := t109 + t116
t109 := *t109
t108 := &v15
t117 := #1
t117 := t117 * #4
t108 := t108 + t117
t108 := *t108
t107 := &v15
t118 := #0
t118 := t118 * #4
t107 := t107 + t118
t107 := *t107
t106 := &v13
t119 := #1
t119 := t119 * #4
t106 := t106 + t119
t106 := *t106
t105 := &v13
t120 := #0
t120 := t120 * #4
t105 := t105 + t120
t105 := *t105
ARG t112
ARG t111
ARG t110
ARG t109
ARG t108
ARG t107
ARG t106
ARG t105
t104 := CALL check
v18 := t104
t129 := &v15
t130 := #1
t130 := t130 * #4
t129 := t129 + t130
t129 := *t129
t128 := &v15
t131 := #0
t131 := t131 * #4
t128 := t128 + t131
t128 := *t128
t127 := &v16
t132 := #1
t132 := t132 * #4
t127 := t127 + t132
t127 := *t127
t126 := &v16
t133 := #0
t133 := t133 * #4
t126 := t126 + t133
t126 := *t126
t125 := &v14
t134 := #1
t134 := t134 * #4
t125 := t125 + t134
t125 := *t125
t124 := &v14
t135 := #0
t135 := t135 * #4
t124 := t124 + t135
t124 := *t124
t123 := &v13
t136 := #1
t136 := t136 * #4
t123 := t123 + t136
t123 := *t123
t122 := &v13
t137 := #0
t137 := t137 * #4
t122 := t122 + t137
t122 := *t122
ARG t129
ARG t128
ARG t127
ARG t126
ARG t125
ARG t124
ARG t123
ARG t122
t121 := CALL check
v19 := t121
t139 := #0
t140 := v17
IF t140 != #0 GOTO label7
GOTO label10
LABEL label10 :
t141 := v18
IF t141 != #0 GOTO label7
GOTO label9
LABEL label9 :
t142 := v19
IF t142 != #0 GOTO label7
GOTO label8
LABEL label7 :
t139 := #1
LABEL label8 :
WRITE t139
t143 := #0
RETURN t143
RETURN #0
.data
_prompt: .asciiz "Enter an integer:"
_ret: .asciiz "\n"
.globl main
.text
read:
  li $v0, 4
  la $a0, _prompt
  syscall
  li $v0, 5
  syscall
  jr $ra

write:
  li $v0, 1
  syscall
  li $v0, 4
  la $a0, _ret
  syscall
  jr $ra

function_wrap_dist:
  sw $ra, -4($sp)
  sw $fp, -8($sp)
  move $fp, $sp
  subu $sp, $sp, 68
  lw $t0, 8($fp)
  sw $t0, -12($fp)
  lw $t0, 0($fp)
  sw $t0, -16($fp)
  lw $t0, -12($fp)
  lw $t1, -16($fp)
  sub $t0, $t0, $t1
  sw $t0, -20($fp)
  lw $t0, 8($fp)
  sw $t0, -24($fp)
  lw $t0, 0($fp)
  sw $t0, -28($fp)
  lw $t0, -24($fp)
  lw $t1, -28($fp)
  sub $t0, $t0, $t1
  sw $t0, -32($fp)
  lw $t0, -20($fp)
  lw $t1, -32($fp)
  mul $t0, $t0, $t1
  sw $t0, -36($fp)
  lw $t0, 12($fp)
  sw $t0, -40($fp)
  lw $t0, 4($fp)
  sw $t0, -44($fp)
  lw $t0, -40($fp)
  lw $t1, -44($fp)
  sub $t0, $t0, $t1
  sw $t0, -48($fp)
  lw $t0, 12($fp)
  sw $t0, -52($fp)
  lw $t0, 4($fp)
  sw $t0, -56($fp)
  lw $t0, -52($fp)
  lw $t1, -56($fp)
  sub $t0, $t0, $t1
  sw $t0, -60($fp)
  lw $t0, -48($fp)
  lw $t1, -60($fp)
  mul $t0, $t0, $t1
  sw $t0, -64($fp)
  lw $t0, -36($fp)
  lw $t1, -64($fp)
  add $t0, $t0, $t1
  sw $t0, -68($fp)
  lw $v0, -68($fp)
  lw $ra, -4($fp)
  lw $fp, -8($fp)
  addiu $sp, $sp, 68
  jr $ra
  li $v0, 0
  lw $ra, -4($fp)
  lw $fp, -8($fp)
  addiu $sp, $sp, 68
  jr $ra

function_wrap_check:
  sw $ra, -4($sp)
  sw $fp, -8($sp)
  move $fp, $sp
  subu $sp, $sp, 196
  li $t0, 0
  sw $t0, -12($fp)
  lw $t0, 12($fp)
  sw $t0, -16($fp)
  lw $t0, 8($fp)
  sw $t0, -20($fp)
  lw $t0, 4($fp)
  sw $t0, -24($fp)
  lw $t0, 0($fp)
  sw $t0, -28($fp)
  lw $t0, -16($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -20($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -24($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -28($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  jal function_wrap_dist
  sw $v0, -32($fp)
  addiu $sp, $sp, 16
  li $t0, 0
  sw $t0, -36($fp)
  lw $t0, -32($fp)
  lw $t1, -36($fp)
  bgt $t0, $t1, label6
  j label2
label6:
  lw $t0, 12($fp)
  sw $t0, -40($fp)
  lw $t0, 8($fp)
  sw $t0, -44($fp)
  lw $t0, 4($fp)
  sw $t0, -48($fp)
  lw $t0, 0($fp)
  sw $t0, -52($fp)
  lw $t0, -40($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -44($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -48($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -52($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  jal function_wrap_dist
  sw $v0, -56($fp)
  addiu $sp, $sp, 16
  lw $t0, 20($fp)
  sw $t0, -60($fp)
  lw $t0, 16($fp)
  sw $t0, -64($fp)
  lw $t0, 12($fp)
  sw $t0, -68($fp)
  lw $t0, 8($fp)
  sw $t0, -72($fp)
  lw $t0, -60($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -64($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -68($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -72($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  jal function_wrap_dist
  sw $v0, -76($fp)
  addiu $sp, $sp, 16
  lw $t0, -56($fp)
  lw $t1, -76($fp)
  beq $t0, $t1, label5
  j label2
label5:
  lw $t0, 20($fp)
  sw $t0, -80($fp)
  lw $t0, 16($fp)
  sw $t0, -84($fp)
  lw $t0, 12($fp)
  sw $t0, -88($fp)
  lw $t0, 8($fp)
  sw $t0, -92($fp)
  lw $t0, -80($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -84($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -88($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -92($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  jal function_wrap_dist
  sw $v0, -96($fp)
  addiu $sp, $sp, 16
  lw $t0, 28($fp)
  sw $t0, -100($fp)
  lw $t0, 24($fp)
  sw $t0, -104($fp)
  lw $t0, 20($fp)
  sw $t0, -108($fp)
  lw $t0, 16($fp)
  sw $t0, -112($fp)
  lw $t0, -100($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -104($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -108($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -112($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  jal function_wrap_dist
  sw $v0, -116($fp)
  addiu $sp, $sp, 16
  lw $t0, -96($fp)
  lw $t1, -116($fp)
  beq $t0, $t1, label4
  j label2
label4:
  lw $t0, 28($fp)
  sw $t0, -120($fp)
  lw $t0, 24($fp)
  sw $t0, -124($fp)
  lw $t0, 20($fp)
  sw $t0, -128($fp)
  lw $t0, 16($fp)
  sw $t0, -132($fp)
  lw $t0, -120($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -124($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -128($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -132($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  jal function_wrap_dist
  sw $v0, -136($fp)
  addiu $sp, $sp, 16
  lw $t0, 4($fp)
  sw $t0, -140($fp)
  lw $t0, 0($fp)
  sw $t0, -144($fp)
  lw $t0, 28($fp)
  sw $t0, -148($fp)
  lw $t0, 24($fp)
  sw $t0, -152($fp)
  lw $t0, -140($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -144($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -148($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -152($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  jal function_wrap_dist
  sw $v0, -156($fp)
  addiu $sp, $sp, 16
  lw $t0, -136($fp)
  lw $t1, -156($fp)
  beq $t0, $t1, label3
  j label2
label3:
  lw $t0, 20($fp)
  sw $t0, -160($fp)
  lw $t0, 16($fp)
  sw $t0, -164($fp)
  lw $t0, 4($fp)
  sw $t0, -168($fp)
  lw $t0, 0($fp)
  sw $t0, -172($fp)
  lw $t0, -160($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -164($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -168($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -172($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  jal function_wrap_dist
  sw $v0, -176($fp)
  addiu $sp, $sp, 16
  lw $t0, 28($fp)
  sw $t0, -180($fp)
  lw $t0, 24($fp)
  sw $t0, -184($fp)
  lw $t0, 12($fp)
  sw $t0, -188($fp)
  lw $t0, 8($fp)
  sw $t0, -192($fp)
  lw $t0, -180($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -184($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -188($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -192($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  jal function_wrap_dist
  sw $v0, -196($fp)
  addiu $sp, $sp, 16
  lw $t0, -176($fp)
  lw $t1, -196($fp)
  beq $t0, $t1, label1
  j label2
label1:
  li $t0, 1
  sw $t0, -12($fp)
label2:
  lw $v0, -12($fp)
  lw $ra, -4($fp)
  lw $fp, -8($fp)
  addiu $sp, $sp, 196
  jr $ra
  li $v0, 0
  lw $ra, -4($fp)
  lw $fp, -8($fp)
  addiu $sp, $sp, 196
  jr $ra

main:
  sw $ra, -4($sp)
  sw $fp, -8($sp)
  move $fp, $sp
  subu $sp, $sp, 372
  jal read
  sw $v0, -44($fp)
  la $t0, -16($fp)
  sw $t0, -48($fp)
  li $t0, 0
  sw $t0, -52($fp)
  lw $t0, -52($fp)
  li $t1, 4
  mul $t0, $t0, $t1
  sw $t0, -52($fp)
  lw $t0, -48($fp)
  lw $t1, -52($fp)
  add $t0, $t0, $t1
  sw $t0, -48($fp)
  lw $t0, -44($fp)
  lw $t1, -48($fp)
  sw $t0, 0($t1)
  jal read
  sw $v0, -56($fp)
  la $t0, -16($fp)
  sw $t0, -60($fp)
  li $t0, 1
  sw $t0, -64($fp)
  lw $t0, -64($fp)
  li $t1, 4
  mul $t0, $t0, $t1
  sw $t0, -64($fp)
  lw $t0, -60($fp)
  lw $t1, -64($fp)
  add $t0, $t0, $t1
  sw $t0, -60($fp)
  lw $t0, -56($fp)
  lw $t1, -60($fp)
  sw $t0, 0($t1)
  jal read
  sw $v0, -68($fp)
  la $t0, -24($fp)
  sw $t0, -72($fp)
  li $t0, 0
  sw $t0, -76($fp)
  lw $t0, -76($fp)
  li $t1, 4
  mul $t0, $t0, $t1
  sw $t0, -76($fp)
  lw $t0, -72($fp)
  lw $t1, -76($fp)
  add $t0, $t0, $t1
  sw $t0, -72($fp)
  lw $t0, -68($fp)
  lw $t1, -72($fp)
  sw $t0, 0($t1)
  jal read
  sw $v0, -80($fp)
  la $t0, -24($fp)
  sw $t0, -84($fp)
  li $t0, 1
  sw $t0, -88($fp)
  lw $t0, -88($fp)
  li $t1, 4
  mul $t0, $t0, $t1
  sw $t0, -88($fp)
  lw $t0, -84($fp)
  lw $t1, -88($fp)
  add $t0, $t0, $t1
  sw $t0, -84($fp)
  lw $t0, -80($fp)
  lw $t1, -84($fp)
  sw $t0, 0($t1)
  jal read
  sw $v0, -92($fp)
  la $t0, -32($fp)
  sw $t0, -96($fp)
  li $t0, 0
  sw $t0, -100($fp)
  lw $t0, -100($fp)
  li $t1, 4
  mul $t0, $t0, $t1
  sw $t0, -100($fp)
  lw $t0, -96($fp)
  lw $t1, -100($fp)
  add $t0, $t0, $t1
  sw $t0, -96($fp)
  lw $t0, -92($fp)
  lw $t1, -96($fp)
  sw $t0, 0($t1)
  jal read
  sw $v0, -104($fp)
  la $t0, -32($fp)
  sw $t0, -108($fp)
  li $t0, 1
  sw $t0, -112($fp)
  lw $t0, -112($fp)
  li $t1, 4
  mul $t0, $t0, $t1
  sw $t0, -112($fp)
  lw $t0, -108($fp)
  lw $t1, -112($fp)
  add $t0, $t0, $t1
  sw $t0, -108($fp)
  lw $t0, -104($fp)
  lw $t1, -108($fp)
  sw $t0, 0($t1)
  jal read
  sw $v0, -116($fp)
  la $t0, -40($fp)
  sw $t0, -120($fp)
  li $t0, 0
  sw $t0, -124($fp)
  lw $t0, -124($fp)
  li $t1, 4
  mul $t0, $t0, $t1
  sw $t0, -124($fp)
  lw $t0, -120($fp)
  lw $t1, -124($fp)
  add $t0, $t0, $t1
  sw $t0, -120($fp)
  lw $t0, -116($fp)
  lw $t1, -120($fp)
  sw $t0, 0($t1)
  jal read
  sw $v0, -128($fp)
  la $t0, -40($fp)
  sw $t0, -132($fp)
  li $t0, 1
  sw $t0, -136($fp)
  lw $t0, -136($fp)
  li $t1, 4
  mul $t0, $t0, $t1
  sw $t0, -136($fp)
  lw $t0, -132($fp)
  lw $t1, -136($fp)
  add $t0, $t0, $t1
  sw $t0, -132($fp)
  lw $t0, -128($fp)
  lw $t1, -132($fp)
  sw $t0, 0($t1)
  la $t0, -40($fp)
  sw $t0, -140($fp)
  li $t0, 1
  sw $t0, -144($fp)
  lw $t0, -144($fp)
  li $t1, 4
  mul $t0, $t0, $t1
  sw $t0, -144($fp)
  lw $t0, -140($fp)
  lw $t1, -144($fp)
  add $t0, $t0, $t1
  sw $t0, -140($fp)
  lw $t0, -140($fp)
  lw $t1, 0($t0)
  sw $t1, -140($fp)
  la $t0, -40($fp)
  sw $t0, -148($fp)
  li $t0, 0
  sw $t0, -152($fp)
  lw $t0, -152($fp)
  li $t1, 4
  mul $t0, $t0, $t1
  sw $t0, -152($fp)
  lw $t0, -148($fp)
  lw $t1, -152($fp)
  add $t0, $t0, $t1
  sw $t0, -148($fp)
  lw $t0, -148($fp)
  lw $t1, 0($t0)
  sw $t1, -148($fp)
  la $t0, -32($fp)
  sw $t0, -156($fp)
  li $t0, 1
  sw $t0, -160($fp)
  lw $t0, -160($fp)
  li $t1, 4
  mul $t0, $t0, $t1
  sw $t0, -160($fp)
  lw $t0, -156($fp)
  lw $t1, -160($fp)
  add $t0, $t0, $t1
  sw $t0, -156($fp)
  lw $t0, -156($fp)
  lw $t1, 0($t0)
  sw $t1, -156($fp)
  la $t0, -32($fp)
  sw $t0, -164($fp)
  li $t0, 0
  sw $t0, -168($fp)
  lw $t0, -168($fp)
  li $t1, 4
  mul $t0, $t0, $t1
  sw $t0, -168($fp)
  lw $t0, -164($fp)
  lw $t1, -168($fp)
  add $t0, $t0, $t1
  sw $t0, -164($fp)
  lw $t0, -164($fp)
  lw $t1, 0($t0)
  sw $t1, -164($fp)
  la $t0, -24($fp)
  sw $t0, -172($fp)
  li $t0, 1
  sw $t0, -176($fp)
  lw $t0, -176($fp)
  li $t1, 4
  mul $t0, $t0, $t1
  sw $t0, -176($fp)
  lw $t0, -172($fp)
  lw $t1, -176($fp)
  add $t0, $t0, $t1
  sw $t0, -172($fp)
  lw $t0, -172($fp)
  lw $t1, 0($t0)
  sw $t1, -172($fp)
  la $t0, -24($fp)
  sw $t0, -180($fp)
  li $t0, 0
  sw $t0, -184($fp)
  lw $t0, -184($fp)
  li $t1, 4
  mul $t0, $t0, $t1
  sw $t0, -184($fp)
  lw $t0, -180($fp)
  lw $t1, -184($fp)
  add $t0, $t0, $t1
  sw $t0, -180($fp)
  lw $t0, -180($fp)
  lw $t1, 0($t0)
  sw $t1, -180($fp)
  la $t0, -16($fp)
  sw $t0, -188($fp)
  li $t0, 1
  sw $t0, -192($fp)
  lw $t0, -192($fp)
  li $t1, 4
  mul $t0, $t0, $t1
  sw $t0, -192($fp)
  lw $t0, -188($fp)
  lw $t1, -192($fp)
  add $t0, $t0, $t1
  sw $t0, -188($fp)
  lw $t0, -188($fp)
  lw $t1, 0($t0)
  sw $t1, -188($fp)
  la $t0, -16($fp)
  sw $t0, -196($fp)
  li $t0, 0
  sw $t0, -200($fp)
  lw $t0, -200($fp)
  li $t1, 4
  mul $t0, $t0, $t1
  sw $t0, -200($fp)
  lw $t0, -196($fp)
  lw $t1, -200($fp)
  add $t0, $t0, $t1
  sw $t0, -196($fp)
  lw $t0, -196($fp)
  lw $t1, 0($t0)
  sw $t1, -196($fp)
  lw $t0, -140($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -148($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -156($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -164($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -172($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -180($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -188($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -196($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  jal function_wrap_check
  sw $v0, -204($fp)
  addiu $sp, $sp, 32
  lw $t0, -204($fp)
  sw $t0, -208($fp)
  la $t0, -40($fp)
  sw $t0, -212($fp)
  li $t0, 1
  sw $t0, -216($fp)
  lw $t0, -216($fp)
  li $t1, 4
  mul $t0, $t0, $t1
  sw $t0, -216($fp)
  lw $t0, -212($fp)
  lw $t1, -216($fp)
  add $t0, $t0, $t1
  sw $t0, -212($fp)
  lw $t0, -212($fp)
  lw $t1, 0($t0)
  sw $t1, -212($fp)
  la $t0, -40($fp)
  sw $t0, -220($fp)
  li $t0, 0
  sw $t0, -224($fp)
  lw $t0, -224($fp)
  li $t1, 4
  mul $t0, $t0, $t1
  sw $t0, -224($fp)
  lw $t0, -220($fp)
  lw $t1, -224($fp)
  add $t0, $t0, $t1
  sw $t0, -220($fp)
  lw $t0, -220($fp)
  lw $t1, 0($t0)
  sw $t1, -220($fp)
  la $t0, -24($fp)
  sw $t0, -228($fp)
  li $t0, 1
  sw $t0, -232($fp)
  lw $t0, -232($fp)
  li $t1, 4
  mul $t0, $t0, $t1
  sw $t0, -232($fp)
  lw $t0, -228($fp)
  lw $t1, -232($fp)
  add $t0, $t0, $t1
  sw $t0, -228($fp)
  lw $t0, -228($fp)
  lw $t1, 0($t0)
  sw $t1, -228($fp)
  la $t0, -24($fp)
  sw $t0, -236($fp)
  li $t0, 0
  sw $t0, -240($fp)
  lw $t0, -240($fp)
  li $t1, 4
  mul $t0, $t0, $t1
  sw $t0, -240($fp)
  lw $t0, -236($fp)
  lw $t1, -240($fp)
  add $t0, $t0, $t1
  sw $t0, -236($fp)
  lw $t0, -236($fp)
  lw $t1, 0($t0)
  sw $t1, -236($fp)
  la $t0, -32($fp)
  sw $t0, -244($fp)
  li $t0, 1
  sw $t0, -248($fp)
  lw $t0, -248($fp)
  li $t1, 4
  mul $t0, $t0, $t1
  sw $t0, -248($fp)
  lw $t0, -244($fp)
  lw $t1, -248($fp)
  add $t0, $t0, $t1
  sw $t0, -244($fp)
  lw $t0, -244($fp)
  lw $t1, 0($t0)
  sw $t1, -244($fp)
  la $t0, -32($fp)
  sw $t0, -252($fp)
  li $t0, 0
  sw $t0, -256($fp)
  lw $t0, -256($fp)
  li $t1, 4
  mul $t0, $t0, $t1
  sw $t0, -256($fp)
  lw $t0, -252($fp)
  lw $t1, -256($fp)
  add $t0, $t0, $t1
  sw $t0, -252($fp)
  lw $t0, -252($fp)
  lw $t1, 0($t0)
  sw $t1, -252($fp)
  la $t0, -16($fp)
  sw $t0, -260($fp)
  li $t0, 1
  sw $t0, -264($fp)
  lw $t0, -264($fp)
  li $t1, 4
  mul $t0, $t0, $t1
  sw $t0, -264($fp)
  lw $t0, -260($fp)
  lw $t1, -264($fp)
  add $t0, $t0, $t1
  sw $t0, -260($fp)
  lw $t0, -260($fp)
  lw $t1, 0($t0)
  sw $t1, -260($fp)
  la $t0, -16($fp)
  sw $t0, -268($fp)
  li $t0, 0
  sw $t0, -272($fp)
  lw $t0, -272($fp)
  li $t1, 4
  mul $t0, $t0, $t1
  sw $t0, -272($fp)
  lw $t0, -268($fp)
  lw $t1, -272($fp)
  add $t0, $t0, $t1
  sw $t0, -268($fp)
  lw $t0, -268($fp)
  lw $t1, 0($t0)
  sw $t1, -268($fp)
  lw $t0, -212($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -220($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -228($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -236($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -244($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -252($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -260($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -268($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  jal function_wrap_check
  sw $v0, -276($fp)
  addiu $sp, $sp, 32
  lw $t0, -276($fp)
  sw $t0, -280($fp)
  la $t0, -32($fp)
  sw $t0, -284($fp)
  li $t0, 1
  sw $t0, -288($fp)
  lw $t0, -288($fp)
  li $t1, 4
  mul $t0, $t0, $t1
  sw $t0, -288($fp)
  lw $t0, -284($fp)
  lw $t1, -288($fp)
  add $t0, $t0, $t1
  sw $t0, -284($fp)
  lw $t0, -284($fp)
  lw $t1, 0($t0)
  sw $t1, -284($fp)
  la $t0, -32($fp)
  sw $t0, -292($fp)
  li $t0, 0
  sw $t0, -296($fp)
  lw $t0, -296($fp)
  li $t1, 4
  mul $t0, $t0, $t1
  sw $t0, -296($fp)
  lw $t0, -292($fp)
  lw $t1, -296($fp)
  add $t0, $t0, $t1
  sw $t0, -292($fp)
  lw $t0, -292($fp)
  lw $t1, 0($t0)
  sw $t1, -292($fp)
  la $t0, -40($fp)
  sw $t0, -300($fp)
  li $t0, 1
  sw $t0, -304($fp)
  lw $t0, -304($fp)
  li $t1, 4
  mul $t0, $t0, $t1
  sw $t0, -304($fp)
  lw $t0, -300($fp)
  lw $t1, -304($fp)
  add $t0, $t0, $t1
  sw $t0, -300($fp)
  lw $t0, -300($fp)
  lw $t1, 0($t0)
  sw $t1, -300($fp)
  la $t0, -40($fp)
  sw $t0, -308($fp)
  li $t0, 0
  sw $t0, -312($fp)
  lw $t0, -312($fp)
  li $t1, 4
  mul $t0, $t0, $t1
  sw $t0, -312($fp)
  lw $t0, -308($fp)
  lw $t1, -312($fp)
  add $t0, $t0, $t1
  sw $t0, -308($fp)
  lw $t0, -308($fp)
  lw $t1, 0($t0)
  sw $t1, -308($fp)
  la $t0, -24($fp)
  sw $t0, -316($fp)
  li $t0, 1
  sw $t0, -320($fp)
  lw $t0, -320($fp)
  li $t1, 4
  mul $t0, $t0, $t1
  sw $t0, -320($fp)
  lw $t0, -316($fp)
  lw $t1, -320($fp)
  add $t0, $t0, $t1
  sw $t0, -316($fp)
  lw $t0, -316($fp)
  lw $t1, 0($t0)
  sw $t1, -316($fp)
  la $t0, -24($fp)
  sw $t0, -324($fp)
  li $t0, 0
  sw $t0, -328($fp)
  lw $t0, -328($fp)
  li $t1, 4
  mul $t0, $t0, $t1
  sw $t0, -328($fp)
  lw $t0, -324($fp)
  lw $t1, -328($fp)
  add $t0, $t0, $t1
  sw $t0, -324($fp)
  lw $t0, -324($fp)
  lw $t1, 0($t0)
  sw $t1, -324($fp)
  la $t0, -16($fp)
  sw $t0, -332($fp)
  li $t0, 1
  sw $t0, -336($fp)
  lw $t0, -336($fp)
  li $t1, 4
  mul $t0, $t0, $t1
  sw $t0, -336($fp)
  lw $t0, -332($fp)
  lw $t1, -336($fp)
  add $t0, $t0, $t1
  sw $t0, -332($fp)
  lw $t0, -332($fp)
  lw $t1, 0($t0)
  sw $t1, -332($fp)
  la $t0, -16($fp)
  sw $t0, -340($fp)
  li $t0, 0
  sw $t0, -344($fp)
  lw $t0, -344($fp)
  li $t1, 4
  mul $t0, $t0, $t1
  sw $t0, -344($fp)
  lw $t0, -340($fp)
  lw $t1, -344($fp)
  add $t0, $t0, $t1
  sw $t0, -340($fp)
  lw $t0, -340($fp)
  lw $t1, 0($t0)
  sw $t1, -340($fp)
  lw $t0, -284($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -292($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -300($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -308($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -316($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -324($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -332($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -340($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  jal function_wrap_check
  sw $v0, -348($fp)
  addiu $sp, $sp, 32
  lw $t0, -348($fp)
  sw $t0, -352($fp)
  li $t0, 0
  sw $t0, -356($fp)
  lw $t0, -208($fp)
  sw $t0, -360($fp)
  lw $t0, -360($fp)
  li $t1, 0
  bne $t0, $t1, label7
  j label10
label10:
  lw $t0, -280($fp)
  sw $t0, -364($fp)
  lw $t0, -364($fp)
  li $t1, 0
  bne $t0, $t1, label7
  j label9
label9:
  lw $t0, -352($fp)
  sw $t0, -368($fp)
  lw $t0, -368($fp)
  li $t1, 0
  bne $t0, $t1, label7
  j label8
label7:
  li $t0, 1
  sw $t0, -356($fp)
label8:
  lw $a0, -356($fp)
  jal write
  li $t0, 0
  sw $t0, -372($fp)
  lw $v0, -372($fp)
  lw $ra, -4($fp)
  lw $fp, -8($fp)
  addiu $sp, $sp, 372
  jr $ra
  li $v0, 0
  lw $ra, -4($fp)
  lw $fp, -8($fp)
  addiu $sp, $sp, 372
  jr $ra
