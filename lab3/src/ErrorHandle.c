#include "ErrorHandle.h"

int EXIT_CODE = 0;

void errorHandle (int code) {
    switch (code) {
        case EC_CANT_OPEN_FILE:
            fprintf(stderr, "cant open file\n");
            break;
        case EC_LEXICAL_ERROR:
            fprintf(stderr, "lexical error\n");
            break;
        case EC_NUMBER_OUT_OF_RANGE:
            fprintf(stderr, "number out of range\n");
            break;
        case EC_INCORRECT_USAGE:
            fprintf(stderr, "incorrect usage\n");
            break;
        case EC_SYNTAX_ERROR:
            fprintf(stderr, "syntax error\n");
            break;
        case EC_UNKNOWN_TOKEN:
            fprintf(stderr, "unknown token\n");
            break;
        default:
            fprintf(stderr, "unknown error\n");
            break;
    }
    exit(code);
}