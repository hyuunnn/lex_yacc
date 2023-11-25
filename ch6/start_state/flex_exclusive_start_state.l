%{
#include <stdio.h>
static int first_time = 1;
// 배타적인 시작 상태(exclusive start state)를 사용하면 시작 상태가 없는 규칙에 매치되지 않는다. 
// 실전에서 배타적인 시작 상태가 훨씬 더 유용하다고 한다. - p248

// 사용 방법은 %x와 %s에 차이가 있다.
%}

%x NORMAL CMNT

%%
%{
  if (first_time) { // yylex()가 처음 호출될 때만 실행
    BEGIN NORMAL; /* NORMAL 모드 상태로 시작 */
    first_time = 0;
    printf("/* 주석 텍스트를 출력합니다. */\n");
  }
%}
<NORMAL>"/*" BEGIN CMNT; /* 주석 모드의 시작 */
<CMNT>. |
<CMNT>\n { printf("%s", yytext); } /* 주석 텍스트 출력 */
<CMNT>"*/" BEGIN NORMAL; /* 주석 모드 종료 */
<NORMAL>. | /* flex_start_state.l과 다르게 상태가 없는 규칙은 무시되기 때문에 NORMAL 상태 설정 */
<NORMAL>\n ;

%%

int main() {
  yylex();
  return 0;
}

int yywrap() {
  return 1;
}
