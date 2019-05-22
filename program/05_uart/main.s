	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	softfloat
	.module	oddspreg
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.align	2
	.globl	uartInit
.LFB0 = .
	.file 1 "main.c"
	.loc 1 27 0
	.cfi_startproc
	.set	nomips16
	.set	nomicromips
	.ent	uartInit
	.type	uartInit, @function
uartInit:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
.LVL0 = .
	.loc 1 28 0
	li	$2,-1337982976			# 0xffffffffb0400000
	li	$3,3			# 0x3
	sw	$3,4108($2)
	.loc 1 29 0
	lw	$3,4108($2)
	ori	$3,$3,0x80
	sw	$3,4108($2)
	.loc 1 30 0
	andi	$3,$4,0x00ff
	sw	$3,4096($2)
	.loc 1 31 0
	srl	$4,$4,8
.LVL1 = .
	sw	$4,4100($2)
	.loc 1 32 0
	lw	$3,4108($2)
	ins	$3,$0,7,1
	sw	$3,4108($2)
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	uartInit
	.cfi_endproc
.LFE0:
	.size	uartInit, .-uartInit
	.align	2
	.globl	uartTransmit
.LFB1 = .
	.loc 1 36 0
	.cfi_startproc
	.set	nomips16
	.set	nomicromips
	.ent	uartTransmit
	.type	uartTransmit, @function
uartTransmit:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
.LVL2 = .
	.loc 1 38 0
	li	$3,-1337982976			# 0xffffffffb0400000
.L3:
	.loc 1 38 0 is_stmt 0 discriminator 1
	lw	$2,4116($3)
	andi	$2,$2,0x20
	beq	$2,$0,.L3
	li	$2,-1337982976			# 0xffffffffb0400000

	.loc 1 41 0 is_stmt 1
	sw	$4,4096($2)
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	uartTransmit
	.cfi_endproc
.LFE1:
	.size	uartTransmit, .-uartTransmit
	.align	2
	.globl	receivedDataOutput
.LFB2 = .
	.loc 1 45 0
	.cfi_startproc
	.set	nomips16
	.set	nomicromips
	.ent	receivedDataOutput
	.type	receivedDataOutput, @function
receivedDataOutput:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
.LVL3 = .
	.loc 1 46 0
	li	$2,-1082130432			# 0xffffffffbf800000
	sw	$4,0($2)
	.loc 1 47 0
	sw	$4,4($2)
	.loc 1 48 0
	sw	$4,16($2)
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	receivedDataOutput
	.cfi_endproc
.LFE2:
	.size	receivedDataOutput, .-receivedDataOutput
	.align	2
	.globl	uartReceive
.LFB3 = .
	.loc 1 52 0
	.cfi_startproc
	.set	nomips16
	.set	nomicromips
	.ent	uartReceive
	.type	uartReceive, @function
uartReceive:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	.loc 1 54 0
	li	$3,-1337982976			# 0xffffffffb0400000
.L7:
	.loc 1 54 0 is_stmt 0 discriminator 1
	lw	$2,4116($3)
	andi	$2,$2,0x1
	beq	$2,$0,.L7
	li	$2,-1337982976			# 0xffffffffb0400000

	.loc 1 56 0 is_stmt 1
	lw	$2,4096($2)
	.loc 1 57 0
	jr	$31
	andi	$2,$2,0x00ff

	.set	macro
	.set	reorder
	.end	uartReceive
	.cfi_endproc
.LFE3:
	.size	uartReceive, .-uartReceive
	.align	2
	.globl	uartWrite
.LFB4 = .
	.loc 1 60 0
	.cfi_startproc
	.set	nomips16
	.set	nomicromips
	.ent	uartWrite
	.type	uartWrite, @function
uartWrite:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
.LVL4 = .
	addiu	$sp,$sp,-24
.LCFI0 = .
	.cfi_def_cfa_offset 24
	sw	$31,20($sp)
	sw	$16,16($sp)
	.cfi_offset 31, -4
	.cfi_offset 16, -8
	move	$16,$4
	.loc 1 61 0
	lbu	$4,0($4)
.LVL5 = .
	beq	$4,$0,.L15
	lw	$31,20($sp)

.L12:
.LVL6 = .
	.loc 1 62 0
	jal	uartTransmit
	addiu	$16,$16,1

.LVL7 = .
	.loc 1 61 0
	lbu	$4,0($16)
	bne	$4,$0,.L12
	lw	$31,20($sp)

.L15:
	.loc 1 63 0
	lw	$16,16($sp)
.LVL8 = .
	jr	$31
	addiu	$sp,$sp,24

.LCFI1 = .
	.cfi_def_cfa_offset 0
	.cfi_restore 16
	.cfi_restore 31
	.set	macro
	.set	reorder
	.end	uartWrite
	.cfi_endproc
.LFE4:
	.size	uartWrite, .-uartWrite
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
.LC0:
	.ascii	"Hello!\000"
	.text
	.align	2
	.globl	main
.LFB5 = .
	.loc 1 66 0
	.cfi_startproc
	.set	nomips16
	.set	nomicromips
	.ent	main
	.type	main, @function
main:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
.LCFI2 = .
	.cfi_def_cfa_offset 24
	sw	$31,20($sp)
	sw	$16,16($sp)
	.cfi_offset 31, -4
	.cfi_offset 16, -8
.LVL9 = .
	.loc 1 69 0
	jal	uartInit
	li	$4,27			# 0x1b

.LVL10 = .
	.loc 1 72 0
	lui	$4,%hi(.LC0)
	jal	uartWrite
	addiu	$4,$4,%lo(.LC0)

.LVL11 = .
.L17:
.LBB2 = .
	.loc 1 77 0 discriminator 1
	jal	uartReceive
	nop

.LVL12 = .
	move	$16,$2
.LVL13 = .
	.loc 1 78 0 discriminator 1
	jal	receivedDataOutput
	move	$4,$2

.LVL14 = .
	.loc 1 81 0 discriminator 1
	jal	uartTransmit
	move	$4,$16

.LVL15 = .
	b	.L17
	nop

.LBE2 = .
	.set	macro
	.set	reorder
	.end	main
	.cfi_endproc
.LFE5:
	.size	main, .-main
.Letext0:
	.file 2 "/opt/imgtec/Toolchains/mips-mti-elf/2017.10-05/mips-mti-elf/include/machine/_default_types.h"
	.file 3 "/opt/imgtec/Toolchains/mips-mti-elf/2017.10-05/mips-mti-elf/include/sys/_stdint.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.4byte	0x204
	.2byte	0x2
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.4byte	.LASF21
	.byte	0xc
	.4byte	.LASF22
	.4byte	.LASF23
	.4byte	.Ltext0
	.4byte	.Letext0
	.4byte	.Ldebug_line0
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.4byte	.LASF0
	.uleb128 0x3
	.4byte	.LASF3
	.byte	0x2
	.byte	0x2b
	.4byte	0x37
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.4byte	.LASF1
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.4byte	.LASF2
	.uleb128 0x3
	.4byte	.LASF4
	.byte	0x2
	.byte	0x39
	.4byte	0x50
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.4byte	.LASF5
	.uleb128 0x2
	.byte	0x4
	.byte	0x5
	.4byte	.LASF6
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF7
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.4byte	.LASF8
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.4byte	.LASF9
	.uleb128 0x3
	.4byte	.LASF10
	.byte	0x3
	.byte	0x18
	.4byte	0x2c
	.uleb128 0x3
	.4byte	.LASF11
	.byte	0x3
	.byte	0x24
	.4byte	0x45
	.uleb128 0x4
	.4byte	0x7e
	.uleb128 0x5
	.byte	0x4
	.byte	0x5
	.ascii	"int\000"
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF12
	.uleb128 0x6
	.byte	0x1
	.4byte	.LASF15
	.byte	0x1
	.byte	0x41
	.4byte	0x8e
	.4byte	.LFB5
	.4byte	.LFE5
	.4byte	.LLST3
	.byte	0x1
	.4byte	0x136
	.uleb128 0x7
	.4byte	.LASF13
	.byte	0x1
	.byte	0x44
	.4byte	0x89
	.byte	0x1b
	.uleb128 0x8
	.4byte	.LBB2
	.4byte	.LBE2
	.4byte	0x10f
	.uleb128 0x9
	.4byte	.LASF14
	.byte	0x1
	.byte	0x4d
	.4byte	0x73
	.4byte	.LLST4
	.uleb128 0xa
	.4byte	.LVL12
	.4byte	0x17b
	.uleb128 0xb
	.4byte	.LVL14
	.4byte	0x194
	.4byte	0xfe
	.uleb128 0xc
	.byte	0x1
	.byte	0x54
	.byte	0x2
	.byte	0x80
	.sleb128 0
	.byte	0
	.uleb128 0xd
	.4byte	.LVL15
	.4byte	0x1bb
	.uleb128 0xc
	.byte	0x1
	.byte	0x54
	.byte	0x2
	.byte	0x80
	.sleb128 0
	.byte	0
	.byte	0
	.uleb128 0xb
	.4byte	.LVL10
	.4byte	0x1e2
	.4byte	0x122
	.uleb128 0xc
	.byte	0x1
	.byte	0x54
	.byte	0x1
	.byte	0x4b
	.byte	0
	.uleb128 0xd
	.4byte	.LVL11
	.4byte	0x136
	.uleb128 0xc
	.byte	0x1
	.byte	0x54
	.byte	0x5
	.byte	0x3
	.4byte	.LC0
	.byte	0
	.byte	0
	.uleb128 0xe
	.byte	0x1
	.4byte	.LASF16
	.byte	0x1
	.byte	0x3b
	.byte	0x1
	.4byte	.LFB4
	.4byte	.LFE4
	.4byte	.LLST1
	.byte	0x1
	.4byte	0x169
	.uleb128 0xf
	.ascii	"str\000"
	.byte	0x1
	.byte	0x3b
	.4byte	0x169
	.4byte	.LLST2
	.uleb128 0xa
	.4byte	.LVL7
	.4byte	0x1bb
	.byte	0
	.uleb128 0x10
	.byte	0x4
	.4byte	0x176
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.4byte	.LASF17
	.uleb128 0x4
	.4byte	0x16f
	.uleb128 0x11
	.byte	0x1
	.4byte	.LASF24
	.byte	0x1
	.byte	0x33
	.byte	0x1
	.4byte	0x73
	.4byte	.LFB3
	.4byte	.LFE3
	.byte	0x2
	.byte	0x8d
	.sleb128 0
	.byte	0x1
	.uleb128 0x12
	.byte	0x1
	.4byte	.LASF18
	.byte	0x1
	.byte	0x2c
	.byte	0x1
	.4byte	.LFB2
	.4byte	.LFE2
	.byte	0x2
	.byte	0x8d
	.sleb128 0
	.byte	0x1
	.4byte	0x1bb
	.uleb128 0x13
	.4byte	.LASF14
	.byte	0x1
	.byte	0x2c
	.4byte	0x73
	.byte	0x1
	.byte	0x54
	.byte	0
	.uleb128 0x12
	.byte	0x1
	.4byte	.LASF19
	.byte	0x1
	.byte	0x23
	.byte	0x1
	.4byte	.LFB1
	.4byte	.LFE1
	.byte	0x2
	.byte	0x8d
	.sleb128 0
	.byte	0x1
	.4byte	0x1e2
	.uleb128 0x13
	.4byte	.LASF14
	.byte	0x1
	.byte	0x23
	.4byte	0x73
	.byte	0x1
	.byte	0x54
	.byte	0
	.uleb128 0x14
	.byte	0x1
	.4byte	.LASF25
	.byte	0x1
	.byte	0x1a
	.byte	0x1
	.4byte	.LFB0
	.4byte	.LFE0
	.byte	0x2
	.byte	0x8d
	.sleb128 0
	.byte	0x1
	.uleb128 0x15
	.4byte	.LASF20
	.byte	0x1
	.byte	0x1a
	.4byte	0x7e
	.4byte	.LLST0
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x10
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0x6
	.uleb128 0x2117
	.uleb128 0xc
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1c
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x4109
	.byte	0
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x410a
	.byte	0
	.uleb128 0x2
	.uleb128 0xa
	.uleb128 0x2111
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0x6
	.uleb128 0x2117
	.uleb128 0xc
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0xa
	.uleb128 0x2117
	.uleb128 0xc
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0xa
	.uleb128 0x2117
	.uleb128 0xc
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0xa
	.uleb128 0x2117
	.uleb128 0xc
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x6
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
.LLST3:
	.4byte	.LFB5-.Ltext0
	.4byte	.LCFI2-.Ltext0
	.2byte	0x2
	.byte	0x8d
	.sleb128 0
	.4byte	.LCFI2-.Ltext0
	.4byte	.LFE5-.Ltext0
	.2byte	0x2
	.byte	0x8d
	.sleb128 24
	.4byte	0
	.4byte	0
.LLST4:
	.4byte	.LVL13-.Ltext0
	.4byte	.LVL14-1-.Ltext0
	.2byte	0x1
	.byte	0x52
	.4byte	0
	.4byte	0
.LLST1:
	.4byte	.LFB4-.Ltext0
	.4byte	.LCFI0-.Ltext0
	.2byte	0x2
	.byte	0x8d
	.sleb128 0
	.4byte	.LCFI0-.Ltext0
	.4byte	.LCFI1-.Ltext0
	.2byte	0x2
	.byte	0x8d
	.sleb128 24
	.4byte	.LCFI1-.Ltext0
	.4byte	.LFE4-.Ltext0
	.2byte	0x2
	.byte	0x8d
	.sleb128 0
	.4byte	0
	.4byte	0
.LLST2:
	.4byte	.LVL4-.Ltext0
	.4byte	.LVL5-.Ltext0
	.2byte	0x1
	.byte	0x54
	.4byte	.LVL5-.Ltext0
	.4byte	.LVL8-.Ltext0
	.2byte	0x1
	.byte	0x60
	.4byte	0
	.4byte	0
.LLST0:
	.4byte	.LVL0-.Ltext0
	.4byte	.LVL1-.Ltext0
	.2byte	0x1
	.byte	0x54
	.4byte	.LVL1-.Ltext0
	.4byte	.LFE0-.Ltext0
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x54
	.byte	0x9f
	.4byte	0
	.4byte	0
	.section	.debug_aranges,"",@progbits
	.4byte	0x1c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0
	.2byte	0
	.2byte	0
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
	.4byte	0
	.4byte	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF3:
	.ascii	"__uint8_t\000"
.LASF24:
	.ascii	"uartReceive\000"
.LASF16:
	.ascii	"uartWrite\000"
.LASF19:
	.ascii	"uartTransmit\000"
.LASF14:
	.ascii	"data\000"
.LASF1:
	.ascii	"unsigned char\000"
.LASF7:
	.ascii	"long unsigned int\000"
.LASF5:
	.ascii	"short unsigned int\000"
.LASF21:
	.ascii	"GNU C99 6.3.0 -mel -march=m14kc -msoft-float -mplt -mips"
	.ascii	"32r2 -msynci -mabi=32 -g -gdwarf-2 -O1 -std=c99\000"
.LASF4:
	.ascii	"__uint16_t\000"
.LASF15:
	.ascii	"main\000"
.LASF12:
	.ascii	"unsigned int\000"
.LASF23:
	.ascii	"/home/zsl/work/github/mipsfpga-plus_zsl/program/05_uart\000"
.LASF9:
	.ascii	"long long unsigned int\000"
.LASF10:
	.ascii	"uint8_t\000"
.LASF13:
	.ascii	"uartDivisor\000"
.LASF18:
	.ascii	"receivedDataOutput\000"
.LASF8:
	.ascii	"long long int\000"
.LASF22:
	.ascii	"main.c\000"
.LASF17:
	.ascii	"char\000"
.LASF2:
	.ascii	"short int\000"
.LASF11:
	.ascii	"uint16_t\000"
.LASF6:
	.ascii	"long int\000"
.LASF20:
	.ascii	"divisor\000"
.LASF0:
	.ascii	"signed char\000"
.LASF25:
	.ascii	"uartInit\000"
	.ident	"GCC: (Codescape GNU Tools 2017.10-05 for MIPS MTI Bare Metal) 6.3.0"
