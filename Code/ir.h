#ifndef IR_H
#define IR_H
#include "hashtable.h"

enum OperandType
{
    OP_CONSTANT,
    OP_VARIABLE,
    OP_TEMP,
    OP_ADDRESS,
    OP_LABEL,
    OP_FUNCTION,
    OP_RELOP,
    NO
};

enum CodeType
{
    CODE_LABEL,
    CODE_FUNCTION,
    CODE_ASSIGN,
    CODE_ADD,
    CODE_SUB,
    CODE_MUL,
    CODE_DIV,
    CODE_GETADDR,
    CODE_LOAD,
    CODE_SAVE,
    CODE_GOTO,
    CODE_GOTO_RELOP,
    CODE_RETURN,
    CODE_DEC,
    CODE_ARG,
    CODE_CALL,
    CODE_PARAM,
    CODE_READ,
    CODE_WRITE
};

typedef struct Operand
{
    int size;
    int offset;
    enum OperandType kind;
    union
    {
        int value;
        const char *name;
        int num;
    };
    struct Operand *next;
} Operand;

typedef struct IRCode
{
    enum CodeType kind;
    union
    {
        struct
        {
            struct Operand label;
        } label;
        struct
        {
            struct Operand function;
            Operand* table;
        } function;
        struct
        {
            struct Operand left, right;
        } assign, getaddr, load, save;
        struct
        {
            struct Operand op1, op2, result;
        } binop;
        struct
        {
            struct Operand destination;
        } jmp;
        struct
        {
            struct Operand op1, relop, op2, destination;
        } jmp_relop;
        struct
        {
            struct Operand retval;
        } ret;
        struct
        {
            struct Operand variable;
            int size;
        } dec;
        struct
        {
            struct Operand result, function;
        } call;
        struct
        {
            struct Operand variable;
        } arg, param, read, write;
    };
    struct IRCode *prev, *next;
} IRCode;

typedef struct IRCodeList
{
    struct IRCode *head, *end;
} IRCodeList;

typedef struct IRCodePair
{
    struct IRCodeList list;
    struct Operand op;
    pType type;
} IRCodePair;

void initcodelist();

void iroutput();
void outputcodelist(IRCodeList *x);
void outputcode(IRCode *temp);
void outputoperand(Operand *temp);

Operand newint(int temp);
IRCode *newcode(enum CodeType f);
Operand newvar(char *name, bool dec);
Operand newtemp();
Operand newno();
Operand newlabel();
Operand newrelop(char *name);
Operand newfunction(char *name);

IRCodeList mergelist(IRCodeList lista, IRCodeList listb);
IRCodeList IRAppendCode(IRCodeList list, IRCode *code);

IRCodeList translate_Args(Node* args,IRCodeList* arg_list,FieldList a);
IRCodeList Translate_CompSt(Node* compst);
IRCodeList Translate_Dec(Node* dec);
IRCodeList Translate_Declist(Node* declist);
IRCodeList Translate_Def(Node* def);
IRCodeList Translate_Deflist(Node* deflist);
IRCodeList Translate_Stmtlist(Node* stmtlist);
IRCodePair Translate_Exp(Node *exp, Operand place, bool deref);
IRCodeList Translate_cond(Node *exp,Operand lab1,Operand lab2);
IRCodeList Translate_stmt(Node *stmt);

void IRFunDec(Node *fundec);
void IRCompSt(Node *compst);
void IRDefList(Node *deflist);
void IRStmtList(Node *stmtlist);
void IRALL(Node *fundec, Node *compst);

int calustruct(FieldList s);
int caluarray(pType s);
#endif