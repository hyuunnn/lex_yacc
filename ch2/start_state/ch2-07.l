%{

%}
%s MAGIC
%%
<MAGIC>.+ { BEGIN 0; printf("Magic."); ECHO; } // 0은 기본 상태를 의미
magic BEGIN MAGIC; // BEGIN을 사용하여 MAGIC 상태로 만듦
%%

// $ ch2-07.l < magic.input
// Magic:two
// three
int main() {
  yylex();
  return 0;
}

int yywrap() {
  return 1;
}
