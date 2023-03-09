#include "ir.h"
IRCodeList mycodelist;
static const IRCodeList empty_list = {NULL, NULL};
int varnum = 0;
int labelnum = 0;
int tempnum = 0;
void initcodelist()
{
    mycodelist.head = NULL;
    mycodelist.end = NULL;
}
void iroutput()
{
    outputcodelist(&mycodelist);
}
void outputcodelist(IRCodeList *x)
{
    IRCode *temp = x->head;
    if (temp == NULL)
        return;
    else
    {
        do
        {
            outputcode(temp);
            temp = temp->next;
            printf("\n");
        } while (temp && temp->prev != x->end);
    }
}
void outputcode(IRCode *temp)
{
    switch (temp->kind)
    {
    case CODE_LABEL:
    {
        printf("LABEL ");
        outputoperand(&temp->label.label);
        printf(" :");
        break;
    }
    case CODE_FUNCTION:
    {
        printf("FUNCTION ");
        outputoperand(&temp->function.function);
        printf(" :");
        break;
    }
    case CODE_ASSIGN:
    {
        outputoperand(&temp->assign.left);
        printf(" := ");
        outputoperand(&temp->assign.right);
        break;
    }
    case CODE_ADD:
    case CODE_SUB:
    case CODE_MUL:
    case CODE_DIV:
    {
        outputoperand(&temp->binop.result);
        printf(" := ");
        outputoperand(&temp->binop.op1);
        printf(" ");
        char op;
        switch (temp->kind)
        {
        case CODE_ADD:
            op = '+';
            break;
        case CODE_SUB:
            op = '-';
            break;
        case CODE_MUL:
            op = '*';
            break;
        case CODE_DIV:
            op = '/';
            break;
        default:
            assert(0);
        }
        printf("%c ", op);
        outputoperand(&temp->binop.op2);
        break;
    }
    case CODE_GETADDR:
    {
        outputoperand(&temp->getaddr.left);
        printf(" := & ");
        outputoperand(&temp->getaddr.right);
        break;
    }
    case CODE_LOAD:
    {
        outputoperand(&temp->load.left);
        printf(" := *");
        outputoperand(&temp->load.right);
        break;
    }
    case CODE_SAVE:
    {
        printf("*");
        outputoperand(&temp->save.left);
        printf(" := ");
        outputoperand(&temp->load.right);
        break;
    }
    case CODE_GOTO:
    {
        printf("GOTO ");
        outputoperand(&temp->jmp.destination);
        break;
    }
    case CODE_GOTO_RELOP:
    {
        printf("IF ");
        outputoperand(&temp->jmp_relop.op1);
        printf(" ");
        outputoperand(&temp->jmp_relop.relop);
        printf(" ");
        outputoperand(&temp->jmp_relop.op2);
        printf(" GOTO ");
        outputoperand(&temp->jmp_relop.destination);
        break;
    }
    case CODE_RETURN:
    {
        printf("RETURN ");
        outputoperand(&temp->ret.retval);
        break;
    }
    case CODE_DEC:
    {
        printf("DEC ");
        outputoperand(&temp->dec.variable);
        printf(" ");
        printf("%d", temp->dec.size);
        break;
    }
    case CODE_ARG:
    {
        printf("ARG ");
        outputoperand(&temp->arg.variable);
        break;
    }
    case CODE_CALL:
    {
        outputoperand(&temp->call.result);
        printf(" := CALL ");
        outputoperand(&temp->call.function);
        break;
    }
    case CODE_PARAM:
    {
        printf("PARAM ");
        outputoperand(&temp->param.variable);
        break;
    }
    case CODE_READ:
    {
        printf("READ ");
        outputoperand(&temp->read.variable);
        break;
    }
    case CODE_WRITE:
    {
        printf("WRITE ");
        outputoperand(&temp->write.variable);
        break;
    }
    }
}
void outputoperand(Operand *temp)
{
    switch (temp->kind)
    {
    case OP_CONSTANT:
        printf("#%d", temp->value);
        break;
    case OP_VARIABLE:
        printf("v%d", temp->num);
        break;
    case OP_TEMP:
        printf("t%d", temp->num);
        break;
    case OP_ADDRESS:
        printf("&v%d", temp->num);
        break;
    case OP_LABEL:
        printf("label%d", temp->num);
        break;
    case OP_FUNCTION:
        printf("%s", temp->name);
        break;
    case OP_RELOP:
        printf("%s", temp->name);
        break;
    default: printf("no");break;
    }
}
Operand newint(int temp)
{
    Operand x;
    x.kind = OP_CONSTANT;
    x.value = temp;
    x.size = 4;
    return x;
}
IRCode *newcode(enum CodeType f)
{
    IRCode *x = (IRCode *)malloc(sizeof(struct IRCode));
    x->kind = f;
    x->prev = x->next = NULL;
    return x;
}
Operand newvar(char *name, bool dec)
{
    item res = searchTableItem(table, name);
    if (res->num == 0) res->num = ++varnum;
    Operand ret;
    if (res->field->type->kind == BASIC)
    {
        ret.size = 4;
        ret.num = res->num;
        ret.kind = OP_VARIABLE;
    }
    else
    {
        if(res->field->type->kind==ARRAY){
            ret.size = caluarray(res->field->type);
        }
        else ret.size = calustruct(res->field);
        ret.num = res->num;
        if (dec)
        {
            ret.kind = OP_VARIABLE;
            res->isaddr = true;
        }
        else if (res->isaddr == false)
            ret.kind = OP_VARIABLE;
        else
            ret.kind = OP_ADDRESS;
    }
    return ret;
}
Operand newtemp()
{
    Operand temp;
    temp.kind = OP_TEMP;
    temp.size = 4;
    temp.num = ++tempnum;
    return temp;
}
Operand newno()
{
    Operand temp;
    temp.kind = NO;
    temp.size = 0;
    return temp;
}
Operand newlabel()
{
    Operand temp;
    temp.kind = OP_LABEL;
    temp.size = 0;
    temp.num = ++labelnum;
    return temp;
}
Operand newrelop(char *name)
{
    Operand temp;
    temp.kind = OP_RELOP;
    temp.size = 0;
    temp.name = name;
    return temp;
}
Operand newfunction(char *name){
    Operand temp;
    temp.kind = OP_FUNCTION;
    temp.size = 4;
    temp.name = name;
    return temp;
}
IRCodeList IRAppendCode(IRCodeList list, IRCode *code)
{
    if (list.head == NULL)
    {
        list.head = code;
        list.end = code;
    }
    else
    {
        list.end->next = code;
        code->prev = list.end;
        list.end = code;
    }
    return list;
}
IRCodeList mergelist(IRCodeList lista, IRCodeList listb)
{
    if (lista.head == NULL)
    {
        return listb;
    }
    if (listb.head == NULL)
    {
        return lista;
    }
    lista.end->next = listb.head;
    listb.head->prev = lista.end;
    lista.end = listb.end;
    return lista;
}
int caluarray(pType s)
{
    //printf("%d\n",s->u.array.elem->kind);
    int p = 1;
    while (s)
    {
        if (s->kind == 0) break;
        if(s->kind == 2) {
            return p*calustruct(s->u.structure);
        }
        p = p * s->u.array.size;
        s = s->u.array.elem;
    }
    return p * 4;
}
int calustruct(FieldList s)
{
    int p = 0;
    while (s)
    {
        if (s->type->kind == BASIC)
        {
            p = p + 4;
        }
        else
        {
            if (s->type->kind == STRUCTURE)
            {
                p = p + calustruct(s->type->u.structure);
            }
            else
            {
                p = p + caluarray(s->type);
            }
        }
        s = s->tail;
    }
    return p;
}
IRCodePair Translate_Exp(Node *exp, Operand place, bool deref)
{
    IRCodePair ret;
    ret.list = empty_list;
    ret.op = newno();
    ret.type = NULL;
    Node *e1 = exp->child;
    Node *e2 = e1->next;
    Node *e3 = e2 ? e2->next : NULL;
    if (!strcmp(e1->name, "INT"))
    {
        Operand op = newint(e1->intval);
        IRCode *code = newcode(CODE_ASSIGN);
        code->assign.left = place;
        code->assign.right = op;
        ret.list = IRAppendCode(ret.list, code);
    }
    else if (e2 == NULL && !strcmp(e1->name, "ID"))
    {
        if (place.kind == NO) place = newno();
        Operand op = newvar(e1->str, false);
        IRCode *code = newcode(CODE_ASSIGN);
        code->assign.left = place;
        code->assign.right = op;
        ret.list = IRAppendCode(ret.list, code);
        ret.type = searchTableItem(table, e1->str)->field->type;
        ret.op = op;
    }
    else if (e2 && !strcmp(e2->name, "ASSIGNOP"))
    {
        if (!strcmp(e1->child->name, "ID"))
        {
            Operand v = newvar(e1->child->str, false);
            IRCode *code = newcode(CODE_ASSIGN);
            Operand t = newtemp();
            IRCodePair pair = Translate_Exp(e3, t, true);
            ret.list = mergelist(ret.list, pair.list);
            code->assign.left = v;
            code->assign.right = t;
            ret.list = IRAppendCode(ret.list, code);

            if (place.kind != NO)
            {
                code = newcode(CODE_ASSIGN);
                code->assign.left = place;
                code->assign.right = v;
                ret.list = IRAppendCode(ret.list, code);
            }
            ret.op = t;
            ret.type = pair.type;
        }
        else{
            Operand addr = newtemp();
            Operand t1 = newtemp();
            IRCodePair pair1 = Translate_Exp(e1, addr, false);
            IRCode *code = newcode(CODE_SAVE);
            code->save.left = addr;
            code->save.right = t1;
            IRCodePair pair2 = Translate_Exp(e3, t1, true);
            ret.list = mergelist(ret.list, pair2.list);
            ret.list = mergelist(ret.list, pair1.list);
            ret.list = IRAppendCode(ret.list, code);
            if (place.kind != NO) {
                code = newcode(CODE_ASSIGN);
                code->assign.left = place;
                code->assign.right = t1;
                ret.list = IRAppendCode(ret.list, code);
            }
            ret.op = t1;
            ret.type = pair1.type;
        }
    }
    else if (e2&& (!strcmp(e2->name, "PLUS")||!strcmp(e2->name, "MINUS")||!strcmp(e2->name, "DIV")||!strcmp(e2->name, "STAR")))
    {
        Operand t1 = newtemp();
        Operand t2 = newtemp();
        IRCodePair pair1 = Translate_Exp(e1, t1, true);
        IRCodePair pair2 = Translate_Exp(e3, t2, true);
        if (place.kind != NO) {
            IRCode * code;
            if(!strcmp(e2->name, "PLUS")){
                code = newcode(CODE_ADD);
            }
            else if(!strcmp(e2->name, "MINUS")){
                code = newcode(CODE_SUB);
            }
            else if(!strcmp(e2->name, "DIV")){
                code = newcode(CODE_DIV);
            }
            else if(!strcmp(e2->name, "STAR")){
                code = newcode(CODE_MUL);
            }
            code->binop.op1 = t1;
            code->binop.op2 = t2;
            code->binop.result = place;
            ret.list = mergelist(pair1.list,pair2.list);
            ret.list = IRAppendCode(ret.list, code);
        }
    }
    else if(e1&&!strcmp(e1->name, "MINUS")){
        Operand t1 = newtemp();
        IRCodePair pair1 = Translate_Exp(e2, t1, true);
        ret.list = pair1.list;
        if(place.kind != NO){
            IRCode * code = newcode(CODE_SUB);
            code->binop.op1 = newint(0);
            code->binop.op2 = t1;
            code->binop.result = place;
            ret.list = IRAppendCode(ret.list, code);
        }
    }
    else if ((e2&& (!strcmp(e2->name, "AND")||!strcmp(e2->name, "OR")||!strcmp(e2->name, "RELOP")))||!strcmp(e1->name, "NOT")){
        //printf("%d\n",labelnum);
        Operand lab1 = newlabel();
        Operand lab2 = newlabel();
        if (place.kind != NO) {
        IRCode * code = newcode(CODE_ASSIGN);
        code->assign.left = place;
        code->assign.right = newint(0);
        ret.list = IRAppendCode(ret.list, code);
        }
        IRCodeList list = Translate_cond(exp, lab1, lab2);
        ret.list = mergelist(ret.list, list);
        IRCode *code = newcode(CODE_LABEL);
        code->label.label = lab1;
        ret.list = IRAppendCode(ret.list, code);
        if (place.kind != NO) {
            code = newcode(CODE_ASSIGN);
            code->assign.left = place;
            code->assign.right = newint(1);
            ret.list = IRAppendCode(ret.list, code);
        }
        code = newcode(CODE_LABEL);
        code->label.label = lab2;
        ret.list = IRAppendCode(ret.list, code);
    }
    else if(!strcmp(e1->name, "ID")&&e2){
        if (place.kind == NO) place = newno();
        if(e2->next->next){
            item fun = searchTableItem(functiontable,e1->str);
            IRCodeList arg_list = empty_list;
            IRCodeList code1 = translate_Args(e3, &arg_list,fun->field->type->u.function.args);
            if(!strcmp(fun->field->name, "write")){
                ret.list = code1;
                IRCode *code2 = newcode(CODE_WRITE);
                code2->write.variable = arg_list.head->arg.variable;
                ret.list = IRAppendCode(ret.list, code2);
                /*IRCode * code = newcode(CODE_ASSIGN);
                printf("%d\n",place.kind);
                code->assign.left = place;
                code->assign.right = newint(0);
                ret.list = IRAppendCode(ret.list, code);*/
            }
            else{
                ret.list = code1;
                IRCode * code = newcode(CODE_CALL);
                code->call.result = place;
                code->call.function = newfunction(e1->str);
                ret.list = mergelist(ret.list, arg_list);
                ret.list = IRAppendCode(ret.list, code);
                ret.op = place;
            }
        }
        else{
            item fun = searchTableItem(functiontable,e1->str);
            if(!strcmp(fun->field->name, "read")){
                IRCode *code = newcode(CODE_READ);
                code->read.variable = place;
                ret.list = IRAppendCode(ret.list, code);
                ret.op = place;
            }
            else{
                IRCode *code = newcode(CODE_CALL);
                code->call.function = newfunction(e1->str);
                code->call.result = place;
                ret.list = IRAppendCode(ret.list, code);
                ret.op = place;
            }
        }
    }
    else if (!strcmp(e1->name, "LP"))
    {
        return Translate_Exp(e2, place, deref);
    }
    else if(!strcmp(e2->name, "DOT")){
        //printf("%s\n",e1->child->str);
        IRCodePair pair = Translate_Exp(e1, place, false);
        ret.list = mergelist(ret.list, pair.list);
        pType  type = pair.type;
        int offset = 0;
        for (FieldList field = type->u.structure; field != NULL; field = field->tail) {
            if (!strcmp(e3->str, field->name)) {
                type = field->type;
                break;
            }
            switch(field->type->kind){
                case BASIC:offset = offset+4;break;
                case ARRAY:offset = caluarray(field->type);
                case STRUCTURE:offset = calustruct(field->type->u.structure);
            }
        }
        IRCode * code;
        if (offset > 0 && place.kind != NO)
        {
            code = newcode(CODE_ADD);
            code->binop.result = place;
            code->binop.op1 = place;
            code->binop.op2 = newint(offset);
            ret.list = IRAppendCode(ret.list, code);
        }

        if (deref && place.kind != NO)
        {
            code = newcode(CODE_LOAD);
            code->load.left = place;
            code->load.right = place;
            ret.list = IRAppendCode(ret.list, code);
        }
        ret.type = type;
        ret.op = place;
    }
    else if(e2&&!strcmp(e2->name, "LB")){
        IRCodePair pair = Translate_Exp(e1, place, false);
        Operand t1 = newtemp();
        IRCodePair pair2 = Translate_Exp(e3, t1, true);
        ret.list = mergelist(ret.list, pair.list);
        ret.list = mergelist(ret.list, pair2.list);
        
        IRCode * code = newcode(CODE_MUL);
        code->binop.result = t1;
        code->binop.op1 = t1;
        code->binop.op2 = newint(caluarray(pair.type->u.array.elem));
        ret.list = IRAppendCode(ret.list, code);
        ret.type = pair.type->u.array.elem;
        if (place.kind != NO) {
            code = newcode(CODE_ADD);
            code->binop.result = place;
            code->binop.op1 = place;
            code->binop.op2 = t1;
            ret.list = IRAppendCode(ret.list, code);
        }

        if (deref && place.kind != NO) {
            code = newcode(CODE_LOAD);
            code->load.left = place;
            code->load.right = place;
            ret.list = IRAppendCode(ret.list, code);
        }
    }
    return ret;
}
IRCodeList translate_Args(Node* args,IRCodeList* arg_list,FieldList a){
    Operand t = newtemp();
    Node* exp = args->child;
    if(exp->next){
        IRCodeList code1 = Translate_Exp(exp, t,a->type->kind == BASIC).list;
        IRCodeList ret2 = translate_Args(exp->next->next, arg_list, a->tail);
        IRCode *code = newcode(CODE_ARG);
        code->arg.variable = t;
        *arg_list = IRAppendCode(*arg_list, code);
        return mergelist(code1, ret2);
    }
    else{
        IRCodeList code1 = Translate_Exp(exp, t,a->type->kind == BASIC).list;
        IRCode *code = newcode(CODE_ARG);
        code->arg.variable = t;
        *arg_list = IRAppendCode(*arg_list, code);
        return code1;
    }
}
IRCodeList Translate_cond(Node *exp,Operand lab1,Operand lab2){
    IRCodeList ret = empty_list;
    Node *e1 = exp->child;
    Node *e2 = e1->next;
    Node *e3 = e2 ? e2->next : NULL;
    if(e2&&!strcmp(e2->name, "RELOP")){
        Operand t1 = newtemp();
        Operand t2 = newtemp();
        IRCodePair pair1 = Translate_Exp(e1, t1, true);
        IRCodePair pair2 = Translate_Exp(e3, t2, true);
        ret = mergelist(pair1.list, pair2.list);
        IRCode * code = newcode(CODE_GOTO_RELOP);
        code->jmp_relop.op1 = t1;
        code->jmp_relop.op2 = t2;
        code->jmp_relop.relop = newrelop(e2->str);
        code->jmp_relop.destination = lab1;
        ret = IRAppendCode(ret, code);
        code = newcode(CODE_GOTO);
        code->jmp.destination = lab2;
        ret = IRAppendCode(ret, code);
    }
    else if(!strcmp(e1->name, "NOT")){
        return Translate_cond(e2, lab2, lab1);
    }
    else if(e2&&!strcmp(e2->name, "AND")){
        //printf("%d\n",labelnum);
        Operand lab3 = newlabel();
        IRCodeList code1 = Translate_cond(e1, lab3, lab2);
        IRCodeList code2 = Translate_cond(e3, lab1, lab2);
        //printf("%d\n",labelnum);
        ret = code1;
        IRCode* code = newcode(CODE_LABEL);
        code->label.label = lab3;
        ret = IRAppendCode(ret, code);
        ret = mergelist(ret,code2);
    }
    else if(e2&&!strcmp(e2->name, "OR")){
        //printf("%d\n",labelnum);
        Operand lab3 = newlabel();
        IRCodeList code1 = Translate_cond(e1, lab1, lab3);
        IRCodeList code2 = Translate_cond(e3, lab1, lab2);
        ret = code1;
        IRCode* code = newcode(CODE_LABEL);
        code->label.label = lab3;
        ret = IRAppendCode(ret, code);
        ret = mergelist(ret,code2);
    }
    else {
        Operand t1 = newtemp();
        IRCodeList code1 = Translate_Exp(exp, t1,true).list;
        ret = code1;
        IRCode * code = newcode(CODE_GOTO_RELOP);
        code->jmp_relop.op1 = t1;
        code->jmp_relop.op2 = newint(0);
        code->jmp_relop.relop = newrelop("!=");
        code->jmp_relop.destination = lab1;
        ret = IRAppendCode(ret, code);
        code = newcode(CODE_GOTO);
        code->jmp.destination = lab2;
        ret = IRAppendCode(ret, code);
    }
    return ret;
}
IRCodeList Translate_stmt(Node *stmt){
    //if(stmt->child->child->child) printf("%s\n",stmt->child->child->child->name);
    IRCodeList ret = empty_list;
    Node *e1 = stmt->child;
    Node *e2 = e1->next;
    /*if(e1->child){
        if(e1->child->child){
                printf("%s\n",stmt->child->child->child->str);
        }
    } */
    //printf("%s\n",e1->name);
    if(!strcmp(e1->name, "Exp")&&!strcmp(e2->name, "SEMI")){
        ret= Translate_Exp(e1, newno(), false).list;
        return ret;
    }
    else if(!strcmp(e1->name, "CompSt")){
        return  Translate_CompSt(e1);
    }
    else if(!strcmp(e1->name, "RETURN")){
        Operand t1 = newtemp();
        IRCodeList code1 = Translate_Exp(e2, t1,true).list;
        IRCode * code2 = newcode(CODE_RETURN);
        code2->ret.retval = t1;
        ret = code1;
        ret = IRAppendCode(ret, code2);
    }
    else if(!strcmp(e1->name, "IF")){
        if(e1->next->next->next->next->next){
            //printf("%d\n",labelnum);
            Operand label1 = newlabel();
            Operand label2 = newlabel();
            Operand label3 = newlabel();
            IRCodeList code1 = Translate_cond(e1->next->next, label1, label2);
            IRCodeList code2 = Translate_stmt(e2->next->next->next);
            IRCodeList code3 = Translate_stmt(e2->next->next->next->next->next);
            ret = code1;
            IRCode* code4 = newcode(CODE_LABEL);
            code4->label.label = label1;
            ret = IRAppendCode(ret, code4);
            ret = mergelist(ret, code2);
            IRCode* code5 = newcode(CODE_GOTO);
            code5->jmp.destination = label3;
            ret = IRAppendCode(ret, code5);
            IRCode* code6= newcode(CODE_LABEL);
            code6->label.label = label2;
            ret = IRAppendCode(ret, code6);
            ret = mergelist(ret, code3);
            IRCode* code7= newcode(CODE_LABEL);
            code7->label.label = label3;
            ret = IRAppendCode(ret, code7);
        }
        else{
            //printf("%d\n",labelnum);
            Operand lab1 = newlabel();
            Operand lab2 = newlabel();
            IRCodeList code1 = Translate_cond(e2->next, lab1, lab2);
            IRCodeList code2 = Translate_stmt(e2->next->next->next);
            ret = code1;
            IRCode* code3 = newcode(CODE_LABEL);
            code3->label.label = lab1;
            ret = IRAppendCode(ret, code3);
            ret = mergelist(ret,code2);
            IRCode* code = newcode(CODE_LABEL);
            code->label.label = lab2;
            ret = IRAppendCode(ret, code);
        }
    }
    else if(!strcmp(e1->name, "WHILE")){
        Operand label1 = newlabel();
        Operand label2 = newlabel();
        Operand label3 = newlabel();
        IRCodeList code1 = Translate_cond(e2->next, label2, label3);
        IRCodeList code2 = Translate_stmt(e2->next->next->next);
        IRCode* code4 = newcode(CODE_LABEL);
        code4->label.label = label1;
        ret = IRAppendCode(ret, code4);
        ret = mergelist(ret, code1);
        IRCode* code5= newcode(CODE_LABEL);
        code5->label.label = label2;
        ret = IRAppendCode(ret, code5);
        ret = mergelist(ret, code2);
        IRCode* code6 = newcode(CODE_GOTO);
        code6->jmp.destination = label1;
        ret = IRAppendCode(ret, code6);
        IRCode* code7= newcode(CODE_LABEL);
        code7->label.label = label3;
        ret = IRAppendCode(ret, code7);

    }
    return ret;
}
IRCodeList Translate_Dec(Node *dec)
{
    Node *var = dec->child;
    while (var && var->child->type != Id)
    {
        var = var->child;
    }
    Operand OP = newvar(var->child->str, true);
    item temp = searchTableItem(table, var->child->str);
    IRCodeList x = empty_list;
    //printf("%d\n",temp->field->type->kind);
    if (temp->field->type->kind != BASIC)
    {
        IRCode *code = newcode(CODE_DEC);
        code->dec.variable = OP;
        if (temp->field->type->kind == ARRAY)
        {
            pType s = temp->field->type;
            //printf("%d\n",s->u.array.size);
            code->dec.size = caluarray(s);
        }
        else
        {
            FieldList s = temp->field->type->u.structure;
            code->dec.size = calustruct(s);
        }
        x = IRAppendCode(x, code);
    }
    var = dec->child;
    if (var->next != NULL)
    {
        IRCode *acode = newcode(CODE_ASSIGN);
        acode->assign.left = OP;
        Operand t = newtemp();
        acode->assign.right = t;
        x = mergelist(x, Translate_Exp(var->next->next, t, true).list);
        x = IRAppendCode(x, acode);
    }
    return x;
}
IRCodeList Translate_Declist(Node *declist)
{
    IRCodeList x = Translate_Dec(declist->child);
    if (declist->child->next)
    {
        x = mergelist(x, Translate_Declist(declist->child->next->next));
    }
    return x;
}
IRCodeList Translate_Def(Node *def)
{
    IRCodeList x = Translate_Declist(def->child->next);
    return x;
}
IRCodeList Translate_Deflist(Node *deflist)
{
    if (deflist == NULL) return empty_list;
    if (!strcmp(deflist->name, "_DefList")) return empty_list;
    IRCodeList x = Translate_Def(deflist->child);
    if (deflist->child->next==NULL||!strcmp(deflist->child->next->name, "_DefList"))
        deflist->child->next = NULL;
    x = mergelist(x, Translate_Deflist(deflist->child->next));
    return x;
}
IRCodeList Translate_Stmtlist(Node *stmtlist)
{
    if (stmtlist == NULL) return empty_list;
    if (!strcmp(stmtlist->name, "_StmtList")) return empty_list;
    IRCodeList x = Translate_stmt(stmtlist->child);
    if (stmtlist->child->next==NULL||!strcmp(stmtlist->child->next->name, "_StmtList")) {stmtlist->child->next = NULL;}
    x = mergelist(x, Translate_Stmtlist(stmtlist->child->next));
    return x;
}
IRCodeList Translate_CompSt(Node* compst){
    IRCodeList x1 = Translate_Deflist(compst->child->next);
    IRCodeList x2 = Translate_Stmtlist(compst->child->next->next);
    return mergelist(x1,x2);
}
void IRFunDec(Node *fundec)
{
    IRCodeList ret = empty_list;
    IRCode *code = newcode(CODE_FUNCTION);
    code->function.function.kind = OP_FUNCTION;
    code->function.function.name = fundec->child->str;
    ret = IRAppendCode(ret, code);

    char *name = fundec->child->str;
    pType type = searchTableItem(functiontable, name)->field->type;
    FieldList field = type->u.function.args;
    for (FieldList fd = field; fd != NULL; fd = fd->tail)
    {
        code = newcode(CODE_PARAM);
        code->param.variable = newvar(fd->name, false);
        ret = IRAppendCode(ret, code);
    }
    fundec->head = (void *)ret.head;
    fundec->tail = (void *)ret.end;
}
void IRCompSt(Node *compst)
{
    Node *deflist = compst->child->next;
    Node *stmtlist = deflist->next;
    IRCodeList list1 = empty_list;
    IRCodeList list2 = empty_list;
    list1.head = (IRCode *)deflist->head;
    list1.end = (IRCode *)deflist->tail;
    list2.head = (IRCode *)stmtlist->head;
    list2.end = (IRCode *)stmtlist->tail;

    IRCodeList list = mergelist(list1, list2);
    compst->head = (void *)list.head;
    compst->tail = (void *)list.end;
}

void IRDefList(Node *deflist)
{
    IRCodeList list = Translate_Deflist(deflist);
    deflist->head = (void *)list.head;
    deflist->tail = (void *)list.end;
}

void IRStmtList(Node *stmtlist)
{
    IRCodeList list = Translate_Stmtlist(stmtlist);
    stmtlist->head = (void *)list.head;
    stmtlist->tail = (void *)list.end;
}

void IRALL(Node *fundec, Node *compst)
{
    IRCodeList list;
    list.head = (IRCode *)fundec->head;
    list.end = (IRCode *)fundec->tail;
    mycodelist = mergelist(mycodelist, list);

    list.head = (IRCode *)compst->head;
    list.end = (IRCode *)compst->tail;
    mycodelist = mergelist(mycodelist, list);
}