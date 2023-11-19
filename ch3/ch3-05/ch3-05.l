%{
#include "y.tab.h"
#include "ch3hdr.h"
#include <math.h>
%}
%%
([0-9]+|([0-9]*\.[0-9]+)(e[+-]?[0-9]+)?) { yylval.dval = atof(yytext); return NUMBER; }
[ \t] ;
[A-Za-z][A-Za-z0-9]* {  struct symtab *sp = symlook(yytext); 
                        yylval.symp = sp; return NAME; }
"$" { return 0; }
\n |
\. return yytext[0];
%%
int yywrap() { return 1; }
