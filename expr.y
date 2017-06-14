%{
#include <ctype.h>
#include <stdio.h>
%}

%token LINENUM
%token REM
%token GOTO
%token LET
%token DIM
%token AS
%token PRINT
%token INPUT
%token VAR
%token PLUS
%token MINUS
%token MODULO
%token MULTI
%token DIVIDE
%token UNARY_OP
%token IF
%token THEN
%token DIGIT
%token STRING
%%

program	: line
	| line program
	; 

line	: LINENUM command '\n'
	;

command : REM STRING			{printf("This is comment\n");}	
	| GOTO INTEGER			{printf("goto statement number  %d", yylval);}
	| LET VAR '=' expr		{printf("this is assginment statemnt\n");}
	| LET VAR '[' expr ']' '=' expr	{printf("this is also assignment\n");}
	| DIM VAR AS '[' expr ']'
	| PRINT expr
	| INPUT VAR
	| IF expr THEN INTEGER
	;

expr	: expr PLUS term	
	| expr MINUS term
	| VAR
	| term
	;

term	: term DIVIDE factor
	| term MULTI factor
	| factor
	;

factor	: '(' expr ')'
	| INTEGER
	| UNARY_OP factor
	;

INTEGER : INTEGER DIGIT
	| DIGIT
	;
%%


int yyerror(char const* s)
{
	fprintf(stderr, "%s\n", s);
}



int main(void)
{
	yyparse();
	return 0;
}


