%{
#include <stdio.h>
int yylex();
int yyerror(char *s);

// 문법적으로 모호한 부분을 제거하여 암시적으로 우선순위를 부여할 수 있다.
// ch3-02-explicit.y에서 %left를 제거하면 모호한 문법이 된다.
%}

%token NAME NUMBER

%%
statement: NAME '=' expression
         | expression { printf("= %d\n", $1); }
         ;
expression: expression '+' mulexp { $$ = $1 + $3; }
          | expression '-' mulexp { $$ = $1 - $3; }
          | mulexp { $$ = $1; }
          ;
mulexp: mulexp '*' primary { $$ = $1 * $3; }
      | mulexp '/' primary { if ($3 == 0) yyerror("divide by zero");
                             else $$ = $1 / $3; }
      | primary { $$ = $1; }
      ;
primary: '(' expression ')' { $$ = $2; }
        | '-' primary { $$ = -$2; }
        | NUMBER { $$ = $1; }
        ;
%%

int main() {
  yyparse();
}

int yyerror(char *s) {
  printf("%s\n", s);
}