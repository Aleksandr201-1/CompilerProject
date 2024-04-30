#ifndef ERROR_HANDLE_H
#define ERROR_HANDLE_H

#include <stdio.h>
#include <stdlib.h>

extern int EXIT_CODE;

enum ErrorCode {
    EC_CANT_OPEN_FILE = 1,
    EC_MALLOC_ERROR,
    EC_TREE_BUILD_ERROR,
    EC_LEXICAL_ERROR,
    EC_NUMBER_OUT_OF_RANGE,
    EC_INCORRECT_USAGE,
    EC_SYNTAX_ERROR,
    EC_UNKNOWN_TOKEN
};

void errorHandle (int code);

#endif