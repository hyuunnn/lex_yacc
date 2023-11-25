%{
#include <stdio.h>
#include <string.h>
int yylex();
int yyerror(char *s);

// %type, %union, 타입 명시 등을 사용하여 계산기를 만드는 예제
// <>을 사용하면 타입을 명시할 수 있다. (여기서 타입은 반드시 %union에 선언된 것이어야 한다.)
// 비터미널을 선언하려면 %type을 사용하며, 토큰을 선언할 때는 %token, %left, %right, %nonassoc 등을 사용한다.
// %union의 선언은 YYSTYPE 타입에 사용되며, %union 선언이 존재하지 않으면 기본 타입인 int로 정의된다. - p291

// -v 플래그를 사용하면 y.output 파일이 생성되는데, 파서의 모든 상태와 각 상태의 전환 과정을 보여준다. (충돌이 일어났다면 왜 일어났는지) - p299
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
