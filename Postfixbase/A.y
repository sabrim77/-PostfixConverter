%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>  
void yyerror(const char *s);
int yylex(void);
%}

%union {
    int num;       // For numeric values
    char *str;     // For postfix expressions
}

%token <num> NUMBER
%token PLUS MINUS TIMES DIVIDE LPAREN RPAREN

%type <str> expr

%left PLUS MINUS
%left TIMES DIVIDE

%%

expr: expr PLUS expr      {
                              char *result = malloc(strlen($1) + strlen($3) + 4);
                              sprintf(result, "%s %s +", $1, $3);
                              printf("Postfix: %s\n", result);
                              free($1);
                              free($3);
                              $$ = result;
                          }
    | expr MINUS expr     {
                              char *result = malloc(strlen($1) + strlen($3) + 4);
                              sprintf(result, "%s %s -", $1, $3);
                              printf("Postfix: %s\n", result);
                              free($1);
                              free($3);
                              $$ = result;
                          }
    | expr TIMES expr     {
                              char *result = malloc(strlen($1) + strlen($3) + 4);
                              sprintf(result, "%s %s *", $1, $3);
                              printf("Postfix: %s\n", result);
                              free($1);
                              free($3);
                              $$ = result;
                          }
    | expr DIVIDE expr    {
                              char *result = malloc(strlen($1) + strlen($3) + 4);
                              sprintf(result, "%s %s /", $1, $3);
                              printf("Postfix: %s\n", result);
                              free($1);
                              free($3);
                              $$ = result;
                          }
    | NUMBER              {
                              char buffer[32];
                              snprintf(buffer, sizeof(buffer), "%d", $1);
                              $$ = strdup(buffer);
                          }
    | LPAREN expr RPAREN  {
                              $$ = $2;
                          }
    ;

%%

int main(void) {
    printf("Enter an expression: ");
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
