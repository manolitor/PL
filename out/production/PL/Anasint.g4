parser grammar Anasint;
options{
    tokenVocab=Analex;
}


programa: variables subprogramas instrucciones;

//variables

variables: VARIABLES (decl_vars | decl_seq)*;

decl_vars: vars DOSPUNTOS tipo PyC;

decl_seq: seqs DOSPUNTOS SEQ PARENTESISABIERTO tipo PARENTESISCERRADO PyC;

tipo:  NUM | LOG;

vars: IDENT (COMA vars)?;

seqs: IDENT (COMA seqs)?;

//subprogramas

subprogramas: SUBPROGRAMAS (decl_funcion | decl_predicado | decl_procedimiento)*;

decl_funcion: funcion PyC;

funcion: IDENT;

decl_predicado: predicado PyC;

predicado: IDENT;

decl_procedimiento: procedimiento PyC;

procedimiento: IDENT;

//instrucciones

instrucciones: INSTRUCCIONES (asignacion)*;

asignacion: idents ASIG expresiones PyC;

idents: IDENT (COMA idents)?;

expresiones: expr (COMA expresiones)?;

expr: expr_seq
     |expr_log
     |expr_num
     ;
//seq

expr_seq:| seq_num
	     | seq_log
         ;

seq_num: CORCHETEABIERTO CORCHETECERRADO
 	|CORCHETEABIERTO expr_num (COMA expr_num)* CORCHETECERRADO
    ;

seq_log: CORCHETEABIERTO CORCHETECERRADO
	|CORCHETEABIERTO expr_log (COMA expr_log)* CORCHETECERRADO
    ;
//num

expr_num:INT (COMA expr_num)?
	|expr_num (SUMA | RESTA) expr_num1
	|IDENT
	|expr_num1
    ;
expr_num1:INT (COMA expr_num)?
	|expr_num1 MULTIPLICACION expr_num
	|IDENT
    ;
//log

expr_log: T | F;