all:
	lex r.l
	yacc -v -d r.y
	gcc y.tab.h y.tab.c lex.yy.c -ll
