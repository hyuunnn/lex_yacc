%{
#include <stdio.h>
void yyerror(const char *s);
%}

%token NOUN PRONOUN VERB ADVERB ADJECTIVE PREPOSITION CONJUNCTION

%%

sentence: subject VERB object { printf("Sentence is valid.\n"); }
      ;
subject: NOUN
      |  PRONOUN
      ;
object:  NOUN
      ;
%%

extern FILE *yyin;
int main() {
  do {
    yyparse();
  } while (!feof(yyin));
}

void yyerror(const char *s) {
  fprintf(stderr, "%s\n", s);
}
