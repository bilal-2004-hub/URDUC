%{
#include <iostream>
using namespace std;

int yylex();
void yyerror(const char *s);
extern int yylineno;
%}

/* Tokens */
%token INT JABKE JABTAK LIKHO
%token ID NUM STRING
%token ASSIGN PLUS SEMICOLON
%token LPAREN RPAREN LBRACE RBRACE

%%

program
    : statements
    ;

statements
    : statements statement
    | statement
    ;

statement
    : declaration
    | assignment
    | print_stmt
    | loop_stmt
    ;

declaration
    : INT ID SEMICOLON
    ;

assignment
    : ID ASSIGN expression SEMICOLON
    ;

print_stmt
    : LIKHO LPAREN STRING RPAREN SEMICOLON
    ;

loop_stmt
    : JABTAK LPAREN expression RPAREN LBRACE statements RBRACE
    ;

expression
    : expression PLUS term
    | term
    ;

term
    : ID
    | NUM
    ;

%%

void yyerror(const char *s)
{
    
    cout << "Syntax Error at line " << yylineno << ": " << s << endl;
}

int main()
{
    cout << "===== SYNTAX ANALYSIS STARTED =====" << endl;

    if (yyparse() == 0)
        cout << "Program is syntactically correct ✅" << endl;

    cout << "===== SYNTAX ANALYSIS COMPLETED =====" << endl;
    return 0;
}

