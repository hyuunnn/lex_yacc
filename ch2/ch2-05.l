%{
  #undef input // AT&T 렉스에서 정의하는 매크로를 해제하고 C 함수로 재정의
  #undef unput // AT&T 렉스에서 정의하는 매크로를 해제하고 C 함수로 재정의

  int input(void);
  void unput(int ch);
  unsigned int verbose;
  char *progName;
%}
%%
-h   |
"-?" |
-help { printf("usage is. %s [-help | -h | -?] [-verbose | -v] "
    "[(-file| -f) filename]\n", progName);
    }
-v  |
-verbose { printf("verbose mode is on\n"); verbose = 1; }
.   ;
%%

// *책에서 AT&T 렉스에서만 작동한다고 함*

char **targv; // 인자 저장
char **arglim; // 인자 끝
int main(int argc, char **argv) {
  progName = *argv;
  targv = argv + 1;
  arglim = argv + argc;
  yylex();
}

static unsigned int offset = 0;
int input(void) {
  char c;
  if (targv >= arglim) return 0;
  // 인자의 끝, 다음으로 이동한다.
  if ((c = targv[0][offset++]) != '\0') return c;
  targv++;
  offset = 0;
  return ' ';
}

// 원래로 되돌려 놓을 뿐 다른 텍스트를 되돌리는 것은 허용하지 않는다.
void unput(int ch) {
  // AT&T 렉스는 가끔 EOF를 되돌려 놓는다.
  if (ch == 0)
    return; // EOF를 되돌려 놓을 수는 없으므로 그냥 무시한다.
  if (offset) { // 현재 인자를 되돌려 놓는다.
    offset--;
    return;
  }
  targv--; // 앞의 인자로 되돌아간다.
  offset = strlen(*targv);
}
