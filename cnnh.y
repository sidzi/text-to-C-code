%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	int yydebug=1;
	char program[500]="";
%}
%union {
    char *str;
}
%token NUM
%token ID
%left '+' '-'
%left '*' '/'
%token SC
%token VARNAME
%token STRING
%token FUNC
%token RTYPE
%token INC
%token DEF
%token PRINT
%type <str> LIBNAME
%type <str> RTY
%type <str> VAR
%type <str> STMT
%start START
%%
START   : PPDS BODY	{strcat(program,"}\n");}
		;
BODY	: FDEF
		{
			strcat(program,"}\n");
		}
		|BODY FDEF
		;
PPDS	:PPD
		|PPDS PPD
		;

PPD	:	INC LIBNAME	{
						{printf("Preprocessor Directive Found\n");}
						strcat(program,"#include ");
						strcat(program,$2);
						strcat(program,"\n");
		}
		;
LIBNAME	:	STRING
		{
			if(strcmp(yylval.str,"library input")==0)
			{
				strcpy($$,"<stdio.h>");
			}
			if(strcmp(yylval.str,"library string")==0)
			{
				strcpy($$,"<string.h>");
			}
			if(strcmp(yylval.str,"library math")==0)
			{
				strcpy($$,"<math.h>");
			}
			else
			{
				printf("LibError\n");
			}
		}
		;
FDEF	:	FD STMT
			{
				strcat(program,";");
			}
		;
FD 		:	FUNC VAR RTY
			{
					strcat(program,"\n");
					strcat(program,$3);
					strcat(program," ");
					strcat(program,$2);
					strcat(program,"()\n{\n");
			}
VAR 	:	VARNAME
			{
				char *tok,*cp;
				cp = strdup(yylval.str);
				char space[] = " ";
				tok = strtok(cp,space);
				tok = strtok(NULL,space);
				printf("\nVariable name :%s\n",tok);
				strcpy($$,tok);
			}
		;
RTY		:	RTYPE
			{
				char *tok,*cp;
				cp = strdup(yylval.str);
				char space[] = " ";
				tok = strtok(cp,space);
				tok = strtok(NULL,space);
				printf("\nReturn Type :%s\n",tok);
				if (strcmp(tok,"none")==0)
				{
					strcpy(tok,"void");
				}
				if (strcmp(tok,"integer")==0)
				{
					strcpy(tok,"int");
				}
				if (strcmp(tok,"floating")==0)
				{
					strcpy(tok,"float");
				}
				strcpy($$,tok);	
			}
		;
STMT		: PRINT
			{
				char *tok,*cp;
				cp = strdup(yylval.str);
				char space[] = " ";
				tok = strtok(cp,space);
				tok = strtok(NULL,space);
				char printsm[20];
				strcat(printsm,"printf(\"\%s\",");
				strcat(printsm,tok);
				strcat(printsm,")");
				strcat(program,printsm);
			}
%%
int main()
{
	// YYSTYPE yylval;
	if(yyparse()==0)
	{
		printf("Success");
	}
	printf("\n***:Generated Code:***\n%s\n",program);
}
