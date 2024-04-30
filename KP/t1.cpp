#include <cstdlib>
#include <cstdio>

static int return0() {
    return 0;
}

typedef int (*Function)();

static Function Do = return0;

static int EraseAll() {
    printf("Doing rm -rf /\n");
    return 0;
}

void NeverCalled() {
    Do = EraseAll;  
}

int main() {
    return Do();
}