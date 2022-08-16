; iNES HEADER segment
; Copyright (C) 2022 Matheus Fernandes Bigolin <mfrdrbigolin@disroot.org>
; SPDX-License-Identifier: MIT

.segment "HEADER"
  .byte $4E, $45, $53, $1A        ; iNES header identifier
  .byte $02                       ; Number of 16 KiB PRG-ROM banks
  .byte $01                       ; Number of 8 KiB CHR-ROM banks
  .byte %00000001                 ; Vertical mirroring, no PRG-RAM, no mapper
  .byte %00000000                 ; No special-case flags set, no mapper
  .byte $00, $00, $00             ; No PRG-RAM present, NTSC format
  .byte $42, $49, $47, $4C, $4E   ; Personal signature (BIGLN)