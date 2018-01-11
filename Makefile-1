all: zNow

zNow: lex.yy.c parser.tab.c main.c
	gcc -o zNow -lm lex.yy.c parser.tab.c main.c
parser.tab.c: parser.y
	bison -d parser.y
lex.yy.c: flex.l
	flex flex.l
clean:
	rm -f zNow lex.yy.c parser.tab.h parser.tab.c
svnclean:
	rm -f zNow Makefile flex.l lex.yy.c parser.y parser.tab.c parser.tab.h
