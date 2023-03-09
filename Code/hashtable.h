#ifndef HASHTABLE_H
#define HASHTABLE_H
#include"tree.h"
#include <stdio.h>
#include <stdarg.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include<assert.h>
typedef struct Type_*  pType;
typedef struct FieldList_* FieldList;
typedef struct item_* item;
typedef struct hashTable_* hashtable;
typedef enum { BASIC, ARRAY, STRUCTURE,FUNCTION } Kind;
struct Type_
 {
 Kind kind;
 union
 {
 // 基本类型
 int basic;
 // 数组类型信息包括元素类型与数组大小构成
 struct { pType elem; int size; } array;
 // 结构体类型信息是一个链表
 FieldList structure;
 //函数类型
 struct{pType returntype;FieldList args;} function;
 } u;
};
struct FieldList_
{ 
    char* name; // 域的名字
    pType type; // 域的类型
    FieldList tail; // 下一个域
};
struct item_{
    int line;
    int value;
    int depth;
    FieldList field;
    item nextHash;
    bool isaddr;
    int num;
    void* op;
};
typedef struct hashTable_{
    item* hashlist;
}HashTable;
HashTable table;
HashTable functiontable;
HashTable declaretable;

typedef struct stack_{
    item* stacklist;
    int stacknum;
}Stack;
Stack stack;

unsigned int hash_pjw(char* name);

FieldList newFieldList(char* Name, pType Type);
item newItem(FieldList field);
int checkType(pType type1, pType type2);
int checkstruct(FieldList one,FieldList two);
int checkfuntion(FieldList one,FieldList two,pType one1,pType two2);

Stack initstack();
void clearStack();

HashTable inithashtable();
int checkTableitem(HashTable table, item newitem);
item searchTableItem(HashTable table, char* name);
void addItem(HashTable table, item newitem);
void changeitem(HashTable table, char* name);
void deletetableitem(HashTable table,item self); 
#endif