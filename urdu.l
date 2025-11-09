%option noyywrap
%{
#include <iostream>
#include <string>
using namespace std;

int line_no = 1;       
int token_count = 0;   
%}

DIGIT       [0-9]
LETTER      [A-Za-z_]
ID          {LETTER}({LETTER}|{DIGIT})*
INTLIT      {DIGIT}+ 
FLOATLIT    ({DIGIT}"."{DIGIT}*|{DIGIT}*"."{DIGIT}+)
STRINGLIT   \"([^\"\\\n]|\\.)*\"
CHARLIT     \'(\\.|[^\\'\n])\'


KEYWORD     (jabtak|agar|warna|harbar|laotao|khaal|ha|nahe|baaz|hatta|mitao|daira|likho|ujliye|aur|nikalo|dalo)


OP          (\+|\-|\*\*|~|\/|%|==|=|!=|>=|<=|>|<|&&|\|\||\+\+|--|;|,|\(|\)|\{|\}|\[|\])


%x COMMENT

%%


[ \t\r]+                { /**/ }


\n                      { line_no++; }


"//".*                  { 
                            token_count++;
                            cout << "Line " << line_no 
                                 << "\tTOKEN #" << token_count 
                                 << "\tCOMMENT (single-line)\t: " << yytext << endl;
                        }


"/*"                    { BEGIN(COMMENT); }
<COMMENT>{
    "*/"                { 
                            BEGIN(INITIAL); 
                            token_count++;
                            cout << "Line " << line_no 
                                 << "\tTOKEN #" << token_count 
                                 << "\tCOMMENT (multi-line)\t: " << yytext << endl;
                        }
    "\n"                { line_no++; }
    .                   { /**/ }
}


{KEYWORD}([^A-Za-z0-9_]|$) {
    token_count++;
    cout << "Line " << line_no 
         << "\tTOKEN #" << token_count 
         << "\tKEYWORD\t: " << yytext << endl;
}


"int"|"float"|"char"|"string"|"bool"|"khaal" {
    token_count++;
    cout << "Line " << line_no 
         << "\tTOKEN #" << token_count 
         << "\tDATATYPE\t: " << yytext << endl;
}


{ID} {
    token_count++;
    cout << "Line " << line_no 
         << "\tTOKEN #" << token_count 
         << "\tIDENTIFIER\t: " << yytext << endl;
}


{FLOATLIT} {
    token_count++;
    cout << "Line " << line_no 
         << "\tTOKEN #" << token_count 
         << "\tFLOAT_LITERAL\t: " << yytext << endl;
}

{INTLIT} {
    token_count++;
    cout << "Line " << line_no 
         << "\tTOKEN #" << token_count 
         << "\tINTEGER_LITERAL\t: " << yytext << endl;
}

{STRINGLIT} {
    token_count++;
    cout << "Line " << line_no 
         << "\tTOKEN #" << token_count 
         << "\tSTRING_LITERAL\t: " << yytext << endl;
}

{CHARLIT} {
    token_count++;
    cout << "Line " << line_no 
         << "\tTOKEN #" << token_count 
         << "\tCHAR_LITERAL\t: " << yytext << endl;
}


{OP} {
    token_count++;
    cout << "Line " << line_no 
         << "\tTOKEN #" << token_count 
         << "\tOPERATOR/SYMBOL\t: " << yytext << endl;
}


.   { /* */ }

%%

int main() {
    yylex();  

   
    cout << "\n----------------------------------" << endl;
    cout << "Total Lines  : " << line_no << endl;
    cout << "Total Tokens : " << token_count << endl;
    cout << "----------------------------------" << endl;

    return 0;
}
