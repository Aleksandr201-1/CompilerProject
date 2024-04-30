СС ?= gcc
BISON = bison
LEX = flex
CFLAGS += -Wall -Werror -fsanitize=address

SRC_DIR = src
OBJ_DIR = obj
BIN_DIR = bin
TEST_DIR = tests
GEN_DIR = gen

BISON_FILES = Grammar.y
FLEX_FILES = Scanner.l
FILES = main.c Calculator.c ErrorHandle.c Tree.c

GEN_FILES = $(BISON_FILES:.y=.c) $(FLEX_FILES:.l=.c)
DIRECTORIES = $(OBJ_DIR) $(BIN_DIR) $(GEN_DIR)

MAIN = $(BIN_DIR)/lab4

OBJ := $(FILES:.c=.o)
OBJ := $(addprefix $(OBJ_DIR)/, $(OBJ))
GEN_OBJ := $(GEN_FILES:.c=.o)
GEN_OBJ := $(addprefix $(OBJ_DIR)/, $(GEN_OBJ))

all: $(DIRECTORIES) $(MAIN)

$(DIRECTORIES):
	mkdir -p $(DIRECTORIES)

$(MAIN): $(GEN_OBJ) $(OBJ)
	$(СС) $(CFLAGS) $(GEN_OBJ) $(OBJ) -o $(MAIN)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(СС) $(CFLAGS) -c $< -o $@ -I./$(SRC_DIR) -I./$(GEN_DIR)

$(OBJ_DIR)/%.o: $(GEN_DIR)/%.c
	$(СС) $(CFLAGS) -c $< -o $@ -I./$(SRC_DIR) -I./$(GEN_DIR)

$(GEN_DIR)/$(BISON_FILES:.y=.c): $(SRC_DIR)/$(BISON_FILES)
	$(BISON) -Wcounterexamples --defines=$(patsubst %.c,%.h,$@) -o $@ $<

$(GEN_DIR)/$(FLEX_FILES:.l=.c): $(SRC_DIR)/$(FLEX_FILES)
	$(LEX) --header-file=$(patsubst %.c,%.h,$@) -o $@ $<

clean:
	rm -rf $(DIRECTORIES)