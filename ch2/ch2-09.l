%{
int comments, code, whiteSpace;
%}
%x COMMENT
%%
^[ \t]*"/*" { BEGIN COMMENT; } // 주석을 읽는 상태로 설정
^[ \t]*"/*".*"*/"[ \t]*\n {
    comments++; // 한 행에 온전히 포함된 주석
}
<COMMENT>"*/"[ \t]*\n { BEGIN 0; comments++; }
<COMMENT>"*/" { BEGIN 0; }
<COMMENT>\n { comments++; }
<COMMENT>.\n { comments++; }
^[ \t]*\n { whiteSpace++; }
.+"/*".*"*/".*\n { code++; }
.*"/*".*"*/".+\n { code++; }
.+"/*".*\n { code++; BEGIN COMMENT; }
.\n { code++; }
. ; // 그외에는 모두 무시
%%

int main() {
  yylex();
  printf("code: %d, comments %d, whitespace %d\n", code, comments, whiteSpace);
  return 0;
}

int yywrap() {
  return 1;
}
