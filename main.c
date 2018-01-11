#include "parser.tab.h"
extern int yydebug;

int main(void) {
	int returnVal;
	yydebug = 1;
	returnVal = yyparse();

	if(returnVal == 0)
		printf("\n\nPassed\n");
	else
		printf("\n\nfailed\n");

	return returnVal;
}
