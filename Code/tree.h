#ifndef __TREE_H__
#define __TREE_H__
#define maxline 128
typedef enum {
   Int,
   Float,
   Id,
   TYPe,
   SCI,
   OCT,
   HEX,
   mark,
   other
} NodeType;
typedef struct node{
    int line;
    char* name;
    NodeType type;
    union {
        unsigned int intval;
        float floatval;
        char str[maxline];
    };
    struct node* child;
    struct node* next;
    void *head,*tail;
} Node; 
Node* calu(Node*x,char* text);
Node* newtoken(int line ,char* name, NodeType type, char*text);
Node* insert(Node*parent ,Node*child);
Node* newnode(int line ,char* name, NodeType type);
Node* create(int line,char* name,NodeType type,int count, ...);
void treeprint(Node*root,int deep);
#endif
