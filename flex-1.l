%{
#include <stdio.h>
#include "parser.tab.h"
%}
%option noyywrap
%%
(?i:TOK_2COLON) { return TOK_2COLON; }
(?i:TOK_2DOT) { return TOK_2DOT; }
(?i:TOK_2GT) { return TOK_2GT; }
(?i:TOK_2LT) { return TOK_2LT; }
(?i:TOK_2SLASH) { return TOK_2SLASH; }
(?i:TOK_AT) { return TOK_AT; }
(?i:TOK_BAR) { return TOK_BAR; }
(?i:TOK_COMMA) { return TOK_COMMA; }
(?i:TOK_DECIMALLITERAL) { return TOK_DECIMALLITERAL; }
(?i:TOK_DOT) { return TOK_DOT; }
(?i:TOK_DOUBLELITERAL) { return TOK_DOUBLELITERAL; }
(?i:TOK_EQ) { return TOK_EQ; }
(?i:TOK_GE) { return TOK_GE; }
(?i:TOK_GT) { return TOK_GT; }
(?i:TOK_INTEGERLITERAL) { return TOK_INTEGERLITERAL; }
(?i:TOK_LE) { return TOK_LE; }
(?i:TOK_LPAREN) { return TOK_LPAREN; }
(?i:TOK_LSQBRK) { return TOK_LSQBRK; }
(?i:TOK_LT) { return TOK_LT; }
(?i:TOK_MINUS) { return TOK_MINUS; }
(?i:TOK_NCNAME) { return TOK_NCNAME; }
(?i:TOK_NCNAME_COLON_STAR) { return TOK_NCNAME_COLON_STAR; }
(?i:TOK_NE) { return TOK_NE; }
(?i:TOK_PLUS) { return TOK_PLUS; }
(?i:TOK_QNAME) { return TOK_QNAME; }
(?i:TOK_RPAREN) { return TOK_RPAREN; }
(?i:TOK_RSQBRK) { return TOK_RSQBRK; }
(?i:TOK_SEMICO) { return TOK_SEMICO; }
(?i:TOK_SLASH) { return '/'; }
(?i:TOK_STAR) { return TOK_STAR; }
(?i:TOK_STAR_COLON_NCNAME) { return TOK_STAR_COLON_NCNAME; }
(?i:TOK_STRINGLITERAL) { return TOK_STRINGLITERAL; }
(?i:TOK_VARNAME) { return TOK_VARNAME; }
(?i:and) { return and; }
(?i:attribute) { return attribute; }
(?i:child) { return child; }
(?i:comment) { return comment; }
(?i:declare) { return declare; }
(?i:default) { return TOK_DEFAULT; }
(?i:descendant) { return descendant; }
(?i:descendant-or-self) { return descendant_or_self; }
(?:div) { return TOK_DIV; }
(?i:document-node) { return document_node; }
(?i:element) { return element; }
(?i:empty) { return empty; }
(?i:eq) { return eq; }
(?i:ge) { return ge; }
(?i:gt) { return gt; }
(?i:idiv) { return idiv; }
(?i:is) { return is; }
(?i:le) { return le; }
(?i:lt) { return lt; }
(?i:mod) { return mod; }
(?i:namespace) { return namespace; }
(?i:ne) { return ne; }
(?i:node) { return node; }
(?i:or) { return or; }
(?i:parent) { return parent; }
(?i:processing-instruction) { return processing_instruction; }
(?i:self) { return self; }
(?i:text) { return text; }
(?i:to) { return to; }
(?i:union) { return TOK_UNION; }
%%
