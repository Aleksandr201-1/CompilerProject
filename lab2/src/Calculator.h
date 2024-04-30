#ifndef CALCULATOR_H
#define CALCULATOR_H

#include <stdio.h>
#include "Scanner.h"
#include "ErrorHandle.h"
#include "Tokens.h"

void calculatorFromInput ();

void calculatorFromFile (FILE *file);

#endif