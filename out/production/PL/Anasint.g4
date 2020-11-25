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

entrada: seq PARENTESISABIERTO tipo PARENTESISCERRADO IDENT (COMA entrada)?
         |tipo IDENT (COMA entrada)?;

salida: seq PARENTESISABIERTO tipo PARENTESISCERRADO IDENT (COMA salida)?
        |NUM IDENT (COMA salida)?;


//predicado

decl_predicado: FUNCION predicado variables instrucciones dev FFUNCION;

predicado: IDENT PARENTESISABIERTO entrada? PARENTESISCERRADO DEV PARENTESISABIERTO salidaP PARENTESISCERRADO;

salidaP: LOG IDENT;

//prodecimiento

decl_procedimiento: PROCEDIMIENTO procedimiento variables instrucciones FPROCEDIMIENTO;

procedimiento:  IDENT PARENTESISABIERTO entrada? PARENTESISCERRADO;



//instrucciones

instrucciones: INSTRUCCIONES (control | asignacion | llamadas | ruptura)*;

control:  (mientras | si);

ruptura: RUPTURA PyC;

mientras: MIENTRAS PARENTESISABIERTO (condicion|condicionVoF)* PARENTESISCERRADO HACER (control | asignacion | llamadas | ruptura)+ FMIENTRAS;

si: SI PARENTESISABIERTO (condicion|condicionVoF)* PARENTESISCERRADO ENTONCES (control | asignacion | llamadas | devL)+ (SINO (control | asignacion | llamadas | devL)+)? FSI;

condicionVoF: (CIERTO | FALSO);

condicion:
           NEGACION PARENTESISABIERTO(expr_num (igualdades | desilgualdades) expr_num)|(expr_log ((igualdades | desilgualdades) expr_log)PARENTESISCERRADO((CON | DIS | igualdades | desilgualdades)condicion)?
           |(expr_num (igualdades | desilgualdades) expr_num)|(expr_log ((igualdades | desilgualdades) expr_log)?))((CON | DIS| igualdades | desilgualdades)condicion)?
           |(NEGACION? PARENTESISABIERTO condicion PARENTESISCERRADO)((CON | DIS| igualdades | desilgualdades)condicion)?;

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

expr_num:INT (COMA expr_num)?                               #Int
        |expr_num (SUMA | RESTA | MULTIPLICACION) expr_num  #Op
        |IDENT                                              #Id
        |IDENT CORCHETEABIERTO expr_num CORCHETECERRADO     #OpSeq
        |llamadaF                                           #Fun
        |ultimaposicion                                     #Ult
        |PARENTESISABIERTO expr_num PARENTESISCERRADO       #Par
        ;


//expr_num1:INT (COMA expr_num)?
//  |expr_num1 MULTIPLICACION expr_num
//  |IDENT
//  |PARENTESISABIERTO expr_num PARENTESISCERRADO
//   ;
//log

expr_log: NEGACION? (T | F | vacia | IDENT CORCHETEABIERTO expr_num CORCHETECERRADO | llamadaP| IDENT );

dev: DEV idents PyC;

devL: DEV expr_log PyC;

//llamadas

llamadas: (llamadaP | llamadaF | vacia | ultimaposicion | mostrar);

vacia: VACIA PARENTESISABIERTO IDENT PARENTESISCERRADO;

mostrar: MOSTRAR PARENTESISABIERTO idents PARENTESISCERRADO PyC;

ultimaposicion: ULTIMAPOSICION PARENTESISABIERTO IDENT PARENTESISCERRADO;

llamadaP: IDENT PARENTESISABIERTO idents PARENTESISCERRADO PyC;

llamadaF: IDENT PARENTESISABIERTO idents PARENTESISCERRADO;
