%{
#include <stdio.h>
// input()을 사용하여 다음 문자를 읽을 수 있다.
%}

%%
"/*" {  
  int c1 = 0, c2 = input(); 
  for (;;) {
    if (c2 == EOF) { printf("%c", c1); break; }
    if (c1 == '*' && c2 == '/') { printf("%c", c2); break; }
    printf("%c", c2);
    c1 = c2;
    c2 = input();
  }
  printf("\n");
}
.|\n ;
%%

int main() {
  yylex();
  return 0;
}

int yywrap() {
  return 1;
}
