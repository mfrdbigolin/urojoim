; Reset handler
; Copyright (C) 2022 Matheus Fernandes Bigolin <mfrdrbigolin@disroot.org>
; SPDX-License-Identifier: MIT

.include "constants.inc"

.segment "CODE"
.import main

.export resetHandler
.proc resetHandler
  SEI             ; Disable IRQs
  CLD             ; Disable decimal mode

  LDX #%01000000  ; Disable APU frame IRQs
  STX FRAMESEQ

  LDX #$FF        ; Initialize the stack pointer
  TXS

  TXA

  INX
  STX PPUCTRL     ; Disable NMI
  STX PPUMASK     ; Disable rendering
  STX DMCFLAGS    ; Disable DMC IRQs

  BIT PPUSTATUS   ; Make sure that the PPU is in a known state
  @vblankWait1:
    BIT PPUSTATUS
    BPL @vblankWait1

  @clearOAM:      ; Fill the OAM with $FF to keep the sprites out of the screen.
    STA $200, x
    INX
    BNE @clearOAM

  TXA
  @clearMemory:
    STA $000, x
    STA $100, x
    STA $300, x
    STA $400, x
    STA $500, x
    STA $600, x
    STA $700, x
    INX
    BNE @clearMemory

  @vblankWait2:
    BIT PPUSTATUS
    BPL @vblankWait2

  JMP main
.endproc