#include "hashtable.h"
unsigned int hash_pjw(char *name)
{
    unsigned int val = 0, i;
    for (; *name; ++name)
    {
        val = (val << 2) + *name;
        if (i = val & ~0x3fff)
            val = (val ^ (i >> 12)) & 0x3fff;
    }
    return val;
}
Stack initstack()
{
    Stack x;
    x.stacklist = (item *)malloc(sizeof(item) * 0x3fff);
    for (int i = 0; i < 0x3fff; i++)
    {
        x.stacklist[i] = NULL;
    }
    x.stacknum = 0;
    return x;
}
void clearStack()
{
    item temp = stack.stacklist[stack.stacknum];
    while (temp)
    {
        item t = temp;
        temp = temp->nextHash;
        deletetableitem(table, t);
    }
    stack.stacklist[stack.stacknum] = NULL;
    stack.stacknum--;
}
FieldList newFieldList(char *Name, pType mytype)
{
    FieldList temp = (FieldList)malloc(sizeof(struct FieldList_));
    temp->name = Name;
    temp->type = mytype;
    temp->tail = NULL;
    return temp;
}
int checkfuntion(FieldList one, FieldList two, pType one1, pType two2)
{
    if (checkType(one1, two2) == 0)
    {
        return 0;
    }
    else
    {
        if (!one && !two)
            return 1;
        while (one && two)
        {
            if (checkType(one->type, two->type) == 0)
                return 0;
            one = one->tail;
            two = two->tail;
        }
        if (!one && !two)
            return 1;
        else
            return 0;
    }
}
int checkstruct(FieldList one, FieldList two)
{
    if (!one && !two)
        return 1;
    while (one && two)
    {
        if (checkType(one->type, two->type) == 0)
            return 0;
        one = one->tail;
        two = two->tail;
    }
    if (!one && !two)
        return 1;
    else
        return 0;
}
int checkType(pType type1, pType type2)
{
    if (type1 == NULL || type2 == NULL)
        return 0;
    if (type1->kind != type2->kind)
        return 0;
    else
    {
        switch (type1->kind)
        {
        case BASIC:
            return (type1->u.basic == type2->u.basic) ? 1 : 0;
        case ARRAY:
            return checkType(type1->u.array.elem, type2->u.array.elem);
        case STRUCTURE:
        {
            return checkstruct(type1->u.structure, type2->u.structure);
        }
        case FUNCTION:
        {
            return checkfuntion(type1->u.function.args, type2->u.function.args, type1->u.function.returntype, type1->u.function.returntype);
        }
        }
    }
}
void deletetableitem(HashTable table, item self)
{
    unsigned num = hash_pjw(self->field->name);
    item temp = table.hashlist[num];
    item cur = temp;
    if (temp == self)
    {
        table.hashlist[num] = temp->nextHash;
        return;
    }
    while (temp != self)
    {
        cur = temp;
        temp = temp->nextHash;
    }
    cur->nextHash = temp->nextHash;
    return;
}
item newItem(FieldList field)
{
    item temp = (item)malloc(sizeof(struct item_));
    temp->field = field;
    temp->nextHash = NULL;
    temp->depth = stack.stacknum;
    temp->num=0;
    temp->isaddr=false;
    return temp;
}
void addItem(HashTable table, item newitem)
{
    unsigned num = hash_pjw(newitem->field->name);
    newitem->nextHash = table.hashlist[num];
    table.hashlist[num] = newitem;
}
void changeitem(HashTable table, char *name)
{
    unsigned num = hash_pjw(name);
    item temp = table.hashlist[num];
    while (temp)
    {
        if (!strcmp(temp->field->name, name))
        {
            temp->value = 0;
            return;
        }
        temp = temp->nextHash;
    }
    return;
}
HashTable inithashtable()
{
    HashTable x;
    x.hashlist = (item *)malloc(sizeof(item) * 0x3fff);
    for (int i = 0; i < 0x3fff; i++)
    {
        x.hashlist[i] = NULL;
    }
    return x;
}
item searchTableItem(HashTable table, char *name)
{
    unsigned num = hash_pjw(name);
    item temp = table.hashlist[num];
    if (temp == NULL)
        return NULL;
    while (temp)
    {
        if (!strcmp(temp->field->name, name))
            return temp;
        temp = temp->nextHash;
    }
    return NULL;
}
int checkTableitem(HashTable table, item newitem)
{
    if (newitem == NULL)
        return 0;
    item temp = searchTableItem(table, newitem->field->name);
    if (temp == NULL)
        return 0;
    else
    {
        while (temp)
        {
            if (!strcmp(temp->field->name, newitem->field->name))
            {
                if(newitem->field->type->kind==STRUCTURE||temp->field->type->kind==STRUCTURE) return 1;
                if(newitem->depth==temp->depth) return 1;
            }
            temp = temp->nextHash;
        }
        return 0;
    }
}