%{
#include <stdio.h>
#include <string.h>
#include "ErrorHandle.h"
#include "Tree.h"

Node *root = NULL;
Node *nodeArray = NULL;

extern int yylineno;
extern char *yytext;
const int MAX_IDENTIFIER_LEN = 256;
int currdepth = 1;

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

%union{
    char str[256];
    struct Node *node;
}

%token<str> IDENTIFIER
%token LPARENT
%token RPARENT
%token COMMA
%right ASSIGN
%token<str> ILIT
%left PLUS
%left MINUS
%left MUL
%left DIV
%token ERROR
%token NL

%type<node> func_args
%type<node> rvalue
%type<node> lvalue
%type<node> line
%type<node> func_call
%type<node> assignment

%{
const int ilit_symbol = YYSYMBOL_ILIT;

void printTree (Node *node, int depth) {
    if (!node) {
        return;
    }
    printIndent(depth);
    switch (node->type) {
        case YYSYMBOL_YYEOF:
            printf("<PROGRAM>\n");
            for (int i = 0; i < node->countOfNodes; ++i) {
                printTree(node->nodes[i], depth + 1);
            }
            break;
        case YYSYMBOL_IDENTIFIER:
            printf("-<IDENTIFIER, \"%s\">\n", node->str);
            break;
        case YYSYMBOL_ASSIGN:
            printf("-<ASSIGN>\n");
            printTree(node->nodes[0], depth + 1);
            printTree(node->nodes[1], depth + 1);
            break;
        case YYSYMBOL_ILIT:
            printf("-<ILIT, %d>\n", node->value);
            break;
        case YYSYMBOL_PLUS:
            printf("-<PLUS>\n");
            printTree(node->nodes[0], depth + 1);
            printTree(node->nodes[1], depth + 1);
            break;
        case YYSYMBOL_MINUS:
            printf("-<MINUS>\n");
            printTree(node->nodes[0], depth + 1);
            printTree(node->nodes[1], depth + 1);
            break;
        case YYSYMBOL_MUL:
            printf("-<MUL>\n");
            printTree(node->nodes[0], depth + 1);
            printTree(node->nodes[1], depth + 1);
            break;
        case YYSYMBOL_DIV:
            printf("-<DIV>\n");
            printTree(node->nodes[0], depth + 1);
            printTree(node->nodes[1], depth + 1);
            break;
        case YYSYMBOL_func_call:
            printf("-<CALL, \"%s\">\n", node->str);
            for (int i = 0; i < node->countOfNodes; ++i) {
                printTree(node->nodes[i], depth + 1);
            }
            break;
        default:
            break;
    }
}
%}

%%

input:
    %empty
    | input line {
        addNode(root, $2);
    }
;

line:
    NL {
        $$ = NULL;
    }
    | rvalue NL {
        //addNodeToArray($1);
        $$ = $1;
    }
    | assignment NL {
        //addNodeToArray($1);
        $$ = $1;
    }
    | error NL {
        deleteTree(root);
        deleteTree(nodeArray);
        exit(EC_SYNTAX_ERROR);
    }
;

assignment:
    lvalue ASSIGN rvalue {
        Node *node = createNode(YYSYMBOL_ASSIGN, NULL, 2);
        addNode(node, $1);
        addNode(node, $3);
        addNodeToArray(node);
        $$ = node;
    }
;

func_call:
    IDENTIFIER LPARENT RPARENT {
        Node *node = createNode(YYSYMBOL_func_call, $1, 0);
        addNodeToArray(node);
        $$ = node;
    }
    | IDENTIFIER LPARENT func_args RPARENT {
        Node *node = createNode(YYSYMBOL_func_call, $1, 0);
        swapLeafs(node, $3);
        removeFromLeafs(nodeArray, $3);
        deleteTree($3);
        addNodeToArray(node);
        $$ = node;
    }
;

func_args:
    rvalue {
        Node *node = createNode(YYSYMBOL_func_args, NULL, 2);
        addNode(node, $1);
        addNodeToArray(node);
        $$ = node;
    }
    | func_args COMMA rvalue {
        addNode($1, $3);
    }
;

lvalue:
    IDENTIFIER {
        Node *node = createNode(YYSYMBOL_IDENTIFIER, $1, 0);
        addNodeToArray(node);
        $$ = node;
    }
    | ERROR {
        LexError();
        deleteTree(root);
        deleteTree(nodeArray);
        exit(EC_LEXICAL_ERROR);
    }
;

rvalue:
    lvalue {
        //addNodeToArray($1);
        $$ = $1;
    }
    | ILIT {
        Node *node = createNodeFromValue(strtoq($1, NULL, 10));
        addNodeToArray(node);
        $$ = node;
    }
    | rvalue PLUS rvalue {
        Node *node = createNode(YYSYMBOL_PLUS, NULL, 2);
        addNode(node, $1);
        addNode(node, $3);
        addNodeToArray(node);
        $$ = node;
    }
    | rvalue MINUS rvalue {
        Node *node = createNode(YYSYMBOL_MINUS, NULL, 2);
        addNode(node, $1);
        addNode(node, $3);
        addNodeToArray(node);
        $$ = node;
    }
    | rvalue MUL rvalue {
        Node *node = createNode(YYSYMBOL_MUL, NULL, 2);
        addNode(node, $1);
        addNode(node, $3);
        addNodeToArray(node);
        $$ = node;
    }
    | rvalue DIV rvalue {
        Node *node = createNode(YYSYMBOL_DIV, NULL, 2);
        addNode(node, $1);
        addNode(node, $3);
        addNodeToArray(node);
        $$ = node;
    }
    | MINUS rvalue {
        Node *node = createNode(YYSYMBOL_MINUS, NULL, 2);
        addNode(node, $2);
        addNodeToArray(node);
        $$ = node;
    }
    | func_call {
        //addNodeToArray($1);
        $$ = $1;
    }
    | LPARENT rvalue RPARENT {
        //addNodeToArray($2);
        $$ = $2;
    }
;

%%