%{
#include <stdio.h>
%}

%%
hyper yymore();
text printf("Token is %s\n", yytext);
. |
\n { ; }
%%

int main() {
  yylex();
  return 0;
}

int yywrap() {
  return 1;
}
