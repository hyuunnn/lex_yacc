%{
#include "y.tab.h"
%}

ws [ \t]+
qstring \"[^\"\n]*[\"\n]
nl \n
%%

{ws} ;
{qstring} { yylval.string = strdup(yytext+1); /* 여는 따옴표는 건너뛴다. */
            if(yylval.string[yyleng-2] != '"')
              warning("Unterminated character string", (char *)0);
            else
              yylval.string[yyleng-2] = '\0'; /* 닫는 따옴표는 제거한다. */
            return QSTRING; }
action { return ACTION; }
execute { return EXECUTE; }
command { return COMMAND; }
ignore { return IGNORE; }
{nl} { lineno++ }
. { return yytext[0]; }
%%
int yywrap() { return 1; }
