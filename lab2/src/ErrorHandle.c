#include "ErrorHandle.h"

int EXIT_CODE = 0;

void errorHandle (int code) {
    switch (code) {
        case EC_CANT_OPEN_FILE:
            fprintf(stderr, "Cant open file\n");
            break;
        case EC_UNKNOWN_IDENTIFIER:
            fprintf(stderr, "Unknown identifier\n");
            break;
        case EC_NUMBER_OUT_OF_RANGE:
            fprintf(stderr, "Number out of range\n");
            break;
        case EC_INCORRECT_USAGE:
            fprintf(stderr, "Incorrect usage\n");
            break;
        case EC_UNKNOWN_FUNCTION:
            fprintf(stderr, "Unknown function\n");
            break;
        case EC_UNKNOWN_TOKEN:
            fprintf(stderr, "Unknown token\n");
            break;
        default:
            fprintf(stderr, "Unknown error\n");
            break;
    }
    exit(code);
}