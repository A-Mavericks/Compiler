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

function_dist:
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
function_check:
  sw $ra, -4($sp)
  sw $fp, -8($sp)
  move $fp, $sp
  subu $sp, $sp, 196
  li $t0, 0
  sw $t0, -12($fp)
  lw $t0, 0($fp)
  sw $t0, -16($fp)
  lw $t0, 4($fp)
  sw $t0, -20($fp)
  lw $t0, 8($fp)
  sw $t0, -24($fp)
  lw $t0, 12($fp)
  sw $t0, -28($fp)
  lw $t0, -28($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -24($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -20($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -16($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  jal function_dist
  sw $v0, -32($fp)
  addiu $sp, $sp, 16
  li $t0, 0
  sw $t0, -36($fp)
  lw $t0, -32($fp)
  lw $t1, -36($fp)
  bgt $t0, $t1, label6
  j label2
label6:
  lw $t0, 0($fp)
  sw $t0, -40($fp)
  lw $t0, 4($fp)
  sw $t0, -44($fp)
  lw $t0, 8($fp)
  sw $t0, -48($fp)
  lw $t0, 12($fp)
  sw $t0, -52($fp)
  lw $t0, -52($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -48($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -44($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -40($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  jal function_dist
  sw $v0, -56($fp)
  addiu $sp, $sp, 16
  lw $t0, 8($fp)
  sw $t0, -60($fp)
  lw $t0, 12($fp)
  sw $t0, -64($fp)
  lw $t0, 16($fp)
  sw $t0, -68($fp)
  lw $t0, 20($fp)
  sw $t0, -72($fp)
  lw $t0, -72($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -68($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -64($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -60($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  jal function_dist
  sw $v0, -76($fp)
  addiu $sp, $sp, 16
  lw $t0, -56($fp)
  lw $t1, -76($fp)
  beq $t0, $t1, label5
  j label2
label5:
  lw $t0, 8($fp)
  sw $t0, -80($fp)
  lw $t0, 12($fp)
  sw $t0, -84($fp)
  lw $t0, 16($fp)
  sw $t0, -88($fp)
  lw $t0, 20($fp)
  sw $t0, -92($fp)
  lw $t0, -92($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -88($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -84($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -80($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  jal function_dist
  sw $v0, -96($fp)
  addiu $sp, $sp, 16
  lw $t0, 16($fp)
  sw $t0, -100($fp)
  lw $t0, 20($fp)
  sw $t0, -104($fp)
  lw $t0, 24($fp)
  sw $t0, -108($fp)
  lw $t0, 28($fp)
  sw $t0, -112($fp)
  lw $t0, -112($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -108($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -104($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -100($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  jal function_dist
  sw $v0, -116($fp)
  addiu $sp, $sp, 16
  lw $t0, -96($fp)
  lw $t1, -116($fp)
  beq $t0, $t1, label4
  j label2
label4:
  lw $t0, 16($fp)
  sw $t0, -120($fp)
  lw $t0, 20($fp)
  sw $t0, -124($fp)
  lw $t0, 24($fp)
  sw $t0, -128($fp)
  lw $t0, 28($fp)
  sw $t0, -132($fp)
  lw $t0, -132($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -128($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -124($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -120($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  jal function_dist
  sw $v0, -136($fp)
  addiu $sp, $sp, 16
  lw $t0, 24($fp)
  sw $t0, -140($fp)
  lw $t0, 28($fp)
  sw $t0, -144($fp)
  lw $t0, 0($fp)
  sw $t0, -148($fp)
  lw $t0, 4($fp)
  sw $t0, -152($fp)
  lw $t0, -152($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -148($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -144($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -140($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  jal function_dist
  sw $v0, -156($fp)
  addiu $sp, $sp, 16
  lw $t0, -136($fp)
  lw $t1, -156($fp)
  beq $t0, $t1, label3
  j label2
label3:
  lw $t0, 0($fp)
  sw $t0, -160($fp)
  lw $t0, 4($fp)
  sw $t0, -164($fp)
  lw $t0, 16($fp)
  sw $t0, -168($fp)
  lw $t0, 20($fp)
  sw $t0, -172($fp)
  lw $t0, -172($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -168($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -164($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -160($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  jal function_dist
  sw $v0, -176($fp)
  addiu $sp, $sp, 16
  lw $t0, 8($fp)
  sw $t0, -180($fp)
  lw $t0, 12($fp)
  sw $t0, -184($fp)
  lw $t0, 24($fp)
  sw $t0, -188($fp)
  lw $t0, 28($fp)
  sw $t0, -192($fp)
  lw $t0, -192($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -188($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -184($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -180($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  jal function_dist
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
  la $t0, -16($fp)
  sw $t0, -140($fp)
  li $t0, 0
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
  la $t0, -16($fp)
  sw $t0, -148($fp)
  li $t0, 1
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
  la $t0, -24($fp)
  sw $t0, -156($fp)
  li $t0, 0
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
  la $t0, -24($fp)
  sw $t0, -164($fp)
  li $t0, 1
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
  la $t0, -32($fp)
  sw $t0, -172($fp)
  li $t0, 0
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
  la $t0, -32($fp)
  sw $t0, -180($fp)
  li $t0, 1
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
  la $t0, -40($fp)
  sw $t0, -188($fp)
  li $t0, 0
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
  la $t0, -40($fp)
  sw $t0, -196($fp)
  li $t0, 1
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
  lw $t0, -196($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -188($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -180($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -172($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -164($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -156($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -148($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -140($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  jal function_check
  sw $v0, -204($fp)
  addiu $sp, $sp, 32
  lw $t0, -204($fp)
  sw $t0, -208($fp)
  la $t0, -16($fp)
  sw $t0, -212($fp)
  li $t0, 0
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
  la $t0, -16($fp)
  sw $t0, -220($fp)
  li $t0, 1
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
  la $t0, -32($fp)
  sw $t0, -228($fp)
  li $t0, 0
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
  la $t0, -32($fp)
  sw $t0, -236($fp)
  li $t0, 1
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
  la $t0, -24($fp)
  sw $t0, -244($fp)
  li $t0, 0
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
  la $t0, -24($fp)
  sw $t0, -252($fp)
  li $t0, 1
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
  la $t0, -40($fp)
  sw $t0, -260($fp)
  li $t0, 0
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
  la $t0, -40($fp)
  sw $t0, -268($fp)
  li $t0, 1
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
  lw $t0, -268($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -260($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -252($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -244($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -236($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -228($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -220($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -212($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  jal function_check
  sw $v0, -276($fp)
  addiu $sp, $sp, 32
  lw $t0, -276($fp)
  sw $t0, -280($fp)
  la $t0, -16($fp)
  sw $t0, -284($fp)
  li $t0, 0
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
  la $t0, -16($fp)
  sw $t0, -292($fp)
  li $t0, 1
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
  la $t0, -24($fp)
  sw $t0, -300($fp)
  li $t0, 0
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
  la $t0, -24($fp)
  sw $t0, -308($fp)
  li $t0, 1
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
  la $t0, -40($fp)
  sw $t0, -316($fp)
  li $t0, 0
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
  la $t0, -40($fp)
  sw $t0, -324($fp)
  li $t0, 1
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
  la $t0, -32($fp)
  sw $t0, -332($fp)
  li $t0, 0
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
  la $t0, -32($fp)
  sw $t0, -340($fp)
  li $t0, 1
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
  lw $t0, -340($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -332($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -324($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -316($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -308($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -300($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -292($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  lw $t0, -284($fp)
  addiu $sp, $sp, -4
  sw $t0, 0($sp)
  jal function_check
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
