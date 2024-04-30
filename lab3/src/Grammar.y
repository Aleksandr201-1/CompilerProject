%{
#include <stdio.h>
#include "ErrorHandle.h"

extern int yylineno;
int yylex (void);
void yyerror (char const *msg) {
    EXIT_CODE = EC_SYNTAX_ERROR;
    fprintf(stderr, "In line %d: %s\n", yylineno, msg);
}
void LexError () {
    EXIT_CODE = EC_LEXICAL_ERROR;
    fprintf(stderr, "In line %d: lexical error\n", yylineno);
}
%}
%locations

%token IDENTIFIER
%token LPARENT
%token RPARENT
%token COMMA
%right ASSIGN
%token ILIT
%left PLUS
%left MINUS
%left MUL
%left DIV
%token ERROR
%token NL

%%

input:
    %empty
    | input line
;

line:
    NL
    | rvalue NL
    | assignment NL
    | error NL {yyerrok;}
;

assignment:
    lvalue ASSIGN rvalue
;

func_call:
    IDENTIFIER LPARENT RPARENT
    | IDENTIFIER LPARENT func_args RPARENT
;

func_args:
    rvalue
    | func_args COMMA rvalue
;

lvalue:
    IDENTIFIER
    | ERROR {LexError();}
;

rvalue:
    lvalue
    | ILIT
    | rvalue PLUS rvalue
    | rvalue MINUS rvalue
    | rvalue MUL rvalue
    | rvalue DIV rvalue
    | MINUS rvalue
    | func_call
    | LPARENT rvalue RPARENT
;

%%