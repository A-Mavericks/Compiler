#ifndef SEMANTIC_H
#define SEMANTIC_H
#include "hashtable.h"
#include"ir.h"
pType Specifier(Node* node);
pType StructSpecifier(Node*node);
item VarDec(Node* node, pType specifier);
void FunDec(Node* node, pType specifier);
void CompSt(Node* node, pType returntype);
void StmtList(Node* node, pType returntype);
void Stmt(Node* node, pType returntype);
FieldList ParamDec(Node* node);
FieldList VarList(Node*node);
void ExtDecList(Node* node, pType specifier);
void ExtDef(Node* node);
void DefList(Node* node, item structitem);
void Def(Node* node, item structitem);
void DecList(Node*node ,pType specifier, item structitem);
void Dec (Node*node,pType specifier, item structitem);
pType Exp(Node* node);
void Args(Node* node, item number);

void visit(Node* root);
void visittable();
void printError(int errortype, int line, char* msg);

void readfun();
void writefun();
#endif