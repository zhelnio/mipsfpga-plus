	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	softfloat
	.module	oddspreg
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.align	2
	.globl	_delay
.LFB0 = .
	.file 1 "main.c"
	.loc 1 32 0
	.cfi_startproc
	.set	nomips16
	.set	nomicromips
	.ent	_delay
	.type	_delay, @function
_delay:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
.LVL0 = .
.LBB2 = .
	.loc 1 33 0
	.set	noreorder
	.set	nomacro
	beq	$4,$0,.L5
	move	$2,$0
	.set	macro
	.set	reorder

.LVL1 = .
.L3:
	.loc 1 34 0 discriminator 3
 #APP
 # 34 "main.c" 1
	nop
 # 0 "" 2
	.loc 1 33 0 discriminator 3
 #NO_APP
	addiu	$2,$2,1
.LVL2 = .
	bne	$4,$2,.L3
.LVL3 = .
.L5:
	jr	$31
.LBE2 = .
	.end	_delay
	.cfi_endproc
.LFE0:
	.size	_delay, .-_delay
	.align	2
	.globl	statOut
.LFB1 = .
	.loc 1 39 0
	.cfi_startproc
	.set	nomips16
	.set	nomicromips
	.ent	statOut
	.type	statOut, @function
statOut:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
.LVL4 = .
	.loc 1 51 0
	li	$2,-1082130432			# 0xffffffffbf800000
	sw	$5,16($2)
	.loc 1 52 0
	sw	$4,4($2)
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	statOut
	.cfi_endproc
.LFE1:
	.size	statOut, .-statOut
	.align	2
	.globl	stepOut
.LFB2 = .
	.loc 1 58 0
	.cfi_startproc
	.set	nomips16
	.set	nomicromips
	.ent	stepOut
	.type	stepOut, @function
stepOut:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
.LVL5 = .
	.loc 1 59 0
	li	$2,1			# 0x1
	sll	$4,$2,$4
.LVL6 = .
	.loc 1 60 0
	andi	$4,$4,0xffff
	li	$2,-1082130432			# 0xffffffffbf800000
	sw	$4,0($2)
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	stepOut
	.cfi_endproc
.LFE2:
	.size	stepOut, .-stepOut
	.align	2
	.globl	cacheFlush
.LFB3 = .
	.loc 1 65 0
	.cfi_startproc
	.set	nomips16
	.set	nomicromips
	.ent	cacheFlush
	.type	cacheFlush, @function
cacheFlush:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
.LVL7 = .
	.loc 1 66 0
 #APP
 # 66 "main.c" 1
	cache 0x15, 0($4)
	
 # 0 "" 2
 #NO_APP
	jr	$31
	.end	cacheFlush
	.cfi_endproc
.LFE3:
	.size	cacheFlush, .-cacheFlush
	.align	2
	.globl	main
.LFB4 = .
	.loc 1 75 0
	.cfi_startproc
	.set	nomips16
	.set	nomicromips
	.ent	main
	.type	main, @function
main:
	.frame	$sp,56,$31		# vars= 0, regs= 10/0, args= 16, gp= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	addiu	$sp,$sp,-56
.LCFI0 = .
	.cfi_def_cfa_offset 56
	sw	$31,52($sp)
	sw	$fp,48($sp)
	sw	$23,44($sp)
	sw	$22,40($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	.cfi_offset 31, -4
	.cfi_offset 30, -8
	.cfi_offset 23, -12
	.cfi_offset 22, -16
	.cfi_offset 21, -20
	.cfi_offset 20, -24
	.cfi_offset 19, -28
	.cfi_offset 18, -32
	.cfi_offset 17, -36
	.cfi_offset 16, -40
.LVL8 = .
.LBB23 = .
.LBB24 = .
	.loc 1 60 0
	li	$3,1			# 0x1
	li	$2,-1082130432			# 0xffffffffbf800000
	sw	$3,0($2)
.LVL9 = .
	lui	$20,%hi(arr)
	addiu	$20,$20,%lo(arr)
	move	$3,$20
.LBE24 = .
.LBE23 = .
.LBB25 = .
	.loc 1 80 0
	move	$2,$0
	li	$4,10485760			# 0xa00000
.LVL10 = .
.L10:
	.loc 1 81 0 discriminator 3
	sw	$2,0($3)
	.loc 1 80 0 discriminator 3
	addiu	$2,$2,1
.LVL11 = .
	.set	noreorder
	.set	nomacro
	bne	$2,$4,.L10
	addiu	$3,$3,4
	.set	macro
	.set	reorder

	move	$19,$0
	move	$16,$0
.LBE25 = .
.LBB26 = .
.LBB27 = .
.LBB28 = .
	.loc 1 60 0
	li	$17,-1082130432			# 0xffffffffbf800000
	li	$fp,2			# 0x2
	lui	$18,%hi(arr+41943040)
	addiu	$18,$18,%lo(arr+41943040)
.LBE28 = .
.LBE27 = .
.LBB30 = .
.LBB31 = .
	li	$23,4			# 0x4
.LBE31 = .
.LBE30 = .
	.loc 1 93 0
	li	$21,983040			# 0xf0000
	addiu	$21,$21,16960
.LBE26 = .
	.loc 1 60 0
	.set	noreorder
	.set	nomacro
	b	.L14
	li	$22,8			# 0x8
	.set	macro
	.set	reorder

.LVL12 = .
.L12:
.L25:
.LBB46 = .
.LBB33 = .
	.loc 1 97 0 discriminator 2
	.set	noreorder
	.set	nomacro
	beq	$2,$5,.L23
	addiu	$3,$3,4
	.set	macro
	.set	reorder

.LVL13 = .
.L13:
	.loc 1 98 0
	lw	$4,0($3)
	.set	noreorder
	.set	nomacro
	beql	$4,$2,.L12
	addiu	$2,$2,1
	.set	macro
	.set	reorder

	.loc 1 99 0
	addiu	$16,$16,1
.LVL14 = .
	andi	$16,$16,0xffff
.LVL15 = .
.LBB34 = .
.LBB35 = .
	.loc 1 51 0
	sw	$16,16($17)
	.loc 1 52 0
	sw	$19,4($17)
.LBE35 = .
.LBE34 = .
.LBE33 = .
.LBE46 = .
	.loc 1 97 0
	.set	noreorder
	.set	nomacro
	b	.L25
	addiu	$2,$2,1
	.set	macro
	.set	reorder

.LVL16 = .
.L23:
.LBB47 = .
.LBB36 = .
.LBB37 = .
	.loc 1 51 0
	sw	$16,16($17)
	.loc 1 52 0
	sw	$19,4($17)
.LVL17 = .
	addiu	$19,$19,1
.LVL18 = .
.LBE37 = .
.LBE36 = .
	.loc 1 84 0
	li	$2,255			# 0xff
.LVL19 = .
	.set	noreorder
	.set	nomacro
	beql	$19,$2,.L24
	sltu	$16,$0,$16
	.set	macro
	.set	reorder

.LVL20 = .
.L14:
.LBB38 = .
.LBB29 = .
	.loc 1 60 0
	sw	$fp,0($17)
.LVL21 = .
	move	$2,$20
.LVL22 = .
.L11:
.LBE29 = .
.LBE38 = .
.LBB39 = .
.LBB40 = .
.LBB41 = .
	.loc 1 66 0 discriminator 3
 #APP
 # 66 "main.c" 1
	cache 0x15, 0($2)
	
 # 0 "" 2
.LVL23 = .
 #NO_APP
	addiu	$2,$2,4
.LBE41 = .
.LBE40 = .
	.loc 1 88 0 discriminator 3
	bne	$2,$18,.L11
.LVL24 = .
.LBE39 = .
.LBB42 = .
.LBB32 = .
	.loc 1 60 0
	sw	$23,0($17)
.LVL25 = .
.LBE32 = .
.LBE42 = .
	.loc 1 93 0
	.set	noreorder
	.set	nomacro
	jal	_delay
	move	$4,$21
	.set	macro
	.set	reorder

.LVL26 = .
.LBB43 = .
.LBB44 = .
	.loc 1 60 0
	sw	$22,0($17)
.LVL27 = .
	move	$3,$20
.LBE44 = .
.LBE43 = .
.LBB45 = .
	.loc 1 97 0
	move	$2,$0
.LBE45 = .
.LBE47 = .
	.set	noreorder
	.set	nomacro
	b	.L13
	li	$5,10485760			# 0xa00000
	.set	macro
	.set	reorder

.LVL28 = .
.L24:
	.loc 1 108 0
	addiu	$16,$16,4
.LVL29 = .
.LBB48 = .
.LBB49 = .
	.loc 1 59 0
	li	$2,1			# 0x1
	sll	$16,$2,$16
.LVL30 = .
	.loc 1 60 0
	andi	$2,$16,0xffff
	li	$3,-1082130432			# 0xffffffffbf800000
	sw	$2,0($3)
.L16:
	b	.L16
.LBE49 = .
.LBE48 = .
	.end	main
	.cfi_endproc
.LFE4:
	.size	main, .-main

	.comm	arr,41943040,4
.Letext0:
	.file 2 "/opt/imgtec/Toolchains/mips-mti-elf/2017.10-05/mips-mti-elf/include/machine/_default_types.h"
	.file 3 "/opt/imgtec/Toolchains/mips-mti-elf/2017.10-05/mips-mti-elf/include/sys/_stdint.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.4byte	0x3af
	.2byte	0x2
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.4byte	.LASF25
	.byte	0xc
	.4byte	.LASF26
	.4byte	.LASF27
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
	.uleb128 0x3
	.4byte	.LASF7
	.byte	0x2
	.byte	0x4f
	.4byte	0x69
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF8
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.4byte	.LASF9
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.4byte	.LASF10
	.uleb128 0x3
	.4byte	.LASF11
	.byte	0x3
	.byte	0x18
	.4byte	0x2c
	.uleb128 0x3
	.4byte	.LASF12
	.byte	0x3
	.byte	0x24
	.4byte	0x45
	.uleb128 0x3
	.4byte	.LASF13
	.byte	0x3
	.byte	0x30
	.4byte	0x5e
	.uleb128 0x4
	.byte	0x4
	.byte	0x5
	.ascii	"int\000"
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF14
	.uleb128 0x5
	.4byte	0x94
	.4byte	0xc0
	.uleb128 0x6
	.4byte	0xc0
	.4byte	0x9fffff
	.byte	0
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF15
	.uleb128 0x7
	.ascii	"arr\000"
	.byte	0x1
	.byte	0x48
	.4byte	0xad
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	arr
	.uleb128 0x8
	.byte	0x1
	.4byte	.LASF23
	.byte	0x1
	.byte	0x4a
	.4byte	0x9f
	.4byte	.LFB4
	.4byte	.LFE4
	.4byte	.LLST3
	.byte	0x1
	.4byte	0x2a5
	.uleb128 0x9
	.4byte	.LASF16
	.byte	0x1
	.byte	0x4c
	.4byte	0x89
	.4byte	.LLST4
	.uleb128 0xa
	.4byte	.LBB25
	.4byte	.LBE25
	.4byte	0x120
	.uleb128 0xb
	.ascii	"i\000"
	.byte	0x1
	.byte	0x50
	.4byte	0x94
	.4byte	.LLST5
	.byte	0
	.uleb128 0xc
	.4byte	.Ldebug_ranges0+0
	.4byte	0x253
	.uleb128 0xb
	.ascii	"j\000"
	.byte	0x1
	.byte	0x54
	.4byte	0x7e
	.4byte	.LLST6
	.uleb128 0xa
	.4byte	.LBB39
	.4byte	.LBE39
	.4byte	0x16a
	.uleb128 0xb
	.ascii	"i\000"
	.byte	0x1
	.byte	0x58
	.4byte	0x94
	.4byte	.LLST13
	.uleb128 0xd
	.4byte	0x2a5
	.4byte	.LBB40
	.4byte	.LBE40
	.byte	0x1
	.byte	0x59
	.uleb128 0xe
	.4byte	0x2b3
	.4byte	.LLST14
	.byte	0
	.byte	0
	.uleb128 0xc
	.4byte	.Ldebug_ranges0+0x50
	.4byte	0x1a3
	.uleb128 0xb
	.ascii	"i\000"
	.byte	0x1
	.byte	0x61
	.4byte	0x94
	.4byte	.LLST8
	.uleb128 0xd
	.4byte	0x2ea
	.4byte	.LBB34
	.4byte	.LBE34
	.byte	0x1
	.byte	0x64
	.uleb128 0xe
	.4byte	0x303
	.4byte	.LLST9
	.uleb128 0xe
	.4byte	0x2f8
	.4byte	.LLST10
	.byte	0
	.byte	0
	.uleb128 0xf
	.4byte	0x2c5
	.4byte	.LBB27
	.4byte	.Ldebug_ranges0+0x20
	.byte	0x1
	.byte	0x57
	.4byte	0x1c8
	.uleb128 0x10
	.4byte	0x2d3
	.byte	0x1
	.uleb128 0x11
	.4byte	.Ldebug_ranges0+0x20
	.uleb128 0x12
	.4byte	0x38f
	.byte	0
	.byte	0
	.uleb128 0xf
	.4byte	0x2c5
	.4byte	.LBB30
	.4byte	.Ldebug_ranges0+0x38
	.byte	0x1
	.byte	0x5c
	.4byte	0x1f0
	.uleb128 0xe
	.4byte	0x2d3
	.4byte	.LLST7
	.uleb128 0x11
	.4byte	.Ldebug_ranges0+0x38
	.uleb128 0x12
	.4byte	0x38f
	.byte	0
	.byte	0
	.uleb128 0x13
	.4byte	0x2ea
	.4byte	.LBB36
	.4byte	.LBE36
	.byte	0x1
	.byte	0x67
	.4byte	0x216
	.uleb128 0xe
	.4byte	0x303
	.4byte	.LLST11
	.uleb128 0xe
	.4byte	0x2f8
	.4byte	.LLST12
	.byte	0
	.uleb128 0x13
	.4byte	0x2c5
	.4byte	.LBB43
	.4byte	.LBE43
	.byte	0x1
	.byte	0x60
	.4byte	0x242
	.uleb128 0xe
	.4byte	0x2d3
	.4byte	.LLST15
	.uleb128 0x14
	.4byte	.LBB44
	.4byte	.LBE44
	.uleb128 0x12
	.4byte	0x38f
	.byte	0
	.byte	0
	.uleb128 0x15
	.4byte	.LVL26
	.4byte	0x30f
	.uleb128 0x16
	.byte	0x1
	.byte	0x54
	.byte	0x2
	.byte	0x85
	.sleb128 0
	.byte	0
	.byte	0
	.uleb128 0x13
	.4byte	0x2c5
	.4byte	.LBB23
	.4byte	.LBE23
	.byte	0x1
	.byte	0x4f
	.4byte	0x27c
	.uleb128 0x10
	.4byte	0x2d3
	.byte	0
	.uleb128 0x14
	.4byte	.LBB24
	.4byte	.LBE24
	.uleb128 0x12
	.4byte	0x38f
	.byte	0
	.byte	0
	.uleb128 0xd
	.4byte	0x2c5
	.4byte	.LBB48
	.4byte	.LBE48
	.byte	0x1
	.byte	0x6c
	.uleb128 0xe
	.4byte	0x2d3
	.4byte	.LLST16
	.uleb128 0x14
	.4byte	.LBB49
	.4byte	.LBE49
	.uleb128 0x12
	.4byte	0x38f
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x17
	.byte	0x1
	.4byte	.LASF17
	.byte	0x1
	.byte	0x40
	.byte	0x1
	.byte	0x1
	.4byte	0x2bf
	.uleb128 0x18
	.4byte	.LASF19
	.byte	0x1
	.byte	0x40
	.4byte	0x2bf
	.byte	0
	.uleb128 0x19
	.byte	0x4
	.4byte	0x94
	.uleb128 0x17
	.byte	0x1
	.4byte	.LASF18
	.byte	0x1
	.byte	0x39
	.byte	0x1
	.byte	0x1
	.4byte	0x2ea
	.uleb128 0x18
	.4byte	.LASF20
	.byte	0x1
	.byte	0x39
	.4byte	0x7e
	.uleb128 0x1a
	.ascii	"out\000"
	.byte	0x1
	.byte	0x3b
	.4byte	0x89
	.byte	0
	.uleb128 0x17
	.byte	0x1
	.4byte	.LASF21
	.byte	0x1
	.byte	0x26
	.byte	0x1
	.byte	0x1
	.4byte	0x30f
	.uleb128 0x18
	.4byte	.LASF22
	.byte	0x1
	.byte	0x26
	.4byte	0x7e
	.uleb128 0x18
	.4byte	.LASF16
	.byte	0x1
	.byte	0x26
	.4byte	0x89
	.byte	0
	.uleb128 0x1b
	.byte	0x1
	.4byte	.LASF24
	.byte	0x1
	.byte	0x1f
	.byte	0x1
	.4byte	.LFB0
	.4byte	.LFE0
	.byte	0x2
	.byte	0x8d
	.sleb128 0
	.byte	0x1
	.4byte	0x34d
	.uleb128 0x1c
	.ascii	"val\000"
	.byte	0x1
	.byte	0x1f
	.4byte	0x94
	.byte	0x1
	.byte	0x54
	.uleb128 0x14
	.4byte	.LBB2
	.4byte	.LBE2
	.uleb128 0xb
	.ascii	"i\000"
	.byte	0x1
	.byte	0x21
	.4byte	0x94
	.4byte	.LLST0
	.byte	0
	.byte	0
	.uleb128 0x1d
	.4byte	0x2ea
	.4byte	.LFB1
	.4byte	.LFE1
	.byte	0x2
	.byte	0x8d
	.sleb128 0
	.byte	0x1
	.4byte	0x371
	.uleb128 0x1e
	.4byte	0x2f8
	.byte	0x1
	.byte	0x54
	.uleb128 0x1e
	.4byte	0x303
	.byte	0x1
	.byte	0x55
	.byte	0
	.uleb128 0x1d
	.4byte	0x2c5
	.4byte	.LFB2
	.4byte	.LFE2
	.byte	0x2
	.byte	0x8d
	.sleb128 0
	.byte	0x1
	.4byte	0x399
	.uleb128 0xe
	.4byte	0x2d3
	.4byte	.LLST1
	.uleb128 0x1f
	.4byte	0x2de
	.4byte	.LLST2
	.byte	0
	.uleb128 0x20
	.4byte	0x2a5
	.4byte	.LFB3
	.4byte	.LFE3
	.byte	0x2
	.byte	0x8d
	.sleb128 0
	.byte	0x1
	.uleb128 0x1e
	.4byte	0x2b3
	.byte	0x1
	.byte	0x54
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
	.uleb128 0x5
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x2
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x8
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
	.uleb128 0xb
	.uleb128 0x34
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
	.uleb128 0xc
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x55
	.uleb128 0x6
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x55
	.uleb128 0x6
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x1c
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x55
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x410a
	.byte	0
	.uleb128 0x2
	.uleb128 0xa
	.uleb128 0x2111
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x17
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
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x18
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
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1b
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
	.uleb128 0x1c
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
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x1d
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
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
	.uleb128 0x1e
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x1f
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x20
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x31
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
	.byte	0
	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
.LLST3:
	.4byte	.LFB4-.Ltext0
	.4byte	.LCFI0-.Ltext0
	.2byte	0x2
	.byte	0x8d
	.sleb128 0
	.4byte	.LCFI0-.Ltext0
	.4byte	.LFE4-.Ltext0
	.2byte	0x2
	.byte	0x8d
	.sleb128 56
	.4byte	0
	.4byte	0
.LLST4:
	.4byte	.LVL8-.Ltext0
	.4byte	.LVL12-.Ltext0
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL12-.Ltext0
	.4byte	.LVL14-.Ltext0
	.2byte	0x1
	.byte	0x60
	.4byte	.LVL15-.Ltext0
	.4byte	.LVL28-.Ltext0
	.2byte	0x1
	.byte	0x60
	.4byte	0
	.4byte	0
.LLST5:
	.4byte	.LVL9-.Ltext0
	.4byte	.LVL10-.Ltext0
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL10-.Ltext0
	.4byte	.LVL12-.Ltext0
	.2byte	0x1
	.byte	0x52
	.4byte	0
	.4byte	0
.LLST6:
	.4byte	.LVL12-.Ltext0
	.4byte	.LVL17-.Ltext0
	.2byte	0x1
	.byte	0x63
	.4byte	.LVL17-.Ltext0
	.4byte	.LVL18-.Ltext0
	.2byte	0x3
	.byte	0x83
	.sleb128 1
	.byte	0x9f
	.4byte	.LVL20-.Ltext0
	.4byte	.LVL28-.Ltext0
	.2byte	0x1
	.byte	0x63
	.4byte	0
	.4byte	0
.LLST13:
	.4byte	.LVL21-.Ltext0
	.4byte	.LVL22-.Ltext0
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	0
	.4byte	0
.LLST14:
	.4byte	.LVL22-.Ltext0
	.4byte	.LVL23-.Ltext0
	.2byte	0x1
	.byte	0x52
	.4byte	0
	.4byte	0
.LLST8:
	.4byte	.LVL12-.Ltext0
	.4byte	.LVL19-.Ltext0
	.2byte	0x1
	.byte	0x52
	.4byte	.LVL27-.Ltext0
	.4byte	.LVL28-.Ltext0
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	0
	.4byte	0
.LLST9:
	.4byte	.LVL15-.Ltext0
	.4byte	.LVL16-.Ltext0
	.2byte	0x1
	.byte	0x60
	.4byte	0
	.4byte	0
.LLST10:
	.4byte	.LVL15-.Ltext0
	.4byte	.LVL16-.Ltext0
	.2byte	0x1
	.byte	0x63
	.4byte	0
	.4byte	0
.LLST7:
	.4byte	.LVL24-.Ltext0
	.4byte	.LVL25-.Ltext0
	.2byte	0x2
	.byte	0x32
	.byte	0x9f
	.4byte	0
	.4byte	0
.LLST11:
	.4byte	.LVL16-.Ltext0
	.4byte	.LVL17-.Ltext0
	.2byte	0x1
	.byte	0x60
	.4byte	0
	.4byte	0
.LLST12:
	.4byte	.LVL16-.Ltext0
	.4byte	.LVL17-.Ltext0
	.2byte	0x1
	.byte	0x63
	.4byte	0
	.4byte	0
.LLST15:
	.4byte	.LVL12-.Ltext0
	.4byte	.LVL20-.Ltext0
	.2byte	0x2
	.byte	0x33
	.byte	0x9f
	.4byte	.LVL26-.Ltext0
	.4byte	.LFE4-.Ltext0
	.2byte	0x2
	.byte	0x33
	.byte	0x9f
	.4byte	0
	.4byte	0
.LLST16:
	.4byte	.LVL29-.Ltext0
	.4byte	.LVL30-.Ltext0
	.2byte	0x1
	.byte	0x60
	.4byte	0
	.4byte	0
.LLST0:
	.4byte	.LVL0-.Ltext0
	.4byte	.LVL1-.Ltext0
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL1-.Ltext0
	.4byte	.LVL3-.Ltext0
	.2byte	0x1
	.byte	0x52
	.4byte	0
	.4byte	0
.LLST1:
	.4byte	.LVL5-.Ltext0
	.4byte	.LVL6-.Ltext0
	.2byte	0x1
	.byte	0x54
	.4byte	.LVL6-.Ltext0
	.4byte	.LFE2-.Ltext0
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x54
	.byte	0x9f
	.4byte	0
	.4byte	0
.LLST2:
	.4byte	.LVL5-.Ltext0
	.4byte	.LVL6-.Ltext0
	.2byte	0x8
	.byte	0x31
	.byte	0x74
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x24
	.byte	0x9f
	.4byte	.LVL6-.Ltext0
	.4byte	.LFE2-.Ltext0
	.2byte	0x9
	.byte	0x31
	.byte	0xf3
	.uleb128 0x1
	.byte	0x54
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x24
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
	.section	.debug_ranges,"",@progbits
.Ldebug_ranges0:
	.4byte	.LBB26-.Ltext0
	.4byte	.LBE26-.Ltext0
	.4byte	.LBB46-.Ltext0
	.4byte	.LBE46-.Ltext0
	.4byte	.LBB47-.Ltext0
	.4byte	.LBE47-.Ltext0
	.4byte	0
	.4byte	0
	.4byte	.LBB27-.Ltext0
	.4byte	.LBE27-.Ltext0
	.4byte	.LBB38-.Ltext0
	.4byte	.LBE38-.Ltext0
	.4byte	0
	.4byte	0
	.4byte	.LBB30-.Ltext0
	.4byte	.LBE30-.Ltext0
	.4byte	.LBB42-.Ltext0
	.4byte	.LBE42-.Ltext0
	.4byte	0
	.4byte	0
	.4byte	.LBB33-.Ltext0
	.4byte	.LBE33-.Ltext0
	.4byte	.LBB45-.Ltext0
	.4byte	.LBE45-.Ltext0
	.4byte	0
	.4byte	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF3:
	.ascii	"__uint8_t\000"
.LASF21:
	.ascii	"statOut\000"
.LASF27:
	.ascii	"/home/zsl/work/github/mipsfpga-plus_zsl/program/04_memte"
	.ascii	"st\000"
.LASF22:
	.ascii	"iterationNum\000"
.LASF19:
	.ascii	"addr\000"
.LASF1:
	.ascii	"unsigned char\000"
.LASF18:
	.ascii	"stepOut\000"
.LASF8:
	.ascii	"long unsigned int\000"
.LASF5:
	.ascii	"short unsigned int\000"
.LASF25:
	.ascii	"GNU C99 6.3.0 -mel -march=m14kc -msoft-float -mplt -mips"
	.ascii	"32r2 -msynci -mabi=32 -g -gdwarf-2 -O1 -std=c99\000"
.LASF24:
	.ascii	"_delay\000"
.LASF4:
	.ascii	"__uint16_t\000"
.LASF7:
	.ascii	"__uint32_t\000"
.LASF23:
	.ascii	"main\000"
.LASF14:
	.ascii	"unsigned int\000"
.LASF10:
	.ascii	"long long unsigned int\000"
.LASF11:
	.ascii	"uint8_t\000"
.LASF17:
	.ascii	"cacheFlush\000"
.LASF15:
	.ascii	"sizetype\000"
.LASF9:
	.ascii	"long long int\000"
.LASF26:
	.ascii	"main.c\000"
.LASF2:
	.ascii	"short int\000"
.LASF12:
	.ascii	"uint16_t\000"
.LASF13:
	.ascii	"uint32_t\000"
.LASF6:
	.ascii	"long int\000"
.LASF0:
	.ascii	"signed char\000"
.LASF20:
	.ascii	"stepNum\000"
.LASF16:
	.ascii	"errCount\000"
	.ident	"GCC: (Codescape GNU Tools 2017.10-05 for MIPS MTI Bare Metal) 6.3.0"
