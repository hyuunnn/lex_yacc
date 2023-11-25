%{
#include "y.tab.h"
%}

%%
[0-9]+.[0-9]* { yylval.dval = atof(yytext); return REAL; }
\"[^"]*\" { yylval.sval = strdup(yytext); return STRING; }
"==" { yylval.opval = OPEQUAL; return RELOP; }
[ \t] ;
\+ return ('+');
\- return ('-');
\* return ('*');
\/ return ('/');
\n return 0;
\. return yytext[0];
%%

int yywrap() {
  return 1;
}
