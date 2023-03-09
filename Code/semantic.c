#include "semantic.h"
void visittable()
{
    HashTable x = declaretable;
    for (int i = 0; i < 0x3fff; i++)
    {
        if (x.hashlist[i] != NULL)
        {
            item temp = x.hashlist[i];
            while (temp)
            {
                if (temp->value == 0)
                {
                    char msg[20] = " Undefined function";
                    printError(18, temp->line, msg);
                }
                temp = temp->nextHash;
            }
        }
    }
}
void visit(Node *root)
{
    if (root == NULL)
        return;
    if (!strcmp(root->name, "ExtDef"))
    {
        ExtDef(root);
    }
    visit(root->child);
    visit(root->next);
}
void printError(int errortype, int line, char *msg)
{
    printf("Error type %d at Line %d: %s\n", errortype, line, msg);
}
void readfun(){
    item temp = newItem(newFieldList("read", NULL));
    pType functype = (pType)malloc(sizeof(struct Type_));
    functype->kind = FUNCTION;
    pType returntype = (pType)malloc(sizeof(struct Type_));
    returntype->kind = BASIC;
    returntype->u.basic = 0;
    functype->u.function.returntype = returntype;
    functype->u.function.args = NULL;
    temp->field->type = functype;
    addItem(functiontable,temp);
}
void writefun(){
    item temp = newItem(newFieldList("write", NULL));
    pType functype = (pType)malloc(sizeof(struct Type_));
    functype->kind = FUNCTION;
    pType returntype = (pType)malloc(sizeof(struct Type_));
    returntype->kind = BASIC;
    returntype->u.basic = 0;
    functype->u.function.returntype = returntype;
    functype->u.function.args = newFieldList("writeparam", returntype);
    temp->field->type = functype;
    addItem(functiontable,temp);
}

void ExtDef(Node *node)
{
    // ExtDef -> Specifier ExtDecList SEMI
    //| Specifier SEMI
    //| Specifier FunDec CompSt
    //| Specifier FunDec SEMI
    pType specifierType = Specifier(node->child);
    char *name = node->child->next->name;
    if (!strcmp(name, "ExtDecList"))
    {
        ExtDecList(node->child->next, specifierType);
    }
    else
    {
        if (!strcmp(name, "FunDec"))
        {
            FunDec(node->child->next, specifierType);
            IRFunDec(node->child->next); //entry to lab3
            if (!strcmp(node->child->next->next->name, "CompSt"))
            {
                CompSt(node->child->next->next, specifierType);
                //IRCompSt(node->child->next->next);
                IRALL(node->child->next,node->child->next->next);
                clearStack();
            }
            else
            {
                return;
            }
        }
        else
        {
            return;
        }
    }
}
void ExtDecList(Node *node, pType specifier)
{
    // ExtDecList -> VarDec
    // VarDec COMMA ExtDecList
    Node *s = node;
    while (s)
    {
        item definesymbol = VarDec(s->child, specifier);
        if (checkTableitem(table, definesymbol) == 1)
        {
            char msg[20] = "redefined var";
            printError(3, node->line, msg);
        }
        else
        {
            addItem(table, definesymbol);
        }
        if (s->child->next)
            s = s->child->next->next;
        else
            break;
    }
}
void FunDec(Node *node, pType specifier)
{
    // FunDec: ID LP VarList RP
    //| ID LP RP
    Node *xchild = node->child;
    item temp = newItem(newFieldList(xchild->str, NULL));
    pType x = (pType)malloc(sizeof(struct Type_));
    x->kind = FUNCTION;
    x->u.function.returntype = specifier;
    if (xchild->next->next->next)
    {
        x->u.function.args = VarList(xchild->next->next);
    }
    else
    {
        x->u.function.args = NULL;
    }
    temp->field->type = x;
    if (!strcmp(node->next->name, "CompSt"))
    {
        //函数定义
        if (checkTableitem(declaretable, temp) == 1)
        {
            item s = searchTableItem(declaretable, temp->field->name);
            if (checkType(s->field->type, temp->field->type) == 0)
            {
                char msg[50] = "declare different define";
                printError(19, node->line, msg);
            }
            else
            {
                changeitem(declaretable, temp->field->name);
                s->value = 1;
            }
        }
        if (checkTableitem(functiontable, temp) == 1)
        {
            char msg[20] = "redefined function";
            printError(4, node->line, msg);
        }
        else
            addItem(functiontable, temp);
    }
    else
    {
        //函数声明
        if (checkTableitem(declaretable, temp) == 1)
        {
            item s = searchTableItem(declaretable, temp->field->name);
            if (checkType(s->field->type, temp->field->type) == 0)
            {
                char msg[50] = "redeclare different function";
                printError(19, node->line, msg);
            }
        }
        else
        {
            temp->line = node->line;
            temp->value = 0;
            item s = searchTableItem(functiontable, temp->field->name);
            if(s==NULL) {
                addItem(declaretable, temp);
                stack.stacknum++;
                clearStack();
                return;
            }
            if(checkType(s->field->type, temp->field->type) == 1) temp->value = 1;
            else{
                char msg[50] = "redeclare different function";
                printError(19, node->line, msg);
            }
            addItem(declaretable, temp);
            stack.stacknum++;
            clearStack();
        }
    }
}
void CompSt(Node *node, pType returntype)
{
    // CompSt :LC DefList StmtList RC
    Node *s = node->child->next;
    stack.stacknum++;
    if (!strcmp(s->name, "DefList"))
    {
        DefList(s, NULL);
        IRDefList(s);
        s = s->next;
    }
    if (!strcmp(s->name, "_DefList"))
        s = s->next;
    if (!strcmp(s->name, "StmtList"))
    {
        StmtList(s, returntype);
        IRStmtList(s);
    }
    IRCompSt(node);
    //clearStack();
}
void StmtList(Node *node, pType returntype)
{
    /*StmtList → Stmt StmtList
| */
    while (node->child)
    {
        Stmt(node->child, returntype);
        node = node->child->next;
    }
}
void Stmt(Node *node, pType returntype)
{
    /*Stmt → Exp SEMI
| CompSt
| RETURN Exp SEMI
| IF LP Exp RP Stmt
| IF LP Exp RP Stmt ELSE Stmt
| WHILE LP Exp RP Stmt*/
    pType type = NULL;
    if (!strcmp(node->child->name, "Exp"))
        type = Exp(node->child);
    else if (!strcmp(node->child->name, "CompSt")){
        CompSt(node->child, returntype);
        //clearStack();
        stack.stacknum--;
    }
    else if (!strcmp(node->child->name, "RETURN"))
    {
        type=Exp(node->child->next);
        if (checkType(returntype, type) == 0)
        {
            char msg[20] = "returntype error";
            printError(8, node->line, msg);
        }
    }
    else if (!strcmp(node->child->name, "IF"))
    {
        Node *mynext = node->child->next->next->next->next;
        type = Exp(node->child->next->next);
        Stmt(mynext, returntype);
        // Stmt:IF LP Exp RP Stmt ELSE Stmt
        if (mynext->next != NULL)
            Stmt(mynext->next->next, returntype);
    }
    else if (!strcmp(node->child->name, "WHILE"))
    {
        type = Exp(node->child->next->next);
        Stmt(node->child->next->next->next->next, returntype);
    }
}
item VarDec(Node *node, pType specifier)
{
    // VarDec -> ID
    // VarDec LB INT RB
    Node *xchild = node->child;
    if (!strcmp(xchild->name, "ID"))
    {
        item temp = newItem(newFieldList(xchild->str, specifier));
        return temp;
    }
    else
    {
        Node *varDec = node->child;
        while (xchild->child)
            xchild = xchild->child;
        item temp = newItem(newFieldList(xchild->str, NULL));
        pType chance = specifier;
        while (varDec->next)
        {
            pType x = (pType)malloc(sizeof(struct Type_));
            x->kind = ARRAY;
            x->u.array.size = varDec->next->next->intval;
            x->u.array.elem = chance;
            temp->field->type = x;
            chance = x;
            varDec = varDec->child;
        }
        return temp;
    }
}
FieldList VarList(Node *node)
{
    // VarList:ParamDec COMMA VarList
    // ParamDec
    stack.stacknum++;
    Node *x = node->child;
    FieldList y = ParamDec(x);
    FieldList temp = y;
    while (x->next)
    {
        x = x->next->next->child;
        FieldList c = ParamDec(x);
        if (c != NULL)
        {
            temp->tail = c;
            temp = temp->tail;
        }
        // temp->tail=NULL;
        // if(temp->tail!=NULL) temp = temp->tail;
    }
    stack.stacknum--;
    return y;
}
FieldList ParamDec(Node *node)
{
    // ParamDec :Specifier VarDec
    pType specifierType = Specifier(node->child);
    item temp = VarDec(node->child->next, specifierType);
    if (checkTableitem(table, temp) == 1)
    {
        char msg[20] = "redefined var";
        printError(3, node->line, msg);
        return NULL;
    }
    else
    {
        addItem(table, temp);
        temp->nextHash = stack.stacklist[stack.stacknum];
        stack.stacklist[stack.stacknum] = temp;
        return temp->field;
    }
}
pType Specifier(Node *node)
{
    // Specifier: TYPE
    // StructSpecifier
    Node *p = node->child;
    if (!strcmp(p->name, "TYPE"))
    {
        pType type = (pType)malloc(sizeof(struct Type_));
        type->kind = BASIC;
        if (!strcmp(p->str, "int"))
        {
            type->u.basic = 0;
        }
        else
        {
            type->u.basic = 1;
        }
        return type;
    }
    else
    {
        pType type = StructSpecifier(p);
        return type;
    }
}
pType StructSpecifier(Node *node)
{
    // StructSpecifier: STRUCT OptTag LC DefList RC
    //| STRUCT Tag
    pType x = (pType)malloc(sizeof(struct Type_));
    x->kind = STRUCTURE;
    item structitem = newItem(newFieldList("", x));
    Node *p = node->child->next;
    if (!strcmp(p->name, "Tag"))
    {
        item mystruct = searchTableItem(table, p->child->str);
        if (mystruct == NULL || mystruct->field->type->kind != STRUCTURE)
        {
            char msg[20] = "Undefined structure";
            printError(17, node->line, msg);
        }
        else
        {
            x->u.structure = mystruct->field->type->u.structure;
        }
    }
    else
    {
        if (!strcmp(p->name, "OptTag"))
        {
            structitem->field->name = p->child->str;
            p = p->next;
        }
        else
        {
            p=p->next;
            char name[50] = "without_name\0";
            structitem->field->name = name;
        }
        DefList(p->next, structitem);
        if (checkTableitem(table, structitem) == 1)
        {
            char msg[20] = " Duplicated name";
            printError(16, node->line, msg);
        }
        else
        {
            x->u.structure = structitem->field->type->u.structure;
        }
        if (!strcmp(node->child->next->name, "OptTag"))
        {
            addItem(table, structitem);
        }
    }
    return x;
}
void DefList(Node *node, item structitem)
{
    // DefList：Def DefList
    //|
    while (node->child)
    {
        Def(node->child, structitem);
        node = node->child->next;
    }
}
void Def(Node *node, item structitem)
{
    // Def:Specifier DecList SEMI
    pType Specifiertype = Specifier(node->child);
    DecList(node->child->next, Specifiertype, structitem);
}
void DecList(Node *node, pType specifier, item structitem)
{
    /*DecList → Dec
| Dec COMMA DecList*/
    while (node->child)
    {
        Dec(node->child, specifier, structitem);
        if (node->child->next)
            node = node->child->next->next;
        else
            break;
    }
}
void Dec(Node *node, pType specifier, item structitem)
{
    /*Dec → VarDec
| VarDec ASSIGNOP Exp*/
    // item VarDec(Node* node, Type specifier)
    item temp = VarDec(node->child, specifier);
    if (node->child->next)
    {
        if (structitem != NULL)
        {
            char msg[50] = "struct illegal define";
            printError(15, node->line, msg);
        }
        else
        {
            pType exptype = Exp(node->child->next->next);
            if (checkTableitem(table, temp) == 1)
            {
                char msg[20] = "redefined var";
                printError(3, node->line, msg);
            }
            if (checkType(temp->field->type, exptype) == 0)
            {
                char msg[20] = "type error";
                printError(5, node->line, msg);
            }
            if (temp->field->type && temp->field->type->kind == ARRAY)
            {
                char msg[20] = "type error";
                printError(5, node->line, msg);
            }
            else
            {
                addItem(table, temp);
                temp->nextHash = stack.stacklist[stack.stacknum];
                stack.stacklist[stack.stacknum] = temp;
            }
        }
    }
    else
    {
        if (structitem != NULL)
        {
            FieldList fieldnum = temp->field;
            FieldList structnum = structitem->field->type->u.structure;
            FieldList structtail = NULL;
            while (structnum != NULL)
            {
                if (!strcmp(fieldnum->name, structnum->name))
                {
                    char msg[20] = "redefined field";
                    printError(15, node->line, msg);
                    return;
                }
                else
                {
                    structtail = structnum;
                    structnum = structnum->tail;
                }
            }
            if (structtail == NULL)
            {
                structitem->field->type->u.structure = temp->field;
            }
            else
            {
                structtail->tail = temp->field;
            }
        }
        else
        {
            if (checkTableitem(table, temp) == 1)
            {
                char msg[20] = "redefined var";
                printError(3, node->line, msg);
                return;
            }
            else
            {
                addItem(table, temp);
            }
        }
    }
}
pType Exp(Node *node)
{
    /*Exp → Exp ASSIGNOP Exp
| Exp AND Exp
| Exp OR Exp
| Exp RELOP Exp
| Exp PLUS Exp
| Exp MINUS Exp
| Exp STAR Exp
| Exp DIV Exp
| LP Exp RP
| MINUS Exp
| NOT Exp
| ID LP Args RP
| ID LP RP
| Exp LB Exp RB
| Exp DOT ID
| ID
| INT
| FLOAT*/
    Node *t = node->child;
    pType returntype = NULL;
    if (!strcmp(t->name, "Exp"))
    {
        if (strcmp(t->next->name, "LB") && strcmp(t->next->name, "DOT"))
        {
            pType exp1 = Exp(t);
            pType exp2 = Exp(t->next->next);
            if (!strcmp(t->next->name, "ASSIGNOP"))
            {
                Node *p = t->child;
                if (!strcmp(p->name, "FLOAT") || !strcmp(p->name, "INT"))
                {
                    char msg[50] = "right val in error location";
                    printError(6, node->line, msg);
                }
                else
                {
                    if ((!strcmp(p->name, "ID")&&p->next==NULL) || !strcmp(p->next->name, "LB") || !strcmp(p->next->name, "DOT"))
                    {
                        if (checkType(exp1, exp2) == 0)
                        {
                            char msg[20] = "type error";
                            printError(5, node->line, msg);
                        }
                        else
                        {
                            returntype = exp1;
                        }
                    }
                    else
                    {
                        char msg[50] = "right val in error location";
                        printError(6, node->line, msg);
                    }
                }
            }
            else
            {
                if (exp1 && exp2 && (exp1->kind == ARRAY || exp2->kind == ARRAY))
                {
                    char msg[20] = "type error";
                    printError(5, node->line, msg);
                }
                else
                {
                    if (checkType(exp1, exp2) == 0)
                    {
                        char msg[20] = "type error";
                        printError(7, node->line, msg);
                    }
                    else
                    {
                        if (exp1 && exp2){
                            if(!strcmp(t->next->name, "AND")||!strcmp(t->next->name, "OR")||!strcmp(t->next->name, "RELOP")){
                                pType d = (pType)malloc(sizeof(struct Type_));
                                d->kind = BASIC;
                                d->u.basic=0;
                                return d;
                            }
                        else returntype = exp1;
                        }
                    }
                }
            }
            return returntype;
        }
        else
        {
            if (!strcmp(t->next->name, "LB"))
            {
                pType exp1 = Exp(t);
                pType exp2 = Exp(t->next->next);
                if(!exp1||!exp2){
                    char msg[20] = "NO ARRAY";
                    printError(10, node->line, msg);
                    return returntype;
                }
                if (exp1->kind != ARRAY)
                {
                    char msg[20] = "NO ARRAY";
                    printError(10, node->line, msg);
                }
                else if (exp2->u.basic != 0 || exp2->kind != BASIC)
                {
                    char msg[20] = "NO int";
                    printError(12, node->line, msg);
                }
                else
                    returntype = exp1->u.array.elem;
                return returntype;
            }
            else
            {
                pType exp = Exp(t);
                if (exp->kind != STRUCTURE)
                {
                    char msg[20] = "illegal use .";
                    printError(13, node->line, msg);
                }
                else
                {
                    Node *s = t->next->next;
                    FieldList structfield = exp->u.structure;
                    while (structfield)
                    {   
                        if (!strcmp(structfield->name, s->str))
                        {
                            break;
                        }
                        structfield = structfield->tail;
                    }
                    if (structfield == NULL)
                    {
                        char msg[40] = "illegal search struct.";
                        printError(14, node->line, msg);

                    }
                    else
                    {
                        return structfield->type;
                    }
                }
                return returntype;
            }
        }
    }
    else if (!strcmp(t->name, "LP"))
    {
        return Exp(t->next);
    }
    else if (!strcmp(t->name, "MINUS") || !strcmp(t->name, "NOT"))
    {
        pType exp = Exp(t->next);
        if (exp->kind != BASIC)
        {
            char msg[20] = "illegal exp use";
            printError(7, node->line, msg);
        }
        else
        {
            return exp;
        }
    }
    else if (!strcmp(t->name, "ID") && t->next)
    {
        item temp = searchTableItem(functiontable, t->str);
        item temp2 = searchTableItem(table, t->str);
        if (checkTableitem(functiontable, temp) == 0 && temp2 == NULL)
        {
            char msg[20] = "undefined function";
            printError(2, node->line, msg);
            return NULL;
        }
        if (!temp || temp->field->type->kind != FUNCTION)
        {
            char msg[20] = "not function";
            printError(11, node->line, msg);
            return NULL;
        }
        if (!strcmp(t->next->next->name, "Args"))
        {
            Args(t->next->next, temp);
            return temp->field->type->u.function.returntype;
        }
        else
        {
            if (temp->field->type->u.function.args != NULL)
            {
                char msg[20] = "argc num error";
                printError(9, node->line, msg);
            }
            return temp->field->type->u.function.returntype;
        }
    }
    else if (!strcmp(t->name, "ID"))
    {
        item temp = searchTableItem(table, t->str);
        if (checkTableitem(table, temp) == 0)
        {
            char msg[20] = "undefined var";
            printError(1, node->line, msg);
            return NULL;
        }
        else
            return temp->field->type;
    }
    else
    {
        pType p = (pType)malloc(sizeof(struct Type_));
        if (!strcmp(t->name, "INT"))
        {
            p->kind = BASIC;
            p->u.basic = 0;
        }
        else
        {
            p->kind = BASIC;
            p->u.basic = 1;
        }
        return p;
    }
}
void Args(Node *node, item number)
{
    FieldList funnumber = number->field->type->u.function.args;
    while (node)
    {
        if (funnumber == NULL)
        {
            char msg[20] = "argc num error";
            printError(9, node->line, msg);
            break;
        }
        pType x = Exp(node->child);
        if (checkType(x, funnumber->type) == 0)
        {
            char msg[20] = "argc num error";
            printError(9, node->line, msg);
            return;
        }
        funnumber = funnumber->tail;
        if (node->child->next)
        {
            node = node->child->next->next;
        }
        else
            break;
    }
    if (funnumber != NULL)
    {
        char msg[20] = "argc num error";
        printError(9, node->line, msg);
    }
}