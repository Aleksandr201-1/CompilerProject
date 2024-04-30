%option noyywrap
%option nounput
%option noinput
%option yylineno

%{
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
//#include "Tokens.h"
#include "Grammar.h"
#include "ErrorHandle.h"

//extern int yylineno;

const bool PRINT_TOKEN_INFO = false;
#define printIfNeeded(...) { if (PRINT_TOKEN_INFO) {fprintf(__VA_ARGS__);}}
%}

%%

[ \t\r]+ {}

<<EOF>> { static int once = 0; return once++ ? 0 : NL; }

"\n" {
    //++yylineno;
    return NL;
}

[a-zA-Z_][a-zA-Z0-9_]*  {
    printIfNeeded(stdout, "IDENTIFIER, \"%s\"\n", yytext);
    return IDENTIFIER;
}

"(" {
    printIfNeeded(stdout, "LPARENT, \"%s\"\n", yytext);
    return LPARENT;
}

")" {
    printIfNeeded(stdout, "RPARENT, \"%s\"\n", yytext);
    return RPARENT;
}

"," {
    printIfNeeded(stdout, "COMMA, \"%s\"\n", yytext);
    return COMMA;
}

"=" {
    printIfNeeded(stdout, "ASSIGN, \"%s\"\n", yytext);
    return ASSIGN;
}

-?[0-9]+ {
    long long a = strtoll(yytext, NULL, 10);
    int b = strtoq(yytext, NULL, 10);
    if (a == (long long)b) {
        printIfNeeded(stdout, "ILIT, \"%s\"\n", yytext);
        return ILIT;
    } else {
        EXIT_CODE = EC_NUMBER_OUT_OF_RANGE;
        printIfNeeded(stderr, "ERROR, \"%s\"\n", yytext);
        return ERROR;
    }
}

"+" {
    printIfNeeded(stdout, "PLUS, \"%s\"\n", yytext);
    return PLUS;
}

"-" {
    printIfNeeded(stdout, "MINUS, \"%s\"\n", yytext);
    return MINUS;
}

"*" {
    printIfNeeded(stdout, "MUL, \"%s\"\n", yytext);
    return MUL;
}

"/" {
    printIfNeeded(stdout, "DIV, \"%s\"\n", yytext);
    return DIV;
}

[0-9]+[a-zA-Z0-9_]+ {
    EXIT_CODE = EC_UNKNOWN_TOKEN;
    printIfNeeded(stderr, "ERROR, \"%s\"\n", yytext);
    return ERROR;
}

. {
    EXIT_CODE = EC_UNKNOWN_TOKEN;
    printIfNeeded(stderr, "ERROR, \"%s\"\n", yytext);
    return ERROR;
}

%%
