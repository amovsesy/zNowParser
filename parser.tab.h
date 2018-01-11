/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison GLR parsers in C

   Copyright (C) 2002, 2003, 2004, 2005, 2006 Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     TOK_2COLON = 258,
     TOK_2DOT = 259,
     TOK_2GT = 260,
     TOK_2LT = 261,
     TOK_2SLASH = 262,
     TOK_AT = 263,
     TOK_BAR = 264,
     TOK_COMMA = 265,
     TOK_DECIMALLITERAL = 266,
     TOK_DOT = 267,
     TOK_DOUBLELITERAL = 268,
     TOK_EQ = 269,
     TOK_GE = 270,
     TOK_GT = 271,
     TOK_INTEGERLITERAL = 272,
     TOK_LE = 273,
     TOK_LPAREN = 274,
     TOK_LSQBRK = 275,
     TOK_LT = 276,
     TOK_MINUS = 277,
     TOK_NCNAME = 278,
     TOK_NCNAME_COLON_STAR = 279,
     TOK_NE = 280,
     TOK_PLUS = 281,
     TOK_QNAME = 282,
     TOK_RPAREN = 283,
     TOK_RSQBRK = 284,
     TOK_SEMICO = 285,
     TOK_SLASH = 286,
     TOK_STAR = 287,
     TOK_STAR_COLON_NCNAME = 288,
     TOK_STRINGLITERAL = 289,
     TOK_VARNAME = 290,
     and = 291,
     attribute = 292,
     child = 293,
     comment = 294,
     declare = 295,
     TOK_DEFAULT = 296,
     descendant = 297,
     descendant_or_self = 298,
     TOK_DIV = 299,
     document_node = 300,
     element = 301,
     empty = 302,
     eq = 303,
     ge = 304,
     gt = 305,
     idiv = 306,
     is = 307,
     le = 308,
     lt = 309,
     mod = 310,
     namespace = 311,
     ne = 312,
     node = 313,
     or = 314,
     parent = 315,
     processing_instruction = 316,
     self = 317,
     text = 318,
     to = 319,
     TOK_UNION = 320
   };
#endif


/* Copy the first part of user declarations.  */
#line 1 "parser.y"

#include <stdio.h>
#define YYSTYPE char*
#define YYDEBUG 1
int yylex(void);
void yyerror(const char* s);


#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

#if ! defined YYLTYPE && ! defined YYLTYPE_IS_DECLARED
typedef struct YYLTYPE
{

  char yydummy;

} YYLTYPE;
# define YYLTYPE_IS_DECLARED 1
# define YYLTYPE_IS_TRIVIAL 1
#endif


extern YYSTYPE yylval;



