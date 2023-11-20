%{
#include <stdio.h>

// yyleng은 strlen(yytext)와 같다.
%}

%%
[a-zA-Z0-9]+ { printf("%s, %d", yytext, yyleng); }
%%

int main() {
  yylex();
  return 0;
}

int yywrap() {
  return 1;
}
