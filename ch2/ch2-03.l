%{
  unsigned long charCount = 0, wordCount = 0, lineCount = 0;
  #undef yywrap // yywrap 매크로를 해제하고 C 함수로 재정의
%}

word [^ \t\n]+
eol \n

%%
{word} { wordCount++; charCount += yyleng; }
{eol} { charCount++; lineCount++; }
. charCount++;
%%

char **fileList;
unsigned int currentFile = 0;
unsigned int nFiles;
unsigned long totalCC = 0;
unsigned long totalWC = 0;
unsigned long totalLC = 0;

int main(int argc, char **argv) {
  FILE *file;
  fileList = argv + 1;
  nFiles = argc - 1;

  if (argc == 2) {
    // 하나의 파일만 다루는 경우, 여러 개의 파일을 다루는 경우를 다르게 취급
    currentFile = 1;
    file = fopen(argv[1], "r");
    if (!file) {
      fprintf(stderr, "could not open %s\n", argv[1]);
      exit(1);
    }
    yyin = file; // yyin은 lex의 표준 입력, 기본 값은 stdin
  }
  if (argc > 2) yywrap(); // 첫번째 파일을 연다.

  yylex();
  // 여기서도 0개 혹은 한 개의 파일만 다루는 경우와 여러 개의 파일을 다루는 경우를 다르게 취급
  if (argc > 2) {
    printf("%8lu %8lu %8lu %s\n", lineCount, wordCount, charCount, fileList[currentFile-1]);
    totalCC += charCount;
    totalWC += wordCount;
    totalLC += lineCount;
    printf("%8lu %8lu %8lu total\n", totalLC, totalWC, totalCC);
  } else {
    printf("%8lu %8lu %8lu\n", lineCount, wordCount, charCount);
  }

  return 0;
}

// EOF일 때 yywrap을 호출하는데 이때 새로운 파일을 연결하는 작업을 수행한다.
// yywrap() 함수는 반환값이 1일 때 더 이상 입력이 존재하지 않다고 판단한다.
int yywrap() {
  FILE *file = NULL;

  if ((currentFile != 0) && (nFiles > 1) && (currentFile < nFiles)) {
    // 이전 파일들을 위한 통계를 출력한다.
    printf("%8lu %8lu %8lu %s\n", lineCount, wordCount, charCount, fileList[currentFile-1]);
    totalCC += charCount;
    totalWC += wordCount;
    totalLC += lineCount;
    charCount = wordCount = lineCount = 0;
    fclose(yyin); // 해당 파일의 처리를 종료
  }

  while (fileList[currentFile] != (char *)0) {
    file = fopen(fileList[currentFile++], "r");
    if (file != NULL) {
      yyin = file;
      break;
    }
    fprintf(stderr, "could not open%s\n", fileList[currentFile-1]);
  }
  return (file ? 0 : 1); // file의 값이 0이면 입력이 더 있음을 의미한다.
}
