%{
    #include"tree.h"
    #include "syntax.tab.h"
    #include<stdbool.h>
    int yycolumn = 1;
    #define YY_USER_ACTION \
        yylloc.first_line = yylloc.last_line = yylineno; \
        yylloc.first_column = yycolumn; \
        yylloc.last_column = yycolumn + yyleng - 1; \
        yycolumn += yyleng;
    extern bool Error;
%}

%option yylineno

null      [ ]
digit       [0-9]
letter      [_a-zA-Z]
relop       >|<|>=|<=|==|!=
type        int|float
oct 0[1-7]+
hex 0[xX][0-9a-fA-F]+
int [1-9]{digit}*|0
float {digit}+\.{digit}+
id {letter}+({digit}|{letter})*
one {digit}*\.{digit}+
two {digit}+\.{digit}*
prefix {one}|{two}
otherfloat {prefix}[eE][-+]?{digit}+
xfloat {digit}*\.{digit}*[eE]
eoct 0[0-7]*[89]+[0-9]*
ehex 0[xX][0-9a-fA-F]*[g-zG-Z]+[0-9a-zA-Z]*
%%
\n { yycolumn = 1; }
\r ;
\t ;
 "//" {
    char c = input();
    while (c != '\n'){
        c = input();
    }
 }
 "/*" {
    char d = input();
    char e =input();
    while(d!='*'||e!='/'){
        d=e;
        e=input();
    }
 }
 "*/" {
    Error=1;printf("Error type B at Line %d:  \'%s\'.\n", yylineno, yytext);
 }
{null} ;
{otherfloat} {yylval.node=newtoken(yylineno,"SCI",SCI,yytext);return FLOAT;}
{oct} {yylval.node=newtoken(yylineno,"OCT",OCT,yytext);return INT;}
struct { yylval.node = newtoken(yylineno,   "STRUCT", mark,yytext); return STRUCT; }
return { yylval.node = newtoken(yylineno,   "RETURN",mark, yytext); return RETURN; }
if { yylval.node = newtoken(yylineno,   "IF",mark, yytext); return IF; }
else { yylval.node = newtoken(yylineno,   "ELSE",mark, yytext); return ELSE; }
while { yylval.node = newtoken(yylineno,   "WHILE",mark, yytext); return WHILE; }
{type}  {yylval.node = newtoken(yylineno,"TYPE", TYPe, yytext);return TYPE;}
{id} { yylval.node = newtoken(yylineno, "ID",Id, yytext); return ID;}
{int} { yylval.node = newtoken(yylineno,  "INT",Int,yytext); return INT;}
{float} { yylval.node = newtoken(yylineno, "FLOAT",Float, yytext); return FLOAT;}
{hex} {yylval.node=newtoken(yylineno,"HEX",HEX,yytext);return INT;}
";" { yylval.node = newtoken(yylineno,  "SEMI", mark, yytext); return SEMI; }
"," { yylval.node = newtoken(yylineno,  "COMMA",mark, yytext); return COMMA; }
"=" { yylval.node = newtoken(yylineno,  "ASSIGNOP",mark, yytext); return ASSIGNOP; }
{relop} { yylval.node = newtoken(yylineno,  "RELOP", mark,yytext); return RELOP; }
"+" { yylval.node = newtoken(yylineno,   "PLUS",mark, yytext); return PLUS; }
"-" { yylval.node = newtoken(yylineno,   "MINUS",mark, yytext); return MINUS; }
"*" { yylval.node = newtoken(yylineno,   "STAR",mark, yytext); return STAR; }
"/" { yylval.node = newtoken(yylineno,   "DIV", mark,yytext); return DIV; }
"&&" { yylval.node = newtoken(yylineno,   "AND", mark,yytext); return AND; }
"||" { yylval.node = newtoken(yylineno,   "OR", mark,yytext); return OR; }
"." { yylval.node = newtoken(yylineno,   "DOT",mark, yytext); return DOT; }
"!" { yylval.node = newtoken(yylineno,   "NOT", mark,yytext); return NOT; }
"(" { yylval.node = newtoken(yylineno,   "LP", mark,yytext); return LP; }
")" { yylval.node = newtoken(yylineno,   "RP",mark, yytext); return RP; }
"[" { yylval.node = newtoken(yylineno,   "LB", mark,yytext); return LB; }
"]" { yylval.node = newtoken(yylineno,   "RB", mark,yytext); return RB; }
"{" { yylval.node = newtoken(yylineno,   "LC", mark,yytext); return LC; }
"}" { yylval.node = newtoken(yylineno,   "RC", mark,yytext); return RC; }

{ehex}  {Error=1;printf("Error type A at Line %d: Illegal  hex \'%s\'.\n", yylineno, yytext);return INT;}
{eoct}                      {Error=1;printf("Error type A at Line %d: Illegal oct\'%s\'.\n", yylineno, yytext);return INT;}


. {Error=1;printf("Error type A at Line %d: Mysterious characters \'%s\'\n",yylineno, yytext); }
%%