%{
#include "y.tab.h" 
extern int yylval;
FILE *yyin;
FILE *yyout;

char ident[30]="-";
char val[30]="-";
int scope=1;

char res[1024];
int line=0;

%}

alpha [_a-zA-Z]
digit [0-9]

%%
[\t\s]*"#".*\n[\t\s]*				{line++;};
 		

"import"				{strcat((char*)res,yytext);return IMPORT;}
"library"				{strcat((char*)res,yytext);return LIBRARY;}
"math"					{strcat((char*)res,yytext);return MATH;}


" "					{strcat((char*)res,yytext);return W;}


"print"  				{strcat((char*)res,yytext);return PRINT;}
"paste0"				{strcat((char*)res,yytext);return PASTE;}
"break"					{strcat((char*)res,yytext);return BRE;}
"ifelse"				{strcat((char*)res,yytext);return IFELSE;}
"if"					{strcat((char*)res,yytext);return IF;}
"else"					{strcat((char*)res,yytext);return ELSE;}
"list"					{strcat((char*)res,yytext);return LIST;}					
"seq"					{strcat((char*)res,yytext);return SEQ;}
"by"					{strcat((char*)res,yytext);return BY;}
"length"				{strcat((char*)res,yytext);return LEN;}
"out"					{strcat((char*)res,yytext);return OUT;}



"+"					{strcat((char*)res,yytext);return PLUS;}
"-"					{strcat((char*)res,yytext);return MINUS;}
"/"					{strcat((char*)res,yytext);return DIV;}
"*"					{strcat((char*)res,yytext);return MUL;}
"^"					{strcat((char*)res,yytext);return POW;}


"="					{strcat((char*)res,yytext);return	A1;}
"<-"					{strcat((char*)res,yytext);return	A2;}
"<<-"					{strcat((char*)res,yytext);return A3;}
"->"					{strcat((char*)res,yytext);return A4;}
"->>"					{strcat((char*)res,yytext);return A5;}


"<="   					{strcat((char*)res,yytext);return LE;}
">="					{strcat((char*)res,yytext);return GE;}
"=="					{strcat((char*)res,yytext);return COM;}
"!="					{strcat((char*)res,yytext);return NE;}
"<"					{strcat((char*)res,yytext);return LT;}
">"					{strcat((char*)res,yytext);return GT;}
"&&"|"&"				{strcat((char*)res,yytext);return AND;}
"||"|"|"   				{strcat((char*)res,yytext);return OR;}
"!"					{strcat((char*)res,yytext);return NOT;}
"++"					{strcat((char*)res,yytext);return INC;}
"--"					{strcat((char*)res,yytext);return DEC;}
"TRUE|FALSE"				{strcat((char*)res,yytext);return BOOL;}
"%%| %/% "				{strcat((char*)res,yytext);return PERC;}					


"c"					{strcat((char*)res,yytext);return C;}

{digit}+       				{strcat((char*)res,yytext);strcpy((char*)val,yytext);return NUM;}
{alpha}({alpha}|{digit}|_)* 		{strcat((char*)res,yytext);strcpy((char*)ident,yytext);return ID;}
[a-zA-Z0-9]+				{strcat((char*)res,yytext);return STR;}

"("					{strcat((char*)res,yytext);return OB;}
")"					{strcat((char*)res,yytext);return CB;}
":"					{strcat((char*)res,yytext);return CLN;}
"{"					{strcat((char*)res,yytext);++scope;return OCB;}
"}"					{strcat((char*)res,yytext);--scope;return CCB;}
"["					{strcat((char*)res,yytext);return OSB;}
"]"					{strcat((char*)res,yytext);return CSB;}
","					{strcat((char*)res,yytext);return COMMA;}				








\"					{strcat((char*)res,yytext);return QUO;}

"\n"					{line++; fprintf(yyout,"%d %s\n",line,(char*)res); strcpy((char*)res,"");}

.       				;

%%



