СС ?= gcc
CFLAGS += -Wall -Werror -fsanitize=address
FILES = main.c
OBJ_DIR = obj
BIN_DIR = bin
TEST_DIR = tests
GEN_DIR = gen
DIRECTORIES = $(OBJ_DIR) $(BIN_DIR) $(BIN_DIR)/$(TEST_DIR) $(GEN_DIR)
SRC_DIR = src
MAIN = $(BIN_DIR)/main
OBJ = $(OBJ_DIR)/$(FILES:.c=.o)

all: $(DIRECTORIES) $(MAIN)

$(DIRECTORIES):
	mkdir -p $(DIRECTORIES)

$(MAIN): $(OBJ)
	$(СС) $(CFLAGS) $(OBJ) -o $(MAIN)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(СС) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(DIRECTORIES)