# -*- coding: utf-8 -*-
import subprocess
inputfilename = "xpath.bnf"
input = open(inputfilename, "r")
# file to contain main program.  Write it yourself.
mainfilename = "main.c"
# should end in .y
bisonfilename = "parser.y"
# should end in .l
flexfilename = "flex.l"
# seriously, what else do you name a makefile?
makefilename = "Makefile"

print "Creating makefile (" + makefilename + ")..." ,

m = open(makefilename, "w")
m.write("all: zNow\n\n")
m.write("zNow: lex.yy.c " + bisonfilename[0:-1] + "tab.c " + mainfilename + "\n" +
		"\tgcc -o zNow -lm lex.yy.c " + bisonfilename[0:-1]+"tab.c " + mainfilename + "\n" )
m.write(bisonfilename[0:-1]+"tab.c: " + bisonfilename + "\n" + 
		"\tbison -d " + bisonfilename + "\n")
m.write("lex.yy.c: " + flexfilename + "\n" +
		"\tflex " + flexfilename + "\n")
m.write("clean:\n\trm -f zNow lex.yy.c " + bisonfilename[0:-1] + "tab.h " + bisonfilename[0:-1] + "tab.c\n" )
m.write("svnclean:\n\trm -f zNow " + makefilename + " " + flexfilename + " lex.yy.c " + bisonfilename + " " + bisonfilename[0:-1]+"tab.c " + bisonfilename[0:-1]+"tab.h\n")
m.flush()
m.close()

print "done."

input_to_pattern = {
		"div": "(?:div)",
		"descendant-or-self": "(?i:descendant-or-self)",
		"document-node": "(?i:document-node)",
		"processing-instruction":"(?i:processing-instruction)",
		"default": "(?i:default)",
		"union": "(?i:union)"
		}
input_to_token = {
		"div": "TOK_DIV",
		"descendant-or-self": "descendant_or_self",
		"document-node": "document_node",
		"processing-instruction":"processing_instruction",
		"default": "TOK_DEFAULT",
		"union": "TOK_UNION"
		}

state = 0
# State 0 is default
# State 1 is block comment /. ./
# State 2 is %Names block

bnf = input.readlines()

tokenlist = []

for line in bnf:
	line = line.split("--",1)[0] # nuke comments
	line = line.split("*/",1)[0] # nuke another comment type
	line = line.rstrip() # nuke whitespace
	if "EOF_SYMBOL" in line:
		line = ""
	# Switch on state
	if state == 0: # default state
		if len(line) > 0 and line[0] == '%':
			if line[1] == 'N':
				state = 2
			line = "" # Strip Jikespg options.
		tmp = line.split("/.")
		if len(tmp) > 1: # We've started a big block comment
			state = 1
			line = tmp[0]
	elif state == 1: # after /., before ./
		tmp = line.split("./",1)
		if len(tmp) > 1:
			state = 0
			line = tmp[1]
	elif state == 2:
		if len(line) > 0 and line[0] == '%' and line[1] == 'E':
			state = 0
		line = ""
	for token in line.split():
		if(token != "%EMPTY"): # We have no need to explicitly denote empty patterns
			tokenlist.append(token)

assignindexlist = [] # A list of the indices that contain the assignment token
idex = 0
while idex < len(tokenlist):
	if tokenlist[idex] == "::=":
		assignindexlist.append(idex)
	idex = idex + 1

toks = set()
for t in tokenlist:
	toks.add(t)

toks.remove("::=")


ntindex = 0
while ntindex < len(assignindexlist):
	a = assignindexlist[ntindex] - 1
	toks.remove(tokenlist[a])
	ntindex = ntindex+1
# Now toks has a list of all the terminal tokens
sortedlist = []
for tok in toks:
	sortedlist.append(tok)
sortedlist.sort()

print "Found " + str(len(sortedlist)) + " terminal tokens."
print "Found " + str(len(assignindexlist)) + " rules."

print "Writing flex input file (" + flexfilename + ")..." ,
flex = open(flexfilename, "w")

# Generate the flex output
flex.write("%{\n" +
		"#include <stdio.h>\n"
		"#include \"" + bisonfilename[0:-1] + "tab.h" +"\"\n"
		"%}\n"
		"%option noyywrap\n"
		"%%\n"
		)

for tok in sortedlist:
	if tok in input_to_pattern.keys():
		flex.write(input_to_pattern[tok]);
	elif tok == "|":
		continue
	else:
		flex.write("(?i:" + tok + ")") # case insensitive keywords
	flex.write(" { return ")
	if tok in input_to_token.keys():
		flex.write(input_to_token[tok])
	else:
		flex.write(tok)
	flex.write("; }\n")

flex.write("%%\n")
flex.flush()
flex.close()

print "done."

# Generate the bison output

print "Writing bison input file (" + bisonfilename + ")..." ,
bison = open(bisonfilename, "w")

# header declarations
bison.write("%{\n"
		+ "#include <stdio.h>\n"
		+ "#define YYSTYPE char*\n"
		+ "#define YYDEBUG 1\n"
		+ "int yylex(void);\n"
		+ "void yyerror(const char* s);\n"
		+ "%}\n"
		+ "%glr-parser\n")

# token list
for item in sortedlist:
	if item in input_to_token.keys():
		if item != "<identifier>":
			bison.write("%token " + input_to_token[item] + "\n")
		else: # Messy, but allows us to relax keywords into identifiers
			bison.write("%token PURE_IDENTIFIER\n")
	else:
		if item != "|":
			bison.write("%token " + item + "\n")
bison.write("%%\n")

#This block writes out the full converted bison rules.
assignment = 0
while assignment < len(assignindexlist):
	bison.write(tokenlist[assignindexlist[assignment]-1] + " :\n      ")
	# print out each token between assignindexlist[assignment]+1 and assignindexlist[assignment+1]-2
	if(assignment == len(assignindexlist) - 1):
		end = len(tokenlist)
	else:
		end = assignindexlist[assignment+1] -1
	for tindex in xrange(assignindexlist[assignment]+1,end):
		#print out the token where it belongs
		token = tokenlist[tindex]
		if( token in input_to_token.keys()):
			bison.write(input_to_token[token] + " ")
		elif token == "!":
			bison.write("\n    | ")
		else:
			bison.write( token + " ")
	bison.write("\n    ;\n\n")
	assignment = assignment +1

kwds = set()
for kw in tokenlist:
	if kw.isalpha() and kw.isupper() :
		if kw in input_to_token:
			kwds.add(input_to_token[kw])
		else:
			kwds.add(kw)
# We actually don't want this rule reduction.  Which means we may refactor the whole PURE_IDENTIFIER deal again, and make a new bison GLR skeleton.
#for kw in sorted(list(kwds)) :
#	bison.write("    | " + kw + "\n")
bison.write("    ;\n")

bison.write("%%\n")
# Write code or provide it elsewhere

bison.write("void yyerror(const char* s) {\n"
		+ "\tfprintf(stderr,\"error: %s\\n\",s);\n"
		+ "}\n")

bison.flush()
bison.close()

print "done."
print "Executing make:"

subprocess.call("make")

print "Done.  Execute with:\n./zNow\n"

