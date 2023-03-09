#include<stdio.h>
#include<stdbool.h>
#include "tree.h"
#include"semantic.h"
#include"ir.h"
#include "syntax.tab.h"
#include"spim.h"
extern struct node*root;
int yyrestart();
int yyparse();
void perror(const char *__s);
bool Error = 0;
int main(int argc, char** argv){
    if (argc <= 1) return 1;
    FILE* f = fopen(argv[1], "r");
    if (!f)
    {
        perror(argv[1]);
        return 1;
    }
    FILE* fw = freopen(argv[2], "w+",stdout);
    if (!fw)
    {
        perror(argv[2]);
        return 1;
    }
    yyrestart(f);
    yyparse();
    if (!Error) {
        //treeprint(root, 0);
        table =inithashtable();
        functiontable =inithashtable();
        declaretable =inithashtable();
        readfun();
        writefun();
        stack = initstack();
        initcodelist();
        visit(root);
        visittable();
        //iroutput();
        caluoffset();
        insselection();
    }
    return 0;
}

