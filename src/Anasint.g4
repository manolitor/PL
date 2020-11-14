parser grammar Anasint;
options{
   tokenVocab=Analex;
}


programa: PROGRAMA variables subprogramas instrucciones;

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

funcion:  IDENT PARENTESISABIERTO entrada? PARENTESISCERRADO DEV PARENTESISABIERTO salida PARENTESISCERRADO;

entrada: SEQ PARENTESISABIERTO tipo PARENTESISCERRADO IDENT (COMA entrada)?
                 |NUM IDENT (COMA entrada)?;

salida: SEQ PARENTESISABIERTO tipo PARENTESISCERRADO IDENT (COMA salida)?
        |NUM IDENT (COMA salida)?;


//predicado

decl_predicado: FUNCION predicado variables instrucciones FFUNCION;

predicado: IDENT PARENTESISABIERTO entrada? PARENTESISCERRADO DEV PARENTESISABIERTO salidaP PARENTESISCERRADO;

salidaP: LOG IDENT;

//prodecimiento

decl_procedimiento: PROCEDIMIENTO procedimiento variables instrucciones FPROCEDIMIENTO;

procedimiento:  IDENT PARENTESISABIERTO entrada? PARENTESISCERRADO;



//instrucciones

instrucciones: INSTRUCCIONES (control | asignacion | llamadas)*;

control: ( mientras | si  | siL);

mientras: MIENTRAS PARENTESISABIERTO expr_sec (igualdades | desilgualdades) expr_sec PARENTESISCERRADO HACER (control | asignacion | llamadas)+ FMIENTRAS;

si: SI PARENTESISABIERTO expr_sec+ (igualdades | desilgualdades) expr_sec+ PARENTESISCERRADO ENTONCES (control | asignacion | llamadas)+ (SINO (control | asignacion | llamadas)+)? FSI;

siL: SI PARENTESISABIERTO expr_sec (igualdades | desilgualdades) expr_sec PARENTESISCERRADO ENTONCES (devL)+ SINO? (devL)+ FSI;

expr_sec: NEGACION? expr
          |(CON | DIS)? expr
          |NEGACION? PARENTESISABIERTO NEGACION? expr (CON | DIS) NEGACION? expr PARENTESISCERRADO
          |NEGACION? expr (CON | DIS) NEGACION? expr
          |(CON | DIS)? PARENTESISABIERTO NEGACION? expr (CON | DIS) NEGACION? expr PARENTESISCERRADO
          ;

igualdades: IGUAL;

desilgualdades: (MAYOR | MENOR | MENORIGUAL | MAYORIGUAL | DISTINTO);

asignacion: idents ASIG expresiones PyC
            |asignacionL;

asignacionL: idents ASIG expresionesL PyC;

idents: IDENT (COMA idents)?;

expresiones: expr (COMA expresiones)?;

expresionesL: expr_log (COMA expresionesL)?;

expr:expr_seq
    |expr_num
    |llamadaF
    ;
//seq

expr_seq: seq_num
         |seq_log
        ;

seq_num: CORCHETEABIERTO CORCHETECERRADO
         |CORCHETEABIERTO expr_num (COMA expr_num)* CORCHETECERRADO
         |IDENT CORCHETEABIERTO CORCHETECERRADO
         |IDENT CORCHETEABIERTO expr_num (COMA expr_num)* CORCHETECERRADO
         ;

seq_log: CORCHETEABIERTO CORCHETECERRADO
        | CORCHETEABIERTO expr_log (COMA expr_log)* CORCHETECERRADO
   ;
//num

expr_num:INT (COMA expr_num)?
  |expr_num (SUMA | RESTA | MULTIPLICACION) expr_num
  |IDENT
  |PARENTESISABIERTO expr_num PARENTESISCERRADO
  |llamadaF
  |seq_num
  |ultimaposicion
  ;
//expr_num1:INT (COMA expr_num)?
//  |expr_num1 MULTIPLICACION expr_num
//  |IDENT
//  |PARENTESISABIERTO expr_num PARENTESISCERRADO
//   ;
//log

expr_log: T | F;

dev: DEV idents PyC;

devL: DEV expr_log PyC;

//llamada

llamadas: (llamadaP | llamadaF | llamadasP);

llamadasP: (ultimaposicion);

ultimaposicion: ULTIMAPOSICION PARENTESISABIERTO idents PARENTESISCERRADO;

llamadaP: idents PARENTESISABIERTO idents PARENTESISCERRADO PyC;

llamadaF: idents PARENTESISABIERTO idents PARENTESISCERRADO PyC?;



//falta:
//condicion cierto/falso
//predicado vacia (secuencias)
//rupturas
//llamdas a funcion
//mostrar