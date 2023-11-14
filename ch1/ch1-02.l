%{

%}

%%

[\t ]+ ;
is |    
am |
are |
was |
be |
being |
been |
do |
does |
did |
will |
would |
should |
go { printf("%s: is a verb\n", yytext); }
[a-zA-Z]+ { printf("%s: is not a verb\n", yytext); }

.|\n { ECHO; }
%%

int main()
{
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
