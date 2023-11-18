%{
#include <stdio.h>
int yylex();
int yyerror(char *s);

// %left를 사용하여 명시적으로 우선 순위를 정할 수 있다.
%}

%token NAME NUMBER
%left '-' '+'
%left '*' '/'
%nonassoc UMINUS
%%
statement: NAME '=' expression
         | expression { printf("= %d\n", $1); }
         ;
expression: expression '+' expression { $$ = $1 + $3; }
          | expression '-' expression { $$ = $1 - $3; }
          | expression '*' expression { $$ = $1 * $3; }
          | expression '/' expression { if ($3 == 0) yyerror("divide by zero");
                                        else $$ = $1 / $3; }
          | '-' expression %prec UMINUS { $$ = -$2; } // 해당 토큰의 우선 순위를 UMINUS로 설정
          | '(' expression ')' { $$ = $2; }
          | NUMBER { $$ = $1; }
          ;
%%

int main() {
  yyparse();
}

int yyerror(char *s) {
  printf("%s\n", s);
}