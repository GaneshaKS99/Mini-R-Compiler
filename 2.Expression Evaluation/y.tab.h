/* A Bison parser, made by GNU Bison 3.3.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2019 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

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

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif
/* "%code requires" blocks.  */
#line 45 "r.y" /* yacc.c:1921  */
#include "ast.h"

#line 51 "y.tab.h" /* yacc.c:1921  */

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    IMPORT = 258,
    LIBRARY = 259,
    MATH = 260,
    PRINT = 261,
    PASTE = 262,
    BRE = 263,
    ELSE = 264,
    IF = 265,
    IFELSE = 266,
    QUO = 267,
    W = 268,
    COMMA = 269,
    A1 = 270,
    A2 = 271,
    A3 = 272,
    A4 = 273,
    A5 = 274,
    OB = 275,
    CB = 276,
    OCB = 277,
    CCB = 278,
    OSB = 279,
    CSB = 280,
    CLN = 281,
    PLUS = 282,
    MINUS = 283,
    DIV = 284,
    MUL = 285,
    POW = 286,
    LE = 287,
    GE = 288,
    COM = 289,
    NE = 290,
    LT = 291,
    GT = 292,
    AND = 293,
    OR = 294,
    NOT = 295,
    PERC = 296,
    BOOL = 297,
    INC = 298,
    DEC = 299,
    LIST = 300,
    SEQ = 301,
    BY = 302,
    LEN = 303,
    OUT = 304,
    C = 305,
    NUM = 306,
    STR = 307,
    ID = 308
  };
#endif
/* Tokens.  */
#define IMPORT 258
#define LIBRARY 259
#define MATH 260
#define PRINT 261
#define PASTE 262
#define BRE 263
#define ELSE 264
#define IF 265
#define IFELSE 266
#define QUO 267
#define W 268
#define COMMA 269
#define A1 270
#define A2 271
#define A3 272
#define A4 273
#define A5 274
#define OB 275
#define CB 276
#define OCB 277
#define CCB 278
#define OSB 279
#define CSB 280
#define CLN 281
#define PLUS 282
#define MINUS 283
#define DIV 284
#define MUL 285
#define POW 286
#define LE 287
#define GE 288
#define COM 289
#define NE 290
#define LT 291
#define GT 292
#define AND 293
#define OR 294
#define NOT 295
#define PERC 296
#define BOOL 297
#define INC 298
#define DEC 299
#define LIST 300
#define SEQ 301
#define BY 302
#define LEN 303
#define OUT 304
#define C 305
#define NUM 306
#define STR 307
#define ID 308

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 47 "r.y" /* yacc.c:1921  */

    struct BTree tree;
    int bool;

#line 174 "y.tab.h" /* yacc.c:1921  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
