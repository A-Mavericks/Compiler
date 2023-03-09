#include"tree.h"
#include <stdio.h>
#include <stdarg.h>
#include <string.h>
#include <stdlib.h>
#include <assert.h>
Node* calu(Node*x,char* text){
    switch (x->type)
    {
        case Int: x->intval = (unsigned)atoi(text);break;
        case OCT: sscanf(text,"%ou",&x->intval);break;
        case HEX: sscanf(text,"%xu",&x->intval);break;
        case Float: x->floatval = (float)atof(text); break;
        case SCI: x->floatval = (float)atof(text); break;
        case Id:
        case TYPe:
        case mark: strncpy(x->str,text,strlen(text)+1); break;
    }
    return x;
}
Node* newtoken(int line ,char* name, NodeType type, char*text)
{
    Node* curtoken = (Node*)malloc(sizeof(Node));
    curtoken->line = line;
    /*int nameLength = strlen(name) + 1;
    curtoken->name = (char*)malloc(sizeof(char) * nameLength);
    strncpy(curtoken->name, name,nameLength);*/
    curtoken->name=name;
    curtoken->type = type;
    curtoken->child = NULL;
    curtoken->next = NULL;
    curtoken = calu(curtoken,text);
    return curtoken;
}
Node* insert(Node*parent ,Node*child){
    if(parent==NULL) return parent;
    if(parent->child==NULL)    {parent->child=child;}
    else {
        Node*p=NULL;
        p=parent->child;
        while(p->next){
            p=p->next;
        }
        p->next=child;
    }
    return parent;
}
Node* newnode(int line ,char* name, NodeType type)
{
    Node* curnode = (Node*)malloc(sizeof(Node));
    curnode->line = line;
    /*strcpy(curnode->name, name);*/
    curnode->name=name;
    curnode->type = type;
    curnode->child = NULL;
    curnode->next = NULL;
    return curnode;
}
Node* create(int line,char* name,NodeType type,int count, ...){
    Node* cur = (Node*)malloc(sizeof(Node));
    cur = newnode(line,name,type);
    va_list st;
    va_start(st, count);
    for (int i = 0; i < count; i++) {
            Node *Child = va_arg(st, Node*);
		    insert(cur, Child);
	    }
	    va_end(st);
    return cur;
}
void treeprint(Node*root,int deep){
      if(root==NULL){
        return;
      }
      if(root->type==other){
        if(root->name[0]=='_'){
            if(root->child) treeprint(root->child,deep+1);
            if(root->next) treeprint(root->next,deep);
            return;
        }
      }
      for(int i=0;i<deep;i++){
        printf("  ");
      }
      switch (root->type)
      {
        case mark:printf("%s\n", root->name); break;
        case Id: printf("%s: %s\n",root->name, root->str); break;
        case TYPe:  printf("%s: %s\n",root->name, root->str); break;
        case OCT:
        case HEX:
        case Int: printf("INT: %d\n", root->intval); break;
        case SCI:
        case Float: printf("FLOAT: %lf\n", root->floatval);break;
        case other:{
            if(root->name[0]!='_'){
                printf("%s (%d)\n",root->name,root->line);
            }
            break;
        } 
      }
        if(root->child) treeprint(root->child,deep+1);
        if(root->next) treeprint(root->next,deep);
 }