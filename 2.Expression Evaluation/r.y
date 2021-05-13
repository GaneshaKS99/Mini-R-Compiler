%{
#include<stdio.h>
#include<stdlib.h>
//#include "ast.h"
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


%token A1 A2 A3 A4 A5

%token 	OB CB OCB CCB OSB CSB CLN 

%token PLUS MINUS DIV MUL POW

%token LE GE COM NE LT GT AND OR NOT
%token PERC BOOL INC DEC LIST
%token SEQ BY LEN OUT C
%left PLUS MINUS MUL DIV
%right POW A1
%code requires {#include "ast.h"}
%union 
{
    struct BTree tree;
    int bool;
}

%type<tree> E T F i q r relop exp if calc arithop assignexp1
%token<tree> NUM STR ID

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
 

r:STR
|BOOL
|q {strcpy($$.value.str,$1.value.str);}
;

if:IF OB exp CB OCB s CCB c;
c:ELSE W IF OB exp CB OCB s CCB c| ELSE OCB s CCB| ;
func:IFELSE OB exp COMMA r COMMA r CB | IFELSE OB exp COMMA QUO r QUO COMMA QUO r QUO CB ; 

exp: r calc exp 
{
        int flag = 0;
        if($2.value.op == COM)
        {
            if($1.value.val == $3.value.val)
            {    
                $$.value.val = 1;
                flag = 1;
            }
        }
        else if($2.value.op == LT) 
        {
            if($1.value.val < $3.value.val)
            {
                $$.value.val = 1;
		
                flag = 1;
            }
        }
        else if($2.value.op == GT) 
        {
            if($1.value.val > $3.value.val)
            {
                $$.value.val = 1;
                flag = 1;
            }
        }
        else if($2.value.op == GE) 
        {
            if($1.value.val >= $3.value.val)
            {
                $$.value.val = 1;
                flag = 1;
            }
        }
        else if($2.value.op == LE)
        {
            if($1.value.val <= $3.value.val)
            {
                $$.value.val = 1;
                flag = 1;
            }
        }
        else if($2.value.op == NE)
        {
            if($1.value.val != $3.value.val)
            {
                $$.value.val = 1;
                flag = 1;
            }
        }
        if(flag == 0)
            {$$.value.val = 0;}
}


| NOT exp |r;
  
q:ID
|NUM
{
	strcpy($$.value.str,$1.value.str);
	//printf("%s\n",$$.value.str);
}
;

calc: relop {
	$$.value.op=$1.value.op;
}

| logop 


|arithop
{
$$.value.op=$1.value.op;
};

E:E PLUS T
 	{
		float val = (float)atof($1.value.str) + (float)atof($3.value.str);
		char str[10];
		gcvt(val,6,str);
		strcpy($$.value.str,str);

	}
	
|E MINUS T
	{
		float val = (float)atof($1.value.str) - (float)atof($3.value.str);
		char str[10];
		gcvt(val,6,str);
		strcpy($$.value.str,str);

	}

| T 
	{
		strcpy($$.value.str,$1.value.str);
	}
;


T:T MUL F
	{
		float val = (float)atof($1.value.str) * (float)atof($3.value.str);
		char str[10];
		gcvt(val,6,str);
		strcpy($$.value.str,str);

	}	

|T DIV F
	{
		//printf("%s %s",$1.value.str,$3.value.str);
		if(atof($3.value.str) == 0)
        		{
            			yyerror("Divided by zero error");
            
        		}
        	else 
        		{
            			float val = (float)atof($1.value.str) / (float)atof($3.value.str);
	    			char str[10];
	    			gcvt(val,6,str);
            			strcpy($$.value.str,str);

        		}
	}
|F 
	{
		strcpy($$.value.str,$1.value.str);
	}
;

F:r 
	{
		strcpy($$.value.str,$1.value.str);
	}

|OB E CB;


arithop : PLUS {$$.value.op = PLUS; }
| MINUS        {$$.value.op = MINUS; }
| PERC         {$$.value.op = PERC; }
| DIV          {$$.value.op = DIV; }
| MUL	       {$$.value.op = MUL; };


relop: LT {$$.value.op = LT;}
| GT 	  {$$.value.op = GT;}
| COM 	  {$$.value.op = COM;}
| LE 	  {$$.value.op = LE;}
| GE 	  {$$.value.op = GE;}
| NE	  {$$.value.op = NE;}
;


logop: l OR logop 



| l;

l: n AND l | n;
n: NOT o | o;
o: OB exp CB | r ;

assignexp1: ID A1 i 
{
//printf("assign : %s\n",$3.value.str);
head = pushIntoTable(head,line,$1.value.str,$3.value.str,scope);
}
| ID A2 i 
{
//printf("assign : %s\n",$3.value.str);
head = pushIntoTable(head,line,$1.value.str,$3.value.str,scope);
}
| ID A3 i 
{
//printf("assign : %s\n",$3.value.str);
head = pushIntoTable(head,line,$1.value.str,$3.value.str,scope);
}
;


li:LIST OB lisvar CB;
i:E {strcpy($$.value.str,$1.value.str);
}
|li
|vector
;
lisvar: r COMMA lisvar|r;

vector: C OB lisvar CB;

assignexp2: i A4 ID 
{
//printf("assign : %s\n",$1.value.str);
head = pushIntoTable(head,line,$3.value.str,$1.value.str,scope);
}
|i A5 ID 
{
//printf("assign : %s\n",$1.value.str);
head = pushIntoTable(head,line,$3.value.str,$1.value.str,scope);
}
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
	
//a:IF OB e CB OCB s CCB	c|IF OB e CB OCB s CCB ;
//c:ELSE W IF OB e CB OCB s CCB y	| ELSE W IF OB e CB OCB s CCB | ELSE OCB s CCB |y;
//y:c|;


	
	//yyin=fopen(argv[1],"r");
	
	//yyout = fopen("out.R","w");
	
	//yylex();
	return 0;

}






