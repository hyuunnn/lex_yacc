%{
#include <stdio.h>
// flex 2.3.7
%}

%%
^\.I\ +lex$ |
^\.I\ "lex "$ { fputs("lex", yyout); }
%%

int main() {
  yylex();
  return 0;
}

int yywrap() {
  return 1;
}
