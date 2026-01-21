%option noyywrap

%{
#include "b.tab.h"
#include <iostream>
using namespace std;

int line_no = 1;
extern char* yytext;
%}


DIGIT   [0-9]
LETTER  [A-Za-z_]
ID      {LETTER}({LETTER}|{DIGIT})*
NUM     {DIGIT}+
STRING  \"([^\"\\\n]|\\.)*\"

%%

[ \t\r]+        { }
\n              { line_no++; }


"int"           { return INT; }
"jabtak"        { return JABTAK; }
"likho"         { return LIKHO; }


{ID}            { return ID; }


{NUM}           { return NUM; }
{STRING}        { return STRING; }


"="             { return ASSIGN; }
"+"             { return PLUS; }
";"             { return SEMICOLON; }
"("             { return LPAREN; }
")"             { return RPAREN; }
"{"             { return LBRACE; }
"}"             { return RBRACE; }


.               { return yytext[0]; }

%%
