  // Define the stack sizes for different modes. The user/system mode will use
  // the rest of the total stack size
  .set  UND_STACK_SIZE, 0x8
  .set  ABT_STACK_SIZE, 0x8
  .set  FIQ_STACK_SIZE, 0x8
  .set  IRQ_STACK_SIZE, 0x1000
  .set  SVC_STACK_SIZE, 0x8

  // to set the mode bits in CPSR for different modes
  .set  MODE_USR, 0x10
  .set  MODE_FIQ, 0x11
  .set  MODE_IRQ, 0x12
  .set  MODE_SVC, 0x13
  .set  MODE_ABT, 0x17
  .set  MODE_UND, 0x1B
  .set  MODE_SYS, 0x1F

  .equ  I_F_BIT, 0xC0

  .text

  .global hardwareInit

  .global _start
_start:
  ldr pc, _reset_h
  ldr pc, _undefined_instruction_vector_h
  ldr pc, _software_interrupt_vector_h
  ldr pc, _prefetch_abort_vector_h
  ldr pc, _data_abort_vector_h
  ldr pc, _unused_handler_h
  ldr pc, _interrupt_vector_h
  ldr pc, _fast_interrupt_vector_h

_reset_h:                           .word   _reset_
_undefined_instruction_vector_h:    .word   undefined_instruction_vector
_software_interrupt_vector_h:       .word   software_interrupt_vector
_prefetch_abort_vector_h:           .word   prefetch_abort_vector
_data_abort_vector_h:               .word   data_abort_vector
_unused_handler_h:                  .word   _reset_
_interrupt_vector_h:                .word   interrupt_vector
_fast_interrupt_vector_h:           .word   fast_interrupt_vector

  .global _reset_
_reset_:
  // Copy the vector table to the active table at 0x00000000
  @@ ldr r0, =_start
  @@ mov r1, #0x0000
  @@ ldmia r0!, {r2, r3, r4, r5, r6, r7, r8, r9}
  @@ stmia r1!, {r2, r3, r4, r5, r6, r7, r8, r9}
  @@ ldmia r0!, {r2, r3, r4, r5, r6, r7, r8, r9}
  @@ stmia r1!, {r2, r3, r4, r5, r6, r7, r8, r9}

  // Set up the Stack for Undefined mode
  ldr r0, =_stack               @ Read the stack address
  msr cpsr_c, #MODE_UND|I_F_BIT @ switch to undef  mode
  mov sp, r0                    @ write the stack pointer
  sub r0, r0, #UND_STACK_SIZE   @ give stack space

  // Set up the Stack for abort mode
  msr cpsr_c, #MODE_ABT|I_F_BIT @ Change to abort mode
  mov sp, r0                    @ write the stack pointer
  sub r0, r0, #ABT_STACK_SIZE   @ give stack space

  // Set up the Stack for FIQ mode
  msr cpsr_c, #MODE_FIQ|I_F_BIT @ change to FIQ mode
  mov sp, r0                    @ write the stack pointer
  sub r0, r0, #FIQ_STACK_SIZE   @ give stack space

  // Set up the Stack for IRQ mode
  msr cpsr_c, #MODE_IRQ|I_F_BIT @ change to IRQ mode
  mov sp, r0                    @ write the stack pointer
  sub r0, r0, #IRQ_STACK_SIZE   @ give stack space

  // Set up the Stack for SVC mode
  msr cpsr_c, #MODE_SVC|I_F_BIT @ change to SVC mode
  mov sp, r0                    @ write the stack pointer
  sub r0, r0, #SVC_STACK_SIZE   @ give stack space

  // Set up the Stack for USer/System mode
  msr cpsr_c, #MODE_SYS|I_F_BIT @ change to system mode
  mov sp, r0                    @ write the stack pointer

  ldr r10, =hardwareInit
  bx r10
