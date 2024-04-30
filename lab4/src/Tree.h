#ifndef TREE_H
#define TREE_H

#include <string.h>
#include "ErrorHandle.h"

typedef struct Node {
    int type, countOfNodes, nodesCapacity;
    int value;
    char str[256];
    struct Node **nodes;
} Node;

typedef struct NodeArray {
    int countOfNodes, nodesCapacity;
    Node **nodes;
} NodeArray;

extern const int MAX_IDENTIFIER_LEN;
extern const int ilit_symbol;

void printIndent (int depth);
void printTree (Node *node, int depth);
void addNode (Node *node, Node *toAdd);
void addNodeToArray (Node *node);
void swapLeafs (Node *node, Node *toSwap);
void removeFromLeafs (Node *node, Node *toPop);
Node *createNode (int type, const char *str, int nodesCapacity);
Node *createNodeFromValue (int value);
void deleteTree (Node *node);

#endif