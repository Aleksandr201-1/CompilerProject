#include "Calculator.h"

void calculatorFromInput () {
    yyparse();
}

void calculatorFromFile (FILE *file) {
    yyrestart(file);
    calculatorFromInput();
}