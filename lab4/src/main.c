#include <stdio.h>
#include "Scanner.h"
#include "Grammar.h"
#include "ErrorHandle.h"
#include "Calculator.h"

int main (int argc, char *argv[]) {
    FILE *file;
    switch (argc) {
        case 1:
            calculatorFromInput();
            break;
        case 2:
            file = fopen(argv[1], "r");
            if (!file) {
                errorHandle(EC_CANT_OPEN_FILE);
            }
            calculatorFromFile(file);
            fclose(file);
            break;
        default:
            errorHandle(EC_INCORRECT_USAGE);
            break;
    }
    return EXIT_CODE;
}