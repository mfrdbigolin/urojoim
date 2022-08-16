# Makefile
# Copyright (C) 2022 Matheus Fernandes Bigolin <mfrdrbigolin@disroot.org>
# SPDX-License-Identifier: MIT

include Config.mk
include Utils.mk

vpath %.asm $(SRC_DIR)

ifdef INCL_DIR
	ASFLAGS += --asm-include-dir $(INCL_DIR)
endif

ifdef ASSETS_DIR
	ASFLAGS += --bin-include-dir $(ASSETS_DIR)
endif

ifdef CONFIG_FILE
	LDFLAGS += -C $(CONFIG_FILE)
endif

OBJS = $(patsubst %, $(BUILD_DIR)/%.o, $(MAIN) $(MODULES))

.PHONY: clean

$(BIN_DIR)/$(MAIN).nes: $(OBJS) | $(BIN_DIR)
	@$(link_binary)

$(BUILD_DIR)/%.o: %.asm | $(BUILD_DIR)
	@$(assemble_object)

# Create missing output directories.
$(BUILD_DIR) $(BIN_DIR):
	@$(create_dir)

clean:
	@$(clean)
