
%{
#include <stdio.h>
#include <stdlib.h>
							
%}

%start PROGRAM
%token FUNCTION
%token VARS
%token INT
%token FLOAT
%token CHAR
%token IF 
%token ELSEIF
%token ELSE
%token ENDIF
%token SWITCH
%token CASE
%token ENDSWITCH
%token FOR
%token WHILE
%token PRINT
%token BREAK
%token %


%%

PROGRAM: PROGRAM id 
	|STARTMAIN_ENDMAIN 
	|FUNCTIONS PROGRAM
        ;

FUNCTIONS: FUNCTIO
        |FUNCTION FUNCTIONS
        ;

FUNCTION: FUNCTION id ( VARS VARS) RETURN END_FUNCTION
        |FUNCTION id ( VARS VARS) BODY RETURN END_FUNCTION
        ;

STARTMAIN_ENDMAIN: STARTMAIN id ( VARS VARS) BODY ENDMAIN
        ;

VARS: CHAR variables
      | INTEGER variables
      ;

variables: variable
        | <variable> , <variable>
        ;

variable:   id
        | id [ int ]
        ;

BODY:   stmt 
        |stmt BODY
        ; 

stmt: assignment
        |loop_stmt
        |check_stmt
        |print
        |break
        |comments
        ;

loop_stmt: while_loop
        |for_loop
        ;

check_stmt: if_stmt
        |switch_stmt
        ;

assignment: variable = right_hand_side 
        ;

right_hand_side: variable
                | int
                | char
                | <ar_expression>
                | id ( VARS )      
                | variable operator variable
                ;

while_loop: WHILE ( boolean_stmt ) BODY ENDWHILE
        ;

for_loop: FOR assignment TO int STEP int BODY ENDFOR
        ;

if_stmt: IF ( boolean_stmt ) THEN BODY ENDIF
        |IF ( boolean_stmt ) THEN BODY ELSE BODY ENDIF
        |IF ( boolean_stmt ) THEN BODY elseif ELSE BODY ENDIF
        ;

elseif: ELSEIF ( <boolean_stmt> ) BODY
        |ELSEIF ( <boolean_stmt> ) BODY elseif
        ;

switch_stmt: SWITCH ( variable ) case ENDSWITCH
        |SWITCH ( <variable> ) case DEFAULT ( <variable> ) ENDSWITCH
        ;

case: CASE ( variable ) BODY
        | CASE ( <variable ) BODY case
        ;

print: PRINT ( string , <variable> ) ;
        ;

break: BREAK 
        ;

comments: %string
        ;

boolean_stmt:  variable unary-operator variable
        |variable unary-operator variable boolean_stmt
        ;

ar_expression: int
	|ar_expression operator ar_expression
        |( ar_expression operator ar_expression )
        ;

operator: *
        | /
        | %
        | +
        | -
        | ^
        ;


unary-operator: AND
                | OR
                | !=
                | ==
                | <
                | >
                ;

%%