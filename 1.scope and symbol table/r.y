%{
#include<stdio.h>
#include<stdlib.h>
#include "symboltable.c"
int yyerror(char* s);
int yywrap();

extern int curLn;
extern int curPos;
extern FILE *yyin;

extern FILE *yyout;
extern int line;
extern char ident[30];
extern char val[30];
extern int scope;

Node* head=NULL;






int yylex();
%}
%token  IMPORT LIBRARY MATH

%token 	PRINT  PASTE  BRE
%token ELSE IF IFELSE

%token  QUO  W COMMA
%token  NUM STR	ID

%token A1 A2 A3 A4 A5

%token 	OB CB OCB CCB OSB CSB CLN 

%token PLUS MINUS DIV MUL POW

%token LE GE COM NE LT GT AND OR NOT
%token PERC BOOL INC DEC LIST
%token SEQ BY LEN OUT C



%%

problem:header|s;
header:h s ;
h:IMPORT W LIBRARY OB QUO MATH QUO CB|IMPORT W LIBRARY OB MATH CB ;

s:print s
|paste s
|if s
|func s
| assignexp1 s 
| assignexp2 s 
|break s| ;

print:PRINT OB printvalue CB |PRINT OB QUO printvalue QUO CB;
printvalue:r|range;
range: NUM CLN NUM| vector | seq;
seq: SEQ OB NUM COMMA NUM extraopt CB;
extraopt: extra|;
extra: COMMA BY A1 NUM | COMMA LEN'.'OUT A1 NUM;

paste: PASTE OB lisvar CB|  PASTE OB QUO lisvar QUO CB;
break: BRE;
 

r:STR|BOOL|q;

if:IF OB exp CB OCB s CCB c ;
c:ELSE W IF OB exp CB OCB s CCB c| ELSE OCB s CCB| ;
func:IFELSE OB exp COMMA r COMMA r CB | IFELSE OB exp COMMA QUO r QUO COMMA QUO r QUO CB ; 

exp: r calc exp | NOT exp |r;
  
q:ID|NUM;

calc: relop | logop |arithop;

E:E PLUS T|E MINUS T| T;
T:T MUL F|T DIV F|F;
F:r{head=pushIntoTable(head,line,(char*)ident,(char*)val,scope);strcpy(val,"-");strcpy(ident,"-");}
|OB E CB;


arithop : PLUS | MINUS | PERC | DIV | MUL;
relop: LT | GT | COM | LE | GE | NE;
logop: l OR logop | l;

l: n AND l | n;
n: NOT o | o;
o: OB exp CB | r ;

assignexp1: u A1 i 	
| u A2 i 
| u A3 i 
;

u:STR|ID;
li:LIST OB lisvar CB;
i:E|li|vector;
lisvar: r COMMA lisvar|r;

vector: C OB lisvar CB;

assignexp2: i A4 u 
|i A5 u 
;


%%

int yyerror(char *s)
{
printf("%s at line : %d\n",s,line);


printf("SYMBOL TABLE\n");
printf("\tLINE\t\tID\t\tVALUE\t\tSCOPE\n");

printTable(head);
exit(0);
return 0;
}
int yywrap()
{
	return 1;
}

int main(int argc,char* argv[]) 
{
	FILE *fp = fopen(argv[1],"r");
	if(!fp)
	{
	printf("unable to open");
	exit(0);
	}
	
	
	yyin = fp;

	FILE *fp2 = fopen("out.R","w");
	if(!fp)
	{
	printf("unable to open");
	exit(0);
	}

	
	yyout = fp2;


	if(!yyparse())
	{
		printf("Success\n");
			
	}
	else 
	{
		printf("Unsuccessfull\n");
	}
	printf("SYMBOL TABLE\n");
	printf("\tLINE\t\tID\t\tVALUE\t\tSCOPE\n");

	printTable(head);
	

	return 0;

}






