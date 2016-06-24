sweet:
	lex cnnh.l
	yacc -d --debug --verbose cnnh.y
	gcc lex.yy.c y.tab.c -ll

bitter:
	lex cnnh.l
	yacc -d cnnh.y
	gcc lex.yy.c y.tab.c -ll


