#include"spim.h"
const char * regs[] = {
    "$zero", "$at", "$v0", "$v1", "$a0", "$a1", "$a2", "$a3","$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7",
    "$s0", "$s1", "$s2", "$s3", "$s4", "$s5", "$s6", "$s7","$t8", "$t9", "$k0", "$k1", "$gp", "$sp", "fp", "$ra"
};
#define v0_ regs[2]
#define a0_ regs[4]
#define t0_ regs[8]
#define t1_ regs[9]
Operand* funcname;
extern IRCodeList mycodelist;
void caluoffset() {
    IRCode * cur = mycodelist.head;
    IRCode * next;
    for (;cur != NULL && cur->prev != mycodelist.end;) {
        if (cur->kind == CODE_FUNCTION) {
            //if(cur->function.table==NULL) printf("psp\n");
            next = funcprepare(cur, &cur->function.table);
            tableinsert(&funcname, &cur->function.function);
            cur = next;
        }
        else cur = cur->next;
    }
    for (;cur != NULL && cur->prev != mycodelist.end;) {
        if (cur->kind == CODE_CALL) {
            Operand * res = funcnametablefind(&funcname, &cur->call.function);
            if (res) {
                //not the read or write function, otherwise the res will be null
                cur->call.function.size = res->size;
            }
        }
    }
}
IRCode *funcprepare(IRCode *start, Operand **x) {
    //assert(start->kind == IR_CODE_FUNCTION);
    IRCode * cur;
    int size = 8, args = 0;
    for (cur = start->next; cur != NULL && cur->kind != CODE_FUNCTION; cur = cur->next) {
        switch (cur->kind) {
            case CODE_ASSIGN :
            case CODE_GETADDR :
            case CODE_LOAD :
            case CODE_SAVE: {
                //printf("%d1\n",size);
                size += varcalu(&cur->assign.left, x, size);
                //printf("%d2\n",size);
                size += varcalu(&cur->assign.right, x, size);
                //printf("%d3\n\n",size);
                break;
            }
            case CODE_ADD :
            case CODE_SUB :
            case CODE_MUL :
            case CODE_DIV : {
                size += varcalu(&cur->binop.result, x, size);
                size += varcalu(&cur->binop.op1, x, size);
                size += varcalu(&cur->binop.op2, x, size);
                break;
            }
            case CODE_GOTO_RELOP : {
                size += varcalu(&cur->jmp_relop.op1, x, size);
                size += varcalu(&cur->jmp_relop.op2, x, size);
                break;
            }
            case CODE_RETURN :
                size += varcalu(&cur->ret.retval, x, size);
                break;
            case CODE_DEC :
            //view as address while counting the size
                cur->dec.variable.kind = OP_ADDRESS;
                size += varcalu(&cur->dec.variable, x, size);
                break;
            case CODE_READ: 
            case CODE_WRITE : {
                size += varcalu(&cur->read.variable, x, size);
                break;
            }
            case CODE_CALL : {
                size += varcalu(&cur->call.result, x, size);
                break;
            }
            case CODE_ARG : {
                size += varcalu(&cur->arg.variable, x, size);
                break;
            }
            case CODE_PARAM : {
                int parasize = varcalu(&cur->param.variable, x, 0);
                cur->param.variable.offset = 0 - args;
                args += 4;
                break;
            }
            default: break;
        }
    }
    start->function.function.size = size;
    return cur;
}
int varcalu(Operand *op, Operand **x, int offset) {
    switch (op->kind) {
        case OP_TEMP :
        case OP_VARIABLE :
        case OP_ADDRESS : {
            //printf("%d %d %d %d\n", op->kind, op->num, op->offset,op->size);
            if (istablecontain(x, op)) {
                Operand * res = tablefind(x, op);
                op->offset = res->offset;
                return 0;
            }
            else {
                op->offset = offset + op->size;
                tableinsert(x, op);
                return op->size;
            }
        }
        default: break;
    }
    return 0;
}
void tableinsert(Operand **x,Operand *op){
    op->next = NULL;
    if (*x == NULL)
    {
        *x = op;
    }
    else
    {
        Operand *temp = *x;
        while(temp->next){
            temp=temp->next;
        }
        temp->next = op;
    }
}
bool istablecontain(Operand **x,Operand *op){
    Operand *temp = *x;
    while(temp){
        if (op->kind == temp->kind&&op->num == temp->num) return true;
        temp = temp->next;
    }
    return false;
}
Operand* tablefind(Operand **x,Operand *op){
    Operand * temp = *x;
    while(temp){
        if (op->kind == temp->kind&&op->num == temp->num) return temp;
        temp = temp->next;
    }
    return NULL;
}
Operand* funcnametablefind(Operand **x,Operand *op){
    Operand * temp = *x;
    while(temp){
        if (op->kind == temp->kind&&!strcmp(op->name, temp->name)) return temp;
        temp = temp->next;
    }
    return NULL;
}
void insselection(){
    printf(".data\n");
    printf("_prompt: .asciiz \"Enter an integer:\"\n");
    printf("_ret: .asciiz \"\\n\"\n");
    printf(".globl main\n");
    printf(".text\n");
    printf("read:\n");
    printf("  li $v0, 4\n");
    printf("  la $a0, _prompt\n");
    printf("  syscall\n");
    printf("  li $v0, 5\n");
    printf("  syscall\n");
    printf("  jr $ra\n");
    printf("\n");
    printf("write:\n");
    printf("  li $v0, 1\n");
    printf("  syscall\n");
    printf("  li $v0, 4\n");
    printf("  la $a0, _ret\n");
    printf("  syscall\n");
    printf("  jr $ra\n");
    printf("\n");
    for (IRCode * cur = mycodelist.head; cur != NULL && cur->prev != mycodelist.end; cur = cur->next) {
        codetranslate(cur);
    }
    /*for (IRCode * cur = allCode.head; cur != NULL && cur->prev != allCode.end; cur = cur->next) {
        if (cur->kind == IR_CODE_FUNCTION) RBDestroy(&cur->function.root, NULL);
    }*/

}
void registerload(const char* regname,Operand x){
    if (x.kind == OP_CONSTANT)  printf("  li %s, %d\n", regname, x.value);
    else {
        if (x.kind == OP_ADDRESS) printf("  la %s, %d($fp)\n", regname, -x.offset);
        else if (x.kind == OP_VARIABLE || x.kind == OP_TEMP) printf("  lw %s, %d($fp)\n", regname, -x.offset);
        else assert(0);
    }
}
void registerstore(const char* regname,Operand x){
    printf("  sw %s, %d($fp)\n", regname, -x.offset);
}
int argsize=0;
int funcsize = 0;
void codetranslate(IRCode * temp){
    switch (temp->kind)
    {
    case CODE_FUNCTION:{
        funcsize = temp->function.function.size;
        if (!strcmp(temp->function.function.name, "main"))
            printf("%s:\n", temp->function.function.name);
        else
            printf("function_%s:\n", temp->function.function.name);
        printf("  sw $ra, -4($sp)\n");
        printf("  sw $fp, -8($sp)\n");
        printf("  move $fp, $sp\n");
        printf("  subu $sp, $sp, %d\n", funcsize);
        break;
    }
    case CODE_ASSIGN:{
        registerload(t0_, temp->assign.right);
        registerstore(t0_, temp->assign.left);
        break;
    }
    case CODE_LABEL:{
        printf("label%d:\n", temp->label.label.num);
        break;
    }
    case CODE_GOTO:{
        printf("  j label%d\n", temp->jmp.destination.num);
        break;
    }
    case CODE_GOTO_RELOP:{
        registerload(t0_, temp->jmp_relop.op1);
        registerload(t1_, temp->jmp_relop.op2);
        if(!strcmp(temp->jmp_relop.relop.name, "==")){
            printf("  beq %s, %s, label%d\n", t0_, t1_, temp->jmp_relop.destination.num);
        }
        else if(!strcmp(temp->jmp_relop.relop.name, ">")){
            printf("  bgt %s, %s, label%d\n", t0_, t1_, temp->jmp_relop.destination.num);
        }
        else if(!strcmp(temp->jmp_relop.relop.name, "<")){
            printf("  blt %s, %s, label%d\n", t0_, t1_, temp->jmp_relop.destination.num);
        }
        else if(!strcmp(temp->jmp_relop.relop.name, "!=")){
            printf("  bne %s, %s, label%d\n", t0_, t1_, temp->jmp_relop.destination.num);
        }
        else if(!strcmp(temp->jmp_relop.relop.name, ">=")){
            printf("  bge %s, %s, label%d\n", t0_, t1_, temp->jmp_relop.destination.num);
        }
        else if(!strcmp(temp->jmp_relop.relop.name, "<=")){
            printf("  ble %s, %s, label%d\n", t0_, t1_, temp->jmp_relop.destination.num);
        }
        break;
    }
    case CODE_ADD:{
        registerload(t0_, temp->binop.op1);
        registerload(t1_, temp->binop.op2);
        printf("  add %s, %s, %s\n", t0_, t0_, t1_);
        registerstore(t0_, temp->binop.result);
        break;
    }
    case CODE_SUB:{
        registerload(t0_, temp->binop.op1);
        registerload(t1_, temp->binop.op2);
        printf("  sub %s, %s, %s\n", t0_, t0_, t1_);
        registerstore(t0_, temp->binop.result);
        break;
    }
    case CODE_MUL:{
        registerload(t0_, temp->binop.op1);
        registerload(t1_, temp->binop.op2);
        printf("  mul %s, %s, %s\n", t0_, t0_, t1_);
        registerstore(t0_, temp->binop.result);
        break;
    }
    case CODE_DIV:{
        registerload(t0_, temp->binop.op1);
        registerload(t1_, temp->binop.op2);
        printf("  div %s, %s, %s\n", t0_, t0_, t1_);
        printf("  mflo %s\n", t0_);
        registerstore(t0_, temp->binop.result);
        break;
    }
    case CODE_READ:{
        printf("  jal read\n");
        registerstore(v0_, temp->read.variable);
        break;
    }
    case CODE_WRITE:{
        registerload(a0_, temp->write.variable);
        printf("  jal write\n");
        break;
    }
    case CODE_LOAD:{
        registerload(t0_, temp->load.right);
        printf("  lw %s, 0(%s)\n", t1_, t0_);
        registerstore(t1_, temp->load.left);
        break;
    }
    case CODE_SAVE:{
        registerload(t0_, temp->save.right);
        registerload(t1_, temp->save.left);
        printf("  sw %s, 0(%s)\n", t0_, t1_);
        break;
    }
    case CODE_ARG: {
        registerload(t0_, temp->arg.variable);
        printf("  addiu $sp, $sp, -4\n");
        printf("  sw %s, 0($sp)\n", t0_);
        argsize += 4;
        break;
        }
    case CODE_CALL:{
        if (strcmp(temp->call.function.name, "main") == 0)
            printf("  jal %s\n", temp->call.function.name);
        else
            printf("  jal function_%s\n", temp->call.function.name);
        registerstore(v0_, temp->call.result);
        printf("  addiu $sp, $sp, %d\n", argsize);
        argsize = 0;
        break;
    }
    case CODE_RETURN:{
        registerload(v0_,temp->ret.retval);
        printf("  lw $ra, -4($fp)\n");
        printf("  lw $fp, -8($fp)\n");
        printf("  addiu $sp, $sp, %d\n", funcsize);
        printf("  jr $ra\n");
        break;
    }
    default:
        break;
    }
}