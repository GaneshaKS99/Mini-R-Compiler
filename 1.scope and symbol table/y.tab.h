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
    NUM = 270,
    STR = 271,
    ID = 272,
    A1 = 273,
    A2 = 274,
    A3 = 275,
    A4 = 276,
    A5 = 277,
    OB = 278,
    CB = 279,
    OCB = 280,
    CCB = 281,
    OSB = 282,
    CSB = 283,
    CLN = 284,
    PLUS = 285,
    MINUS = 286,
    DIV = 287,
    MUL = 288,
    POW = 289,
    LE = 290,
    GE = 291,
    COM = 292,
    NE = 293,
    LT = 294,
    GT = 295,
    AND = 296,
    OR = 297,
    NOT = 298,
    PERC = 299,
    BOOL = 300,
    INC = 301,
    DEC = 302,
    LIST = 303,
    SEQ = 304,
    BY = 305,
    LEN = 306,
    OUT = 307,
    C = 308
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
#define NUM 270
#define STR 271
#define ID 272
#define A1 273
#define A2 274
#define A3 275
#define A4 276
#define A5 277
#define OB 278
#define CB 279
#define OCB 280
#define CCB 281
#define OSB 282
#define CSB 283
#define CLN 284
#define PLUS 285
#define MINUS 286
#define DIV 287
#define MUL 288
#define POW 289
#define LE 290
#define GE 291
#define COM 292
#define NE 293
#define LT 294
#define GT 295
#define AND 296
#define OR 297
#define NOT 298
#define PERC 299
#define BOOL 300
#define INC 301
#define DEC 302
#define LIST 303
#define SEQ 304
#define BY 305
#define LEN 306
#define OUT 307
#define C 308

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
