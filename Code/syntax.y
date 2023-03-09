%{
#include<stdbool.h>
#include<stdio.h>
#include"tree.h"
#include"lex.yy.c"
Node* root = NULL;
extern bool Error;
%}

%locations
%union{
Node* node; 
}

%token <node> INT
%token <node> FLOAT
%token <node> ID
%token <node> SEMI
%token <node> COMMA
%token <node> ASSIGNOP
%token <node> RELOP
%token <node> PLUS MINUS STAR DIV
%token <node> AND OR DOT NOT 
%token <node> TYPE
%token <node> LP RP LB RB LC RC
%token <node> IF
%token <node> ELSE
%token <node> WHILE
%token <node> STRUCT
%token <node> RETURN

%type <node> Program ExtDefList ExtDef ExtDecList
%type <node> Specifier StructSpecifier OptTag Tag
%type <node> VarDec FunDec VarList ParamDec
%type <node> CompSt StmtList Stmt
%type <node> DefList Def Dec DecList
%type <node> Exp Args

%right ASSIGNOP
%left OR
%left AND
%left RELOP
%left PLUS MINUS
%left STAR DIV
%right NOT
%left LP RP LB RB DOT

%%
/*High-level Definitions */
Program:ExtDefList{$$ = create(@$.first_line,"Program",other, 1, $1); root = $$;}
;
ExtDefList: ExtDef ExtDefList{$$ = create(@$.first_line,"ExtDefList",other, 2, $1, $2); }
| {$$ = create(@$.first_line,"_ExtDefList",other, 0); }
;
ExtDef: Specifier ExtDecList SEMI{$$ = create(@$.first_line,"ExtDef",other, 3,$1,$2,$3); }
| Specifier SEMI {$$ = create(@$.first_line,"ExtDef",other, 2, $1, $2); }
| Specifier FunDec CompSt {$$ = create(@$.first_line,"ExtDef",other, 3,$1,$2,$3); }
| error SEMI {Error=1;}
| Specifier FunDec SEMI {$$ = create(@$.first_line,"ExtDef",other, 3,$1,$2,$3); }
;
ExtDecList: VarDec{$$ = create(@$.first_line,"ExtDecList",other, 1, $1); }
| VarDec COMMA ExtDecList {$$ = create(@$.first_line,"ExtDecList",other, 3,$1,$2,$3); }
;
/* Specifiers */
Specifier: TYPE{$$ = create(@$.first_line,"Specifier",other, 1, $1); }
| StructSpecifier {$$ = create(@$.first_line,"Specifier",other, 1, $1); }
;
StructSpecifier: STRUCT OptTag LC DefList RC {$$ = create(@$.first_line,"StructSpecifier",other, 5,$1,$2,$3,$4,$5); }
| STRUCT Tag {$$ = create(@$.first_line,"StructSpecifier",other, 2,$1,$2); }
| STRUCT OptTag LC error RC {Error=1;}
;
OptTag: ID {$$ = create(@$.first_line,"OptTag",other, 1, $1); }
| {$$ = create(@$.first_line,"_OptTag",other, 0); }
;
Tag: ID{$$ = create(@$.first_line,"Tag",other, 1, $1); }
;
/* Declarators */
VarDec: ID {$$ = create(@$.first_line,"VarDec",other, 1, $1); }
| VarDec LB INT RB {$$ = create(@$.first_line,"VarDec",other, 4, $1,$2,$3,$4); }
;
FunDec: ID LP VarList RP{$$ = create(@$.first_line,"FunDec",other, 4, $1,$2,$3,$4); }
| ID LP RP{$$ = create(@$.first_line,"FunDec",other, 3, $1,$2,$3); }
;
VarList: ParamDec COMMA VarList {$$ = create(@$.first_line,"VarList",other, 3, $1,$2,$3); }
| ParamDec {$$ = create(@$.first_line,"VarList",other, 1, $1); }
;
ParamDec: Specifier VarDec {$$ = create(@$.first_line,"ParamDec",other, 2, $1,$2); }
;
/*Statements */
CompSt: LC DefList StmtList RC {$$ = create(@$.first_line,"CompSt",other, 4, $1,$2,$3,$4); }
;
StmtList: Stmt StmtList{$$ = create(@$.first_line,"StmtList",other, 2, $1,$2); }
| {$$ = create(@$.first_line,"_StmtList",other, 0); }
;
Stmt: Exp SEMI{$$ = create(@$.first_line,"Stmt",other, 2, $1,$2); }
| CompSt{$$ = create(@$.first_line,"Stmt",other, 1, $1); }
| RETURN Exp SEMI{$$ = create(@$.first_line,"Stmt",other, 3, $1,$2,$3); }
| IF LP Exp RP Stmt {$$ = create(@$.first_line,"Stmt",other, 5, $1,$2,$3,$4,$5); }
| IF LP Exp RP Stmt ELSE Stmt {$$ = create(@$.first_line,"Stmt",other, 7, $1,$2,$3,$4,$5,$6,$7); }
| WHILE LP Exp RP Stmt {$$ = create(@$.first_line,"Stmt",other, 5, $1,$2,$3,$4,$5); }
| error SEMI {Error = 1;} 
| IF LP error RP Stmt {Error=1;}
| IF LP error RP Stmt ELSE Stmt {Error=1;}
| IF LP Exp RP error ELSE Stmt {Error=1;}
| WHILE LP error RP Stmt {Error=1;}
;
/*Local Definitions */
DefList: Def DefList{$$ = create(@$.first_line,"DefList",other, 2, $1,$2); }
|{$$ = create(@$.first_line,"_DefList",other, 0); }
;
Def: Specifier DecList SEMI{$$ = create(@$.first_line,"Def",other, 3, $1,$2,$3); }
| Specifier error SEMI {Error=1;}
;
DecList: Dec{$$ = create(@$.first_line,"DecList",other, 1, $1); }
| Dec COMMA DecList{$$ = create(@$.first_line,"DecList",other, 3, $1,$2,$3); }
;
Dec: VarDec {$$ = create(@$.first_line,"Dec",other, 1, $1); }
| VarDec ASSIGNOP Exp{$$ = create(@$.first_line,"Dec",other, 3, $1,$2,$3); }
| error ASSIGNOP Exp {Error=1;}
;
/*Expressions */
Exp: Exp ASSIGNOP Exp{$$ = create(@$.first_line,"Exp",other, 3, $1,$2,$3); }
| Exp AND Exp{$$ = create(@$.first_line,"Exp",other, 3, $1,$2,$3); }
| Exp OR Exp{$$ = create(@$.first_line,"Exp",other, 3, $1,$2,$3); }
| Exp RELOP Exp{$$ = create(@$.first_line,"Exp",other, 3, $1,$2,$3); }
| Exp PLUS Exp{$$ = create(@$.first_line,"Exp",other, 3, $1,$2,$3); }
| Exp MINUS Exp{$$ = create(@$.first_line,"Exp",other, 3, $1,$2,$3); }
| Exp STAR Exp{$$ = create(@$.first_line,"Exp",other, 3, $1,$2,$3); }
| Exp DIV Exp{$$ = create(@$.first_line,"Exp",other, 3, $1,$2,$3); }
| LP Exp RP{$$ = create(@$.first_line,"Exp",other, 3, $1,$2,$3); }
| MINUS Exp{$$ = create(@$.first_line,"Exp",other, 2, $1,$2); }
| NOT Exp{$$ = create(@$.first_line,"Exp",other, 2, $1,$2); }
| ID LP Args RP{$$ = create(@$.first_line,"Exp",other, 4, $1,$2,$3,$4); }
| ID LP RP{$$ = create(@$.first_line,"Exp",other, 3, $1,$2,$3); }
| Exp LB Exp RB{$$ = create(@$.first_line,"Exp",other, 4, $1,$2,$3,$4); }
| Exp DOT ID{$$ = create(@$.first_line,"Exp",other, 3, $1,$2,$3); }
| ID{$$ = create(@$.first_line,"Exp",other, 1, $1); }
| INT{$$ = create(@$.first_line,"Exp",other, 1, $1); }
| FLOAT{$$ = create(@$.first_line,"Exp",other, 1, $1); }
| LP error RP {Error=1;}
| LP error SEMI {Error=1;}
| LP error RC {Error=1;}
| ID LP error RP {Error=1;}
| ID LP error SEMI {Error=1;}
| ID LP error RC {Error=1;}
| Exp LB error RB {Error=1;}
| Exp LB error SEMI {Error=1;}
| Exp LB error RC {Error=1;}
;
Args: Exp COMMA Args{$$ = create(@$.first_line,"Args",other, 3, $1,$2,$3); }
| Exp{$$ = create(@$.first_line,"Args",other, 1,$1); }
;
%%
yyerror(char* msg){
fprintf(stderr, "Error type B at line %d: %s.\n", yylineno, msg);
}