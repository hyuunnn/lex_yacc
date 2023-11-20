%{
#include <stdio.h>
int npink = 0, nink = 0, npin = 0;
// REJECT를 사용하면 매칭된 패턴을 되돌려놓고 다음 매칭을 시도한다.
// pink라고 입력하면 3개의 변수 모두 1이 된다.
// REJECT를 사용하면 백트래킹과 재분석을 위해 많은 정보가 필요하므로 REJECT를 사용하지 않는 스캐너에 비해 덩치도 크고 느리다. - p246
%}

%%
pink { npink++; REJECT; }
ink { nink++; REJECT; }
pin { npin++; REJECT; }
\n { printf("pink: %d, ink: %d, pin: %d\n", npink, nink, npin); }
. ;
%%

int main() {
  yylex();
  return 0;
}

int yywrap() {
  return 1;
}
