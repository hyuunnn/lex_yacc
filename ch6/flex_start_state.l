%{
#include <stdio.h>
%}

%s INCLMODE

%%
^"#include" { BEGIN INCLMODE; }
<INCLMODE>"<"[^>\n]+">" { printf("%s\n", yytext); }
<INCLMODE>\n { BEGIN 0; } 
. | 
\n { ; } /* 위에서 매칭되지 않으면 시작 상태가 없는 규칙으로 넘어가기 때문에 추가 */
%%

int main() {
  yylex();
  return 0;
}

int yywrap() {
  return 1;
}
