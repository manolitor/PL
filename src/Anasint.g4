parser grammar Anasint;
options{
   tokenVocab=Analex;
}


programa: PROGRAMA (variables)* (subprogramas)* (instrucciones)*;

//variables

variables: VARIABLES (decl_vars | decl_seq)*;

decl_vars: vars DOSPUNTOS tipo PyC;

decl_seq: seqs DOSPUNTOS SEQ PARENTESISABIERTO tipo PARENTESISCERRADO PyC;

tipo:  NUM | LOG;

vars: IDENT (COMA vars)?;

seqs: IDENT (COMA seqs)?;

//subprogramas

subprogramas: SUBPROGRAMAS (decl_funcion  | decl_procedimiento)*;

decl_funcion: FUNCION funcion variables instrucciones dev FFUNCION;

dev: DEV idents PyC;

funcion:  IDENT PARENTESISABIERTO entrada PARENTESISCERRADO DEV PARENTESISABIERTO salida PARENTESISCERRADO;

entrada: ((SEQ PARENTESISABIERTO tipo PARENTESISCERRADO IDENT | tipo IDENT))*;
salida: (SEQ PARENTESISABIERTO tipo PARENTESISCERRADO IDENT COMA)
        |tipo IDENT (COMA tipo IDENT)?;

decl_procedimiento: PROCEDIMIENTO procedimiento variables instrucciones FPROCEDIMIENTO;

procedimiento: IDENT PARENTESISABIERTO( SEQ PARENTESISABIERTO tipo PARENTESISCERRADO IDENT
                                      (COMA SEQ PARENTESISABIERTO tipo PARENTESISCERRADO IDENT)?
                              |  tipo IDENT (COMA tipo IDENT)? )? PARENTESISCERRADO;



//instrucciones

instrucciones: INSTRUCCIONES (control | asignacion)*;

control: (mientras | si) ;

mientras: MIENTRAS PARENTESISABIERTO expr (MAYOR | MENOR | MENORIGUAL | MAYORIGUAL) expr PARENTESISCERRADO HACER (control | asignacion)* FMIENTRAS;

si: SI PARENTESISABIERTO expr (MAYOR | MENOR | MENORIGUAL | MAYORIGUAL) expr PARENTESISCERRADO ENTONCES (control | asignacion)* FSI;

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

seq_num: IDENT CORCHETEABIERTO CORCHETECERRADO
  |IDENT CORCHETEABIERTO expr_num (COMA expr_num)* CORCHETECERRADO
   ;

seq_log: IDENT CORCHETEABIERTO CORCHETECERRADO
  |IDENT CORCHETEABIERTO expr_log (COMA expr_log)* CORCHETECERRADO
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
