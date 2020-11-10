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

subprogramas: SUBPROGRAMAS (decl_funcion  | decl_procedimiento | decl_predicado)*;

//funcion

decl_funcion: FUNCION funcion variables instrucciones dev FFUNCION;

funcion:  IDENT PARENTESISABIERTO entrada PARENTESISCERRADO DEV PARENTESISABIERTO salida PARENTESISCERRADO;

entrada: ((SEQ PARENTESISABIERTO tipo PARENTESISCERRADO IDENT | tipo IDENT))*;
salida: (SEQ PARENTESISABIERTO tipo PARENTESISCERRADO IDENT COMA)
        |NUM IDENT (COMA NUM IDENT)?;

//predicado

decl_predicado: FUNCION predicado variables instrucciones FFUNCION;

predicado: IDENT PARENTESISABIERTO entrada PARENTESISCERRADO DEV PARENTESISABIERTO salidaP PARENTESISCERRADO;

salidaP: LOG IDENT;

//prodecimiento

decl_procedimiento: PROCEDIMIENTO procedimiento variables instrucciones FPROCEDIMIENTO;

procedimiento: IDENT PARENTESISABIERTO( SEQ PARENTESISABIERTO tipo PARENTESISCERRADO IDENT
                                      (COMA SEQ PARENTESISABIERTO tipo PARENTESISCERRADO IDENT)?
                              |  tipo IDENT (COMA tipo IDENT)? )? PARENTESISCERRADO;



//instrucciones

instrucciones: INSTRUCCIONES (control | asignacion | siL)*;

control: ( mientras | si);

mientras: MIENTRAS PARENTESISABIERTO expr_sec (igualdades | desilgualdades) expr_sec PARENTESISCERRADO HACER (control | asignacion)+ FMIENTRAS;

si: SI PARENTESISABIERTO expr_sec+ (igualdades | desilgualdades) expr_sec+ PARENTESISCERRADO ENTONCES (control | asignacion)+ (SINO (control | asignacion)+)? FSI;

siL: SI PARENTESISABIERTO expr_sec (igualdades | desilgualdades) expr_sec PARENTESISCERRADO ENTONCES (devL)+ SINO? (devL)+ FSI;

expr_sec: NEGACION? (CON | DIS)? expr
          |NEGACION? PARENTESISABIERTO NEGACION? expr (CON | DIS) NEGACION? expr PARENTESISCERRADO
          |NEGACION? expr (CON | DIS) NEGACION? expr
          |(CON | DIS)? PARENTESISABIERTO NEGACION? expr (CON | DIS) NEGACION? expr PARENTESISCERRADO;
igualdades: IGUAL;

desilgualdades: (MAYOR | MENOR | MENORIGUAL | MAYORIGUAL | DISTINTO);

asignacion: idents ASIG expresiones PyC;

idents: IDENT (COMA idents)?;

expresiones: expr (COMA expresiones)?;

expr: expr_seq
    |expr_log
    |expr_num
    |ultimaP
    ;
//seq

expr_seq: seq_num
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

dev: DEV idents PyC;

devL: DEV expr_log PyC;

//llamada a subprogramas

ultimaP: ULTIMAPOSICION PARENTESISABIERTO IDENT PARENTESISCERRADO;
