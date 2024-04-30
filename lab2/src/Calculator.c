#include "Calculator.h"

void calculatorFromInput () {
    int i = yylex();
    while (i != 0) {
        i = yylex();
    }
}

void calculatorFromFile (FILE *file) {
    yyrestart(file);
    calculatorFromInput();
}