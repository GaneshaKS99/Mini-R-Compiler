%{
#include<stdio.h>
#include<stdlib.h>
//#include "ast.h"
#include "symboltable.c"
#define STACKSIZE 100

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

char stack[STACKSIZE][15];
int temp_top = -1;
char temp_var[2];
char temp_count[2]="0";
int label[20],label_num=0,ltop=-1;


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
%token PERC TRU FAL INC DEC LIST
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
|TRU
{
	$$.value.val=1;
	
}
|FAL
{
	$$.value.val=0;
}
|q {strcpy($$.value.str,$1.value.str);}
;

if:IF OB exp CB{if1();} OCB s CCB {if2();} else;

else:ELSE OCB s CCB{if3();}| ;
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
{
		
	char val[30];
	pushToStack($1.value.str); 
 	strcpy(val,getval(head,$1.value.str,scope));
        if(strcmp(val,"-1")==0)
        {
            
            yyerror("No value assigned to variable");
        }
        else
        {
	    strcpy($$.value.str,val);
	   
        }
}
|NUM
{
	strcpy($$.value.str,$1.value.str);
	pushToStack($1.value.str);	
	
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
		pushToStack("+");
        	codegen();

	}

|E MINUS T
	{
		float val = (float)atof($1.value.str) - (float)atof($3.value.str);
		char str[10];
		gcvt(val,6,str);
		strcpy($$.value.str,str);
		pushToStack("-");
        	codegen();

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
		pushToStack("*");
        	codegen();

	}	

|T DIV F
	{
		
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
				pushToStack("/");
        			codegen();

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


relop: LT {$$.value.op = LT;pushToStack("<");}
| GT 	  {$$.value.op = GT;pushToStack(">");}
| COM 	  {$$.value.op = COM;pushToStack("==");}
| LE 	  {$$.value.op = LE;pushToStack("<=");}
| GE 	  {$$.value.op = GE;pushToStack(">=");}
| NE	  {$$.value.op = NE;pushToStack("!=");}
;


logop: l OR logop 



| l;

l: n AND l | n;
n: NOT o | o;
o: OB exp CB | r ;

assignexp1: ID A1 i 
{

head = pushIntoTable(head,line,$1.value.str,$3.value.str,scope);
pushToStack($1.value.str);
pushToStack("=");
codegen_assign();
}
| ID A2 i 
{

head = pushIntoTable(head,line,$1.value.str,$3.value.str,scope);
pushToStack($1.value.str);
pushToStack("=");
codegen_assign();

}
| ID A3 i 
{

head = pushIntoTable(head,line,$1.value.str,$3.value.str,scope);
pushToStack($1.value.str);
pushToStack("=");
codegen_assign();

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

head = pushIntoTable(head,line,$3.value.str,$1.value.str,scope);
pushToStack($3.value.str);
pushToStack("=");
codegen_assign();

}
|i A5 ID 
{

head = pushIntoTable(head,line,$3.value.str,$1.value.str,scope);
pushToStack($3.value.str);
pushToStack("=");
codegen_assign();


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


void pushToStack(char* val)
{
    if(temp_top == STACKSIZE)
        printf("Stack Overflow\n");
    else
        strcpy(stack[++temp_top],val);
}

void popFromStack()
{
    if(temp_top == -1)
        printf("Stack Underflow\n");
    else
        temp_top--;
}

void codegen()
{
	strcpy(temp_var,"t");
	strcat(temp_var,temp_count);
	printf("\n\t%s = %s %s %s",temp_var,stack[temp_top-2],stack[temp_top],stack[temp_top-1]);

    
    
	popFromStack();
    popFromStack();
    popFromStack();
	pushToStack(temp_var);
	temp_count[0]++;
}

void codegen_assign()
{
   
	printf("\n\t%s = %s",stack[temp_top-1],stack[temp_top-2]);

    
    popFromStack();
    popFromStack();
}
void if1()
{
	label_num++;
	strcpy(temp_var,"t");
	strcat(temp_var,temp_count);
	printf("\n\t%s = %s %s %s",temp_var,stack[temp_top-2],stack[temp_top-1],stack[temp_top]);
   
    printf("\n\tifFalse %s goto L%d",temp_var,label_num);
    char str[5];
    sprintf(str,"%d",label_num);

	
    temp_count[0]++;
	label[++ltop]=label_num;
}
void if2()
{
	label_num++;
	printf("\ngoto L%d\n",label_num);
	printf("L%d: \n",label[ltop--]);
	label[++ltop]=label_num;
}

void if3()
{
    int y = label[ltop--];
	printf("\nL%d:",y);
    char str[5];
    sprintf(str,"%d",y);


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
		printf("\n\nSuccess\n");
			
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






