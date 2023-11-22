%{
#include <stdio.h>

// yyless()를 사용하여 되돌린 후 yymore()을 사용하여 해당 토큰 뒤에 다음 토큰을 붙여서 처리할 수 있다. (yymore은 flex_yymore.l 참고)
// 각 토큰 사이의 경게를 정하는 규칙을 정규표현식으로 나타내기 불편할 때 유용하게 사용할 수 있다. - p251

// yyless()는 unput()을 이용해서 문자열을 되돌려 넣는 것과 동일하지만, 
// yyless()에서는 되돌려지는 문자가 입력에서 읽어온 문자와 항상 동일하다고 간주하기 때문에 이 함수가 좀 더 빠르게 작동한다. - p252

// 다른 시작 상태에 대한 규칙을 이용해서 토큰을 다시 처리할 때도 사용할 수 있다. - p252
// sometoken { BEGIN OTHER_STATE; yyles(0); }
%}

%%
\"[^"]*\" { 
  // 주어진 문자가 닫기 따옴표 앞에 있는가?
  if (yytext[yyleng-1] == ' ') {
    yyless(yyleng-1); // 마지막 따옴표를 리턴한다.
    yymore(); // 다음 문자열을 붙인다.
  } else {
    printf("STRING: %s\n", yytext);
  }
}
. |
\n { ; }
%%

int main() {
  yylex();
  return 0;
}

int yywrap() {
  return 1;
}
