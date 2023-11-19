%{
#include "ch3hdr.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int yylex();
int yyerror(char *s);
%}

%union {
  double dval;
  struct symtab *symp;
}

%token <symp> NAME
%token <dval> NUMBER
%left '-' '+'
%left '*' '/'
%nonassoc UMINUS
%type <dval> expression

%%
statement_list: statement '\n'
              | statement_list statement '\n'
              ;
statement: NAME '=' expression { $1->value = $3; }
          | expression { printf("= %g\n", $1); }
          ;
expression: expression '+' expression { $$ = $1 + $3; }
          | expression '-' expression { $$ = $1 - $3; }
          | expression '*' expression { $$ = $1 * $3; }
          | expression '/' expression { if ($3 == 0.0) yyerror("divide by zero"); 
                                        else $$ = $1 / $3; }
          | '-' expression %prec UMINUS { $$ = -$2; }
          | '(' expression ')' { $$ = $2; }
          | NUMBER
          | NAME { $$ = $1->value; }
          ;
%%

/* 기호 테이블 엔트리를 찾아보고, 만약 존재하지 않으면 새로 추가한다. */
struct symtab *symlook(char *s) {
  struct symtab *sp;
  for (sp = symtab; sp < &symtab[NSYMS]; sp++) {
    /* 이미 안에 존재하는지 확인 */
    if(sp->name && !strcmp(sp->name, s))
      return sp;

    /* 사용 가능한 상태인지 확인 */
    if(!sp->name) {
      sp->name = strdup(s);
      return sp;
    }
    /* 그렇지 않으면 다음으로 넘어간다. */
  }
  yyerror("Too many symbols");
  exit(1); /* 종료 */
} /* symlook */

int main() {
  yyparse();
}

int yyerror(char *s) {
  printf("%s\n", s);
}
