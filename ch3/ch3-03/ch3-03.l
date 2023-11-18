%{
#include "y.tab.h"
#include <math.h>
extern double vbltable[26];
%}
%%
([0-9]+|([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?) {
  yylval.dval = atof(yytext); return NUMBER;
}
[ \t] ; /* 공백 무시 */
[a-z] { yylval.vblno = yytext[0] - 'a'; return NAME; }
"$" { return 0; /* 입력 끝 */ }
\n |
. return yytext[0];
%%
int yywrap() { return 1; }
