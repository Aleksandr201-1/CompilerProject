#ifndef CALCULATOR_H
#define CALCULATOR_H

#include <stdio.h>
#include "Scanner.h"
#include "Grammar.h"
#include "ErrorHandle.h"
#include "Tree.h"

extern Node *root;
extern Node *nodeArray;

void calculatorFromInput ();

void calculatorFromFile (FILE *file);

#endif