#include<stdio.h>
#include<stdlib.h>
#include<string.h>

struct symtable
{
    int line;
    //char type[10];
    char name[30];
    char value[50];
    int scope;
    struct symtable* next;
};
typedef struct symtable Node;


int checkTable(Node* head,char* name,int line,char* value,int scope)
{
    Node* temp = head;
    while(temp!=NULL){
        if(strcmp(name,(char*)temp->name)==0 && scope==temp->scope )
	{
	    strcpy(temp->value,value);
	    temp->line=line;
            return 1;

	}
        temp=temp->next;
    }
    return -1;
}


Node* pushIntoTable(Node* head,int line,char* name,char* value,int scope)
{
    int validate = checkTable(head,name,line,value,scope);
    Node* temp = head;
    int flag=0;
    if (validate == 1)
    {
        return head;
    }  
     
    

    Node* new = (Node*)malloc(sizeof(Node));
    new->line = line;
    
    strcpy((char*)new->name,name);
    strcpy((char*)new->value,value);
    new->scope=scope;
    new->next = head;
    head = new;
    return head;
}


void printTable(Node* head)
{

    if(head == NULL){ 
        return;
    }
    while(head!=NULL){
	if(strcmp((char*)head->name,"-")!=0)
        printf("|\t%d\t|\t%s\t|\t%s\t|\t%d\t|\n",head->line,(char*)head->name,(char*)head->value,head->scope);
        head = head->next;
    }

}

