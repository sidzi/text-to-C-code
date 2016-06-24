%{
	#include <stdio.h>
	#include "y.tab.h"
%}
%%
include		{return INC;}
semicolon	{return SC;}
library[ ][a-zA-Z]+	{ yylval.str = strdup(yytext); return STRING;}
function	{return FUNC;}
variable[ ][a-zA-Z]+	{ yylval.str = strdup(yytext); return VARNAME;}
returns[ ]integer		{ yylval.str = strdup(yytext); return RTYPE;}
returns[ ]floating		{ yylval.str = strdup(yytext); return RTYPE;}
returns[ ]none			{ yylval.str = strdup(yytext); return RTYPE;}
print[ ][a-zA-Z]+		{ yylval.str = strdup(yytext); return PRINT;}

%%
int yyerror()
{
	printf("yyerror\n");
	return 1;
}
