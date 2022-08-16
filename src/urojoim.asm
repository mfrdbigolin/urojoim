; Urojoim — Snake-like game
; Copyright (C) 2022 Matheus Fernandes Bigolin <mfrdrbigolin@disroot.org>
; SPDX-License-Identifier: MIT

.include "constants.inc"
.include "header.inc"

.segment "VECTORS"
.addr NMIHandler, resetHandler, IRQHandler


.segment "CODE"
.proc NMIHandler
  LDA #$00
  STA OAMADDR
  LDA #$02
  STA OAMDMA
  LDA #$00
  STA PPUSCROLL
  STA PPUSCROLL
  RTI
.endproc

.import resetHandler

.proc IRQHandler
  RTI
.endproc

.proc loadPalettes
  BIT PPUSTATUS
  LDA #$3F
  STA PPUADDR
  LDA #$00
  STA PPUADDR

  LDX #$00
  @loop:
    LDA palettes, x
    STA PPUDATA
    INX
    CPX #$20
    BNE @loop

  RTS
.endproc

.proc loadSprites
  LDX #$00
  @loop:
    LDA sprites, x
    STA $0200, x
    INX
    CPX #$10
    BNE @loop

  RTS
.endproc

.proc loadBackground
  LDA PPUSTATUS
  LDA #$20
  STA PPUADDR
  LDA #$00
  STA PPUADDR

  addrLO = $10
  addrHI = $11

  LDA #<background
  STA addrLO
  LDA #>background
  STA addrHI

  LDY #$00
  LDX #$04
  @loop:
    LDA (addrLO), y
    STA PPUDATA
    INY
    BNE @loop
    INC addrHI
    DEX
    BNE @loop

  RTS
.endproc

.export main
.proc main
  JSR loadPalettes
  JSR loadSprites
  JSR loadBackground

  LDA #%10010000  ; Turn on NMIs, sprites use the first pattern table
  STA PPUCTRL
  LDA #%00011110  ; Enable sprites and the background
  STA PPUMASK

  forever:
    JMP forever
.endproc


.segment "RODATA"
palettes:
  .incbin "background.pal"
  .incbin "sprites.pal"

sprites:
  .byte $72, $04, $00, $80
  .byte $72, $05, $00, $88
  .byte $7A, $06, $00, $80
  .byte $7A, $07, $00, $88

background:
  .incbin "start.nam"


.segment "CHARS"
.incbin "graphics.chr"