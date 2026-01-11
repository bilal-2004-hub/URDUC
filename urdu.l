%option noyywrap
%option yylineno

%{
#include "b.tab.h"
#include <iostream>
using namespace std;
%}


DIGIT   [0-9]
LETTER  [A-Za-z_]
ID      {LETTER}({LETTER}|{DIGIT})*
NUM     {DIGIT}+
STRING  \"([^\"\\\n]|\\.)*\"

%%

[ \t]+          ;        
\n              ;       
"int"           { return INT; }
"jabke"         { return JABKE; }
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

 .  {
    cout << "Syntax Error at line "
         << ": syntax error '" << yytext[0] << "'" << endl;
}
%%



int main()
{
    cout << "===== LEXICAL ANALYSIS STARTED =====" << endl;

    while (yylex() != 0) {
     
    }

    cout << "===== LEXICAL ANALYSIS COMPLETED =====" << endl;
    cout << "Total lines scanned: " << yylineno << endl;
    return 0;
}

