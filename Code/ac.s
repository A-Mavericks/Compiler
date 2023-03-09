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

main:
  sw $ra, -4($sp)
  sw $fp, -8($sp)
  move $fp, $sp
  subu $sp, $sp, 92
  li $t0, 0
  sw $t0, -12($fp)
  lw $t0, -12($fp)
  sw $t0, -16($fp)
  li $t0, 1
  sw $t0, -20($fp)
  lw $t0, -20($fp)
  sw $t0, -24($fp)
  li $t0, 0
  sw $t0, -28($fp)
  lw $t0, -28($fp)
  sw $t0, -32($fp)
  jal read
  sw $v0, -36($fp)
  lw $t0, -36($fp)
  sw $t0, -40($fp)
label1:
  lw $t0, -32($fp)
  sw $t0, -44($fp)
  lw $t0, -40($fp)
  sw $t0, -48($fp)
  lw $t0, -44($fp)
  lw $t1, -48($fp)
  blt $t0, $t1, label2
  j label3
label2:
  lw $t0, -16($fp)
  sw $t0, -52($fp)
  lw $t0, -24($fp)
  sw $t0, -56($fp)
  lw $t0, -52($fp)
  lw $t1, -56($fp)
  add $t0, $t0, $t1
  sw $t0, -60($fp)
  lw $t0, -60($fp)
  sw $t0, -64($fp)
  lw $t0, -24($fp)
  sw $t0, -68($fp)
  lw $a0, -68($fp)
  jal write
  lw $t0, -24($fp)
  sw $t0, -72($fp)
  lw $t0, -72($fp)
  sw $t0, -16($fp)
  lw $t0, -64($fp)
  sw $t0, -76($fp)
  lw $t0, -76($fp)
  sw $t0, -24($fp)
  lw $t0, -32($fp)
  sw $t0, -80($fp)
  li $t0, 1
  sw $t0, -84($fp)
  lw $t0, -80($fp)
  lw $t1, -84($fp)
  add $t0, $t0, $t1
  sw $t0, -88($fp)
  lw $t0, -88($fp)
  sw $t0, -32($fp)
  j label1
label3:
  li $t0, 0
  sw $t0, -92($fp)
  lw $v0, -92($fp)
  lw $ra, -4($fp)
  lw $fp, -8($fp)
  addiu $sp, $sp, 92
  jr $ra
