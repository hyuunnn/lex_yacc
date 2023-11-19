%{
#include <stdio.h> 
int yylex();
int yyerror(char *s);
%}

%union {
  char *string; /* 문자열 버퍼 */
}
%token COMMAND ACTION IGNORE EXECUTE
%token <string> QSTRING
%%
start: COMMAND action
     ;
action: ACTION IGNORE
      | ACTION EXECUTE QSTRING
      ;
%%

int main() {
  yyparse();
}

int yyerror(char *s) {
  printf("%s\n", s);
}
