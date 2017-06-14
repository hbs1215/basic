%{
#include <stdlib.h>
#include "expr.tab.h"
%}

%x comment
%x printCommand

newLine		"\n"
lineNum		^[0-9]+[\ ]
digit		[0-9]
variable	[a-zA-Z]+
plus		"+"
minus		"-"
multiply	"*"
divide		"/"
modulo		"%"
rem		(REM)

rstart		{rem}
rstop		"\n"
rinside		[0-9a-zA-Z\ .*]+

goto		(GOTO)
let		(LET)
input		(INPUT)
dim		(DIM)
as		(AS)
print		(PRINT)
if		(IF)
then		(THEN)

space		"\ "

%%
{lineNum}	{yylval = atoi(yytext); return LINENUM;}
{newLine}	{return *yytext;}
{digit}		{yylval = atoi(yytext);	return DIGIT;}
{rstart}	{BEGIN(comment); return REM;}
{goto}{space}?	{yylval = atoi(yytext); return GOTO;}
<comment>{rstop}	{BEGIN(INITIAL); return *yytext;}
<comment>{rinside}	{return STRING;}
{plus}	{yylval = atoi(yytext); return PLUS;}
{minus} {yylval = atoi(yytext); return MINUS;}
{multiply} {yylval = atoi(yytext); return MULTI;}
{let}{space}?	{return LET;}
{variable}	{yylval = atoi(yytext); return VAR;}

{space}	{yylval = atoi(yytext);}
.	{return *yytext;}
%%

int yywrap(void)
{
	return 1;
}
