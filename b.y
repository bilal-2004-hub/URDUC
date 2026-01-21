%{
#include <iostream>
using namespace std;

extern int yylex();
extern int line_no;
void yyerror(const char *s);
%}

%define parse.error verbose
%start program

/* Tokens */
%token INT JABTAK LIKHO
%token ID NUM STRING
%token ASSIGN PLUS SEMICOLON
%token LPAREN RPAREN LBRACE RBRACE

%%



program
    : statement_list
    ;

statement_list
    : statement_list statement
    | statement
    ;

statement
    : declaration
    | assignment
    | print_stmt
    | loop_stmt
    | error SEMICOLON   { yyerror("Invalid statement"); yyerrok; }
    ;


declaration
    : INT ID SEMICOLON 
    | INT  ID  ASSIGN  NUM  SEMICOLON 
    | INT ID error     { yyerror("Missing semicolon at end of declaration"); yyerrok; }
    | INT  ID  ASSIGN  NUM  error  { yyerror("Missing semicolon at end of declaration"); yyerrok; }
    ;


assignment
    : ID ASSIGN expression SEMICOLON
    | ID ASSIGN error SEMICOLON { yyerror("Invalid assignment"); yyerrok; }
    ;


print_stmt
    : LIKHO LPAREN STRING RPAREN SEMICOLON
    | LIKHO error SEMICOLON { yyerror("Invalid print statement"); yyerrok; }
    ;


loop_stmt
    : JABTAK LPAREN condition RPAREN LBRACE statement_list RBRACE
    | JABTAK error LBRACE statement_list RBRACE
        { yyerror("Invalid loop syntax"); yyerrok; }
    ;


condition
    : expression
    ;


expression
    : term
    | expression PLUS term
    ;

term
    : ID
    | NUM
    ;

%%


void yyerror(const char *s)
{
    cout << "Syntax Error at line " << line_no
         << ": " << s << endl;
}


int main()
{
    cout << "\n===== URDU PARSER STARTED =====\n";
    yyparse();
    cout << "===== PARSER FINISHED =====\n";
    return 0;
}
