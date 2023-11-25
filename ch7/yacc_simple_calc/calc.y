%{
#include <stdio.h>
#include <string.h>
int yylex();
int yyerror(char *s);

// %type, %union, 타입 명시 등을 사용하여 계산기를 만드는 예제
// <>을 사용하면 타입을 명시할 수 있다.
%}

%union {
  enum { OPEQUAL } opval;
  double dval;
  char *sval;
}

%token <dval> REAL
%token <sval> STRING
%type <dval> expr
%nonassoc <opval> RELOP

%left '+' '-'
%left '*' '/'

%%
calc: expr { printf("%g\n", $1); }
expr: expr '+' expr { $$ = $1 + $3; }
    | expr '-' expr { $$ = $1 - $3; }
    | expr '*' expr { $$ = $1 * $3; }
    | expr '/' expr { $$ = $1 / $3; }
    | REAL { $$ = $1; }
    | STRING RELOP STRING { $$ = strcmp($1, $3) ? 0.0: 1.0; }
    ;
%%

int main() {
  yyparse();
}

int yyerror(char *s) {
  printf("%s\n", s);
}
