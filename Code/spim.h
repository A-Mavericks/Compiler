#include "ir.h"

void caluoffset();
IRCode *funcprepare(IRCode *start, Operand **x);
int varcalu(Operand *op, Operand **x, int offset);

void codetranslate(IRCode * temp);
void registerstore(const char* regname,Operand x);
void registerload(const char* regname,Operand x);

void insselection();

void tableinsert(Operand **x,Operand *op);
bool istablecontain(Operand **x,Operand *op);
Operand* tablefind(Operand **x,Operand *op);
Operand* funcnametablefind(Operand **x,Operand *op);