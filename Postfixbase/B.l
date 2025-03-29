%{
#include "A.tab.h"
%}

%%
[0-9]+       { yylval.num = atoi(yytext); return NUMBER; }
[ \t\n]      { /* Skip whitespace */ }
"+"          { return PLUS; }
"*"          { return TIMES; }
"-"          { return MINUS; }
"/"          { return DIVIDE; }
"("          { return LPAREN; }
")"          { return RPAREN; }
.            { return yytext[0]; }
%%

int yywrap(void) { return 1; }
