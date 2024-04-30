%option noyywrap
%option nounput
%option noinput

%{
#include <stdio.h>
#include <stdlib.h>
#include "Tokens.h"
#include "ErrorHandle.h"
%}

%%

[ \t\r\n]+ {}

[a-zA-Z_][a-zA-Z0-9_]*  {
    printf("IDENTIFIER, \"%s\"\n", yytext);
    return IDENTIFIER;
}

"(" {
    printf("LPARENT, \"%s\"\n", yytext);
    return LPARENT;
}

")" {
    printf("RPARENT, \"%s\"\n", yytext);
    return RPARENT;
}

"," {
    printf("COMMA, \"%s\"\n", yytext);
    return COMMA;
}

"=" {
    printf("ASSIGN, \"%s\"\n", yytext);
    return ASSIGN;
}

-?[0-9]+ {
    long long a = strtoll(yytext, NULL, 10);
    int b = strtoq(yytext, NULL, 10);
    if (a == (long long)b) {
        printf("ILIT, \"%s\"\n", yytext);
        return ILIT;
    } else {
        EXIT_CODE = EC_NUMBER_OUT_OF_RANGE;
        printf("ERROR, \"%s\"\n", yytext);
        return ERROR;
    }
}

"+" {
    printf("PLUS, \"%s\"\n", yytext);
    return PLUS;
}

"-" {
    printf("MINUS, \"%s\"\n", yytext);
    return MINUS;
}

"*" {
    printf("MUL, \"%s\"\n", yytext);
    return MUL;
}

"/" {
    printf("DIV, \"%s\"\n", yytext);
    return DIV;
}

[0-9]+[a-zA-Z0-9_]+ {
    EXIT_CODE = EC_UNKNOWN_TOKEN;
    printf("ERROR, \"%s\"\n", yytext);
    return ERROR;
}

. {
    EXIT_CODE = EC_UNKNOWN_TOKEN;
    printf("ERROR, \"%s\"\n", yytext);
    return ERROR;
}

%%