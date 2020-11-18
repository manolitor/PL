parser grammar Anasint;
options{
   tokenVocab=Analex;
}


programa: PROGRAMA variables subprogramas instrucciones;

//variables

variables: VARIABLES (decl_vars | decl_seq)*;

decl_vars: vars DOSPUNTOS tipo PyC;
            //|vars DOSPUNTOS tipo2 PARENTESISABIERTO tipo PARENTESISCERRADO PyC;

decl_seq: vars DOSPUNTOS seq PARENTESISABIERTO tipo PARENTESISCERRADO PyC;

tipo:  NUM | LOG;

seq: SEQ;

vars: IDENT (COMA vars)?;

//seqs: IDENT (COMA seqs)?;

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

instrucciones: INSTRUCCIONES (control | asignacion | llamadas | ruptura)*;

control: ( mientras | si );

ruptura: RUPTURA PyC;

mientras: MIENTRAS PARENTESISABIERTO expr_sec (igualdades | desilgualdades) expr_sec PARENTESISCERRADO HACER (control | asignacion | llamadas | ruptura)+ FMIENTRAS;

si: SI PARENTESISABIERTO expr_sec+ (igualdades | desilgualdades) expr_sec+ PARENTESISCERRADO ENTONCES (control | asignacion | llamadas | devL)+ (SINO (control | asignacion | llamadas | devL)+)? FSI;


expr_sec: NEGACION? expr
          |(CON | DIS)? expr
          |NEGACION? PARENTESISABIERTO NEGACION? expr (CON | DIS) NEGACION? expr PARENTESISCERRADO
          |NEGACION? expr (CON | DIS) NEGACION? expr
          |(CON | DIS)? PARENTESISABIERTO NEGACION? expr (CON | DIS) NEGACION? expr PARENTESISCERRADO
          | (CIERTO | FALSO);

igualdades: IGUAL;

desilgualdades: (MAYOR | MENOR | MENORIGUAL | MAYORIGUAL | DISTINTO);

asignacion: idents ASIG expresiones PyC
            //|asignacionL
            ;

//asignacionL: idents ASIG expresionesL PyC;

idents: IDENT (COMA idents)?;

expresiones: expr (COMA expresiones)?;

//expresionesL: expr_log (COMA expresionesL)?;

expr:expr_seq
    |expr_num
    |expr_log
    |llamadaF
    ;
//seq

expr_seq: CORCHETEABIERTO CORCHETECERRADO #SeqVacia
         |seq_num #SeqNum
         |seq_log #SeqLog
        ;

seq_num: CORCHETEABIERTO expr_num (COMA expr_num)* CORCHETECERRADO
         ;

seq_log: CORCHETEABIERTO expr_log (COMA expr_log)* CORCHETECERRADO
   ;
//num

expr_num:INT (COMA expr_num)?
  |expr_num (SUMA | RESTA | MULTIPLICACION) expr_num
  |IDENT
  |PARENTESISABIERTO expr_num PARENTESISCERRADO
  |IDENT CORCHETEABIERTO CORCHETECERRADO
  |IDENT CORCHETEABIERTO expr_num (COMA expr_num)* CORCHETECERRADO
  |llamadaF
  |ultimaposicion
  ;
//expr_num1:INT (COMA expr_num)?
//  |expr_num1 MULTIPLICACION expr_num
//  |IDENT
//  |PARENTESISABIERTO expr_num PARENTESISCERRADO
//   ;
//log

expr_log: T | F | vacia;

dev: DEV idents PyC;

devL: DEV expr_log PyC;

//llamadas

llamadas: (llamadaP | llamadaF | vacia | ultimaposicion | mostrar);

vacia: VACIA PARENTESISABIERTO IDENT PARENTESISCERRADO;

mostrar: MOSTRAR PARENTESISABIERTO idents PARENTESISCERRADO PyC;

ultimaposicion: ULTIMAPOSICION PARENTESISABIERTO IDENT PARENTESISCERRADO;

llamadaP: idents PARENTESISABIERTO idents PARENTESISCERRADO PyC;

llamadaF: idents PARENTESISABIERTO idents PARENTESISCERRADO;
