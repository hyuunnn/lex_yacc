%{
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

int main(int argc, char **argv) {
  progName = *argv;
  yylex();
  return 0;
}

int yywrap() {
  return 1;
}
