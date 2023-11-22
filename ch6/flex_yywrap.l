%{
#include <stdio.h>
#undef yywrap
// ch2-03.l 참고 - yywrap을 재정의하여 다음으로 받을 파일이 없을 때까지 0을 반환하고 yyin을 변경하여 사용하는 예제
%}

%%
. |
\n { ; }
%%

int main() {
  yylex();
  return 0;
}

int yywrap() {
  return 0;
}
