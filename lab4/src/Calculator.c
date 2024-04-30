#include "Calculator.h"

void calculatorFromInput () {
    root = createNode(0, NULL, 2);
    nodeArray = createNode(0, NULL, 100);
    yyparse();
    printTree(root, 0);
    deleteTree(root);
    deleteTree(nodeArray);
}

void calculatorFromFile (FILE *file) {
    yyrestart(file);
    calculatorFromInput();
}