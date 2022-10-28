.phony: all clean

BIN_DIR = ../bin
EXECUTABLE = $(BIN_DIR)/port_node

ERLANG_PATH = $(shell elixir --eval 'IO.puts(:code.root_dir)')
ifeq ($(ERLANG_PATH),)
$(error Could not find the Elixir installation. Check to see that `elixir`)
endif
ERL_EI_INCLUDE_DIR = $(ERLANG_PATH)/usr/include
ERL_EI_LIBDIR = $(ERLANG_PATH)/usr/lib
ERL_CFLAGS = -I$(ERL_EI_INCLUDE_DIR)
ERL_LDFLAGS = -L$(ERL_EI_LIBDIR)

CFLAGS += -std=c11 -O3 -Wall -Wextra -Wno-unused-function -Wno-unused-parameter -Wno-missing-field-initializers
C_SRC_DIR = .
C_OBJ_DIR = ../obj
C_SRC = $(C_SRC_DIR)/port_node.c
C_OBJ = $(C_SRC:$(C_SRC_DIR)/%.c=$(C_OBJ_DIR)/%.o)

all: $(C_OBJ_DIR) $(BIN_DIR) $(EXECUTABLE)

$(C_OBJ_DIR) $(BIN_DIR):
	mkdir -p $@

$(C_OBJ_DIR)/%.o: $(C_SRC_DIR)/%.c
	@echo " CC $(notdir $@)"
	$(CC) -c $(ERL_CFLAGS) $(CFLAGS) -o $@ $<

$(EXECUTABLE): $(C_OBJ)
	@echo " LD $(notdir $@)"
	$(CC) -o $@ $(ERL_LDFLAGS) $(LD_FLAGS) $^

clean:
	$(RM) $(EXECUTABLE) $(C_OBJ)
