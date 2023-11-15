%{
  /* 이 예제는 ch2-07 예제에서 고의적으로 동작하지 않게 함  */
%}
%s MAGIC
%%
magic BEGIN MAGIC;
.+ ECHO; // flex는 이 부분에 문제가 있다고 출력한다. 
         // 시작 상태가 있는 아래 rule보다 시작 상태가 없는 rule이 먼저 위치하여 발생하는 문제
         // 책에서는 lex를 사용해서 그런지 정상적으로 동작하지만, 출력 결과를 보면 입력 문자들이 해당 룰에 먼저 적용되어 출력되었다.
<MAGIC>.+ { BEGIN 0; printf("Magic:"); ECHO; }
%%

// $ ch2-08 < magic.input
// two
// three
// magic을 입력 받아서 상태를 변경했어도 .+ rule에 의해 ECHO;만 동작하게 된다.

int main() {
  yylex();
  return 0;
}

int yywrap() {
  return 1;
}
