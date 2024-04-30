#include "Tree.h"

extern Node *nodeArray;

void removeFromLeafs (Node *node, Node *toPop) {
    if (!toPop) {
        return;
    }
    for (int i = 0; i < node->nodesCapacity; ++i) {
        if (node->nodes[i] == toPop) {
            node->nodes[i] = NULL;
            --nodeArray->countOfNodes;
        }
    }
}

void deleteTree (Node *node) {
    if (!node) {
        return;
    }
    if (node->nodesCapacity > 0) {
        for (int i = 0; i < node->nodesCapacity; ++i) {
            deleteTree(node->nodes[i]);
        }
        free(node->nodes);
    }
    free(node);
}

void printIndent (int depth) {
    if (depth == 0) {
        return;
    }
    printf("|");
    for (int i = 0; i < depth - 1; ++i) {
        printf(" |");
    }
}

void reallocNode (Node *node) {
    node->nodesCapacity *= 3;
    node->nodesCapacity /= 2;
    node->nodes = realloc(node->nodes, sizeof(Node*) * node->nodesCapacity);
    if (!node->nodes) {
        errorHandle(EC_MALLOC_ERROR);
    }
    for (int i = node->countOfNodes; i < node->nodesCapacity; ++i) {
        node->nodes[i] = NULL;
    }
}

void addNode (Node *node, Node *toAdd) {
    if (!node) {
        errorHandle(EC_TREE_BUILD_ERROR);
    }
    if (!toAdd) {
        return;
    }
    if (node->countOfNodes == node->nodesCapacity && node->countOfNodes != 0) {
        reallocNode(node);
    }
    removeFromLeafs(nodeArray, toAdd);
    node->nodes[node->countOfNodes] = toAdd;
    ++node->countOfNodes;
}

void addNodeToArray (Node *toAdd) {
    if (!toAdd) {
        return;
    }
    if (nodeArray->countOfNodes == nodeArray->nodesCapacity && nodeArray->countOfNodes != 0) {
        reallocNode(nodeArray);
    }
    for (int i = 0; i < nodeArray->nodesCapacity; ++i) {
        if (!nodeArray->nodes[i]) {
            nodeArray->nodes[i] = toAdd;
            ++nodeArray->countOfNodes;
            break;
        }
    }
}

void swapLeafs (Node *node, Node *toSwap) {
    Node tmp;
    tmp.nodes = node->nodes;
    tmp.countOfNodes = node->countOfNodes;
    tmp.nodesCapacity = node->nodesCapacity;
    node->nodes = toSwap->nodes;
    node->countOfNodes = toSwap->countOfNodes;
    node->nodesCapacity = toSwap->nodesCapacity;
    toSwap->nodes = tmp.nodes;
    toSwap->countOfNodes = tmp.countOfNodes;
    toSwap->nodesCapacity = tmp.nodesCapacity;

}

Node *createNode (int type, const char *str, int nodesCapacity) {
    Node *node = NULL;
    node = malloc(sizeof(Node));
    if (!node) {
        errorHandle(EC_MALLOC_ERROR);
    }
    node->type = type;
    memset(node->str, 0, MAX_IDENTIFIER_LEN);
    if (str) {
        strcpy(node->str, str);
    }
    node->value = 0;
    node->countOfNodes = 0;
    node->nodes = NULL;
    node->nodesCapacity = 0;
    if (nodesCapacity > 0) {
        node->nodes = malloc(sizeof(Node*) * nodesCapacity);
        if (!node->nodes) {
            errorHandle(EC_MALLOC_ERROR);
        }
        for (int i = 0; i < nodesCapacity; ++i) {
            node->nodes[i] = NULL;
        }
        node->nodesCapacity = nodesCapacity;
    }
    return node;
}

Node *createNodeFromValue (int value) {
    Node *node = createNode(ilit_symbol, NULL, 0);
    node->value = value;
    return node;
}