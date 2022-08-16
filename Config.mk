# Configuration for the Makefile
# Copyright (C) 2022 Matheus Fernandes Bigolin <mfrdrbigolin@disroot.org>
# SPDX-License-Identifier: MIT

MAKENAME = "Urojoim"

MAIN = urojoim
MODULES = reset

SRC_DIR = src
INCL_DIR = include
ASSETS_DIR = assets
BUILD_DIR = build
BIN_DIR = bin

CONFIG_FILE = nes.cfg

AS = cl65
ASFLAGS = -v -O
LDFLAGS = -v
