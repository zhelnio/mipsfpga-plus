	.file	1 "main.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	softfloat
	.module	oddspreg
	.text
	.align	2
	.globl	main
	.set	nomips16
	.set	nomicromips
	.ent	main
	.type	main, @function
main:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	move	$2,$0
	move	$5,$0
	li	$3,-1082130432			# 0xffffffffbf800000
.L2:
	sll	$6,$5,24
	srl	$4,$2,8
	or	$4,$6,$4
	sw	$4,0($3)
	lw	$4,0($3)
	sw	$4,4($3)
	sw	$2,16($3)
	addiu	$4,$2,1
	sltu	$6,$4,$2
	move	$2,$4
	b	.L2
	addu	$5,$6,$5

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main
	.ident	"GCC: (Codescape GNU Tools 2017.10-05 for MIPS MTI Bare Metal) 6.3.0"
