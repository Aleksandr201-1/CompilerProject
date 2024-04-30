#ifndef ERROR_HANDLE_H
#define ERROR_HANDLE_H

#include <stdio.h>
#include <stdlib.h>

extern int EXIT_CODE;

enum ErrorCode {
    EC_CANT_OPEN_FILE = 1,
    EC_UNKNOWN_IDENTIFIER,
    EC_NUMBER_OUT_OF_RANGE,
    EC_INCORRECT_USAGE,
    EC_UNKNOWN_FUNCTION,
    EC_UNKNOWN_TOKEN
};

void errorHandle (int code);

#endif