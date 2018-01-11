%{
#include <stdio.h>
#define YYSTYPE char*
#define YYDEBUG 1
int yylex(void);
void yyerror(const char* s);
%}
%glr-parser
%token TOK_2COLON
%token TOK_2DOT
%token TOK_2GT
%token TOK_2LT
%token TOK_2SLASH
%token TOK_AT
%token TOK_BAR
%token TOK_COMMA
%token TOK_DECIMALLITERAL
%token TOK_DOT
%token TOK_DOUBLELITERAL
%token TOK_EQ
%token TOK_GE
%token TOK_GT
%token TOK_INTEGERLITERAL
%token TOK_LE
%token TOK_LPAREN
%token TOK_LSQBRK
%token TOK_LT
%token TOK_MINUS
%token TOK_NCNAME
%token TOK_NCNAME_COLON_STAR
%token TOK_NE
%token TOK_PLUS
%token TOK_QNAME
%token TOK_RPAREN
%token TOK_RSQBRK
%token TOK_SEMICO
%token TOK_SLASH
%token TOK_STAR
%token TOK_STAR_COLON_NCNAME
%token TOK_STRINGLITERAL
%token TOK_VARNAME
%token and
%token attribute
%token child
%token comment
%token declare
%token TOK_DEFAULT
%token descendant
%token descendant_or_self
%token TOK_DIV
%token document_node
%token element
%token empty
%token eq
%token ge
%token gt
%token idiv
%token is
%token le
%token lt
%token mod
%token namespace
%token ne
%token node
%token or
%token parent
%token processing_instruction
%token self
%token text
%token to
%token TOK_UNION
%%
Goal :
      Prolog Expr 
    ;

Prolog : 
      | Prolog Prolog1 
    ;

Prolog1 :
      declare namespace NCName TOK_EQ TOK_STRINGLITERAL TOK_SEMICO | declare TOK_DEFAULT element namespace TOK_STRINGLITERAL TOK_SEMICO 
    ;

PathExpr :
      TOK_SLASH RelativePathExpr | TOK_2SLASH RelativePathExpr | RelativePathExpr 
    ;

RelativePathExpr :
      StepExpr | RelativePathExpr TOK_SLASH StepExpr | RelativePathExpr TOK_2SLASH StepExpr 
    ;

StepExpr :
      AxisStep | FilterExpr 
    ;

AxisStep :
      ForwardStep PredicateList | ReverseStep PredicateList 
    ;

ForwardStep :
      ForwardAxis NodeTest | AbbrevForwardStep 
    ;

ReverseStep :
      ReverseAxis NodeTest | AbbrevReverseStep 
    ;

PredicateList :
      | PredicateList Predicate 
    ;

Predicate :
      TOK_LSQBRK Expr TOK_RSQBRK 
    ;

AbbrevForwardStep :
      TOK_AT NodeTest | NodeTest 
    ;

AbbrevReverseStep :
      TOK_2DOT 
    ;

ForwardAxis :
      child TOK_2COLON | descendant TOK_2COLON | attribute TOK_2COLON | self TOK_2COLON | descendant_or_self TOK_2COLON 
    ;

ReverseAxis :
      parent TOK_2COLON 
    ;

NodeTest :
      KindTest | NameTest 
    ;

NameTest :
      QName | Wildcard 
    ;

QName :
      NCName | TOK_QNAME 
    ;

NCName :
      NCName1 | attribute | comment | document_node | element | empty | node | processing_instruction | text 
    ;

Wildcard :
      TOK_STAR | TOK_NCNAME_COLON_STAR | TOK_STAR_COLON_NCNAME 
    ;

KindTest :
      DocumentTest | ElementTest | AttributeTest | PITest | CommentTest | TextTest | AnyKindTest 
    ;

ElementTest :
      element TOK_LPAREN ElementTestArg TOK_RPAREN 
    ;

ElementTestArg :
      | QName | TOK_STAR 
    ;

AttributeTest :
      attribute TOK_LPAREN AttrTestArg TOK_RPAREN 
    ;

AttrTestArg :
      | QName | TOK_STAR 
    ;

PITest :
      processing_instruction TOK_LPAREN PITestArg TOK_RPAREN 
    ;

PITestArg :
      | NCName | TOK_STRINGLITERAL 
    ;

DocumentTest :
      document_node TOK_LPAREN DocumentTestArg TOK_RPAREN 
    ;

DocumentTestArg :
      | ElementTest 
    ;

CommentTest :
      comment TOK_LPAREN TOK_RPAREN 
    ;

TextTest :
      text TOK_LPAREN TOK_RPAREN 
    ;

AnyKindTest :
      node TOK_LPAREN TOK_RPAREN 
    ;

Expr :
      ExprSingle | Expr TOK_COMMA ExprSingle 
    ;

ExprSingle :
      OrExpr | TOK_SLASH 
    ;

OrExpr :
      AndExpr | OrExpr or AndExpr 
    ;

AndExpr :
      ComparisonExpr | AndExpr and ComparisonExpr 
    ;

ComparisonExpr :
      RangeExpr | RangeExpr Comparison RangeExpr 
    ;

Comparison :
      ValueComp | GeneralComp | NodeComp 
    ;

RangeExpr :
      AdditiveExpr | AdditiveExpr to AdditiveExpr 
    ;

AdditiveExpr :
      MultiplicativeExpr | AdditiveExpr AdditiveOp MultiplicativeExpr 
    ;

AdditiveOp :
      TOK_PLUS | TOK_MINUS 
    ;

MultiplicativeExpr :
      UnionExpr | MultiplicativeExpr MultiOp UnionExpr 
    ;

MultiOp :
      TOK_STAR | TOK_DIV | idiv | mod 
    ;

UnionExpr :
      IntersectExceptExpr | UnionExpr UnionOp IntersectExceptExpr 
    ;

UnionOp :
      TOK_UNION | TOK_BAR 
    ;

IntersectExceptExpr :
      UnaryExpr 
    ;

UnaryExpr :
      ValueExpr | UnaryOp ValueExpr 
    ;

UnaryOp :
      TOK_PLUS | TOK_MINUS | UnaryOp TOK_PLUS | UnaryOp TOK_MINUS 
    ;

ValueExpr :
      PathExpr 
    ;

GeneralComp :
      TOK_EQ | TOK_NE | TOK_LT | TOK_LE | TOK_GT | TOK_GE 
    ;

ValueComp :
      eq | ne | lt | le | gt | ge 
    ;

NodeComp :
      is | TOK_2LT | TOK_2GT 
    ;

FilterExpr :
      PrimaryExpr PredicateList 
    ;

ContextItemExpr :
      TOK_DOT 
    ;

PrimaryExpr :
      Literal | TOK_VARNAME | ParenthesizedExpr | ContextItemExpr | FunctionCall 
    ;

Literal :
      NumericLiteral | TOK_STRINGLITERAL 
    ;

NumericLiteral :
      TOK_INTEGERLITERAL | TOK_DECIMALLITERAL | TOK_DOUBLELITERAL 
    ;

ParenthesizedExpr :
      TOK_LPAREN Expr_opt TOK_RPAREN 
    ;

Expr_opt :
      | Expr 
    ;

FunctionCall :
      QName1 TOK_LPAREN ExprListOpt TOK_RPAREN 
    ;

ExprListOpt :
      | ExprList 
    ;

ExprList :
      ExprSingle | ExprList TOK_COMMA ExprSingle 
    ;

QName1 :
      NCName1 | TOK_QNAME 
    ;

NCName1 :
      TOK_NCNAME | declare | namespace | TOK_DEFAULT | child | descendant | self | descendant_or_self | parent | or | and | to | TOK_DIV | idiv | mod | TOK_UNION | eq | ne | lt | le | gt | ge | is 
    ;

    ;
%%
void yyerror(const char* s) {
	fprintf(stderr,"error: %s\n",s);
}
