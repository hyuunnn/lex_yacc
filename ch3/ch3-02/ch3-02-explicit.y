%{
#include <stdio.h>
int yylex();
int yyerror(char *s);

// %left를 사용하여 명시적으로 우선 순위를 정할 수 있다.

// 일반적으로 우선 순위를 사용하여 문제를 해결하려는 것은 그다지 좋은 생각이 아니다.
// 해당 예제는 표현식을 나타내는 문법으로, 충돌의 원인과 그로 인해 우선 순위 규칙을 사용했다는 이유도 명백하게 드러난다.
// 그 외에도 대부분 우선 순위 규칙을 이용해서 이동/감소(shift-reduce) 충돌을 해소할 수는 있지만, 우선 순위가 문법에 미치는 영향을 이해하기 어려워진다.

// 우리는 두 가지 경우에만 우선 순위 규칙을 사용하도록 권한다.
// 표현식을 나타내는 문법과 if-then-else 구조에 대한 문법에서 "매달려 있는 else(dangling else)"가 일으키는 충돌을 해소하기 위해서만 사용해야 한다.

// 그 외의 경우 가급적이면 문법에서 충돌이 일어나지 않도록 주의를 기울여야 한다.
// 이러한 충돌은 대개 언어를 잘못 설계하여 문법 자체에 결함이 있음을 뜻한다.
// yacc에서 모호하게 인식하는 문법은, 대부분 사람이 이해하기에도 모호한 것이다. - p105
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