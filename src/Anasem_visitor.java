import javax.json.JsonValue;
import java.util.HashMap;
import java.util.Map;

public class Anasem_visitor extends AnasintBaseVisitor<Integer>{

    public Map<String, Integer>memoria = new HashMap<>();

    public Map<String, Integer>memoria2 = new HashMap<>();

    @Override
    public Integer visitDecl_vars(Anasint.Decl_varsContext ctx) {

        String id = ctx.vars().getText();
        Integer value = visit(ctx.tipo());
        if(memoria2.containsKey(id)){

            System.out.println("La variable '" +id+ "' ya ha sido declarada (línea "+ ctx.start.getLine() +", " +ctx.start.getCharPositionInLine()+ ")");

        }
        memoria2.put(id, value);
        System.out.println("Mapa declaraciones(VARS): " +memoria2);
        return visit(ctx.tipo());
    }

    @Override
    public Integer visitSeqVacia(Anasint.SeqVaciaContext ctx) {

        return Anasint.SEQ;

    }

    @Override
    public Integer visitDecl_seq(Anasint.Decl_seqContext ctx) {

        String id = ctx.vars().getText();
        Integer value = visit(ctx.seq()) + visit(ctx.tipo());
        memoria2.put(id, value);
        System.out.println("Mapa declaraciones(SEQ): " +memoria2);
        return visit(ctx.tipo()) + visit(ctx.seq());
    }

    @Override
    public Integer visitAsignacion(Anasint.AsignacionContext ctx) {

        String id = ctx.idents().IDENT().getText();
        int value = visit(ctx.expresiones().expr());
        memoria.put(id, value);

        if(memoria2.get(id)!=memoria.get(id)){

            System.out.println("La variable '" +id+ "' tiene una asignacion incorrecta o no ha sido declarada (línea "+ ctx.start.getLine() +", " +ctx.start.getCharPositionInLine()+ ")");

        }
        //System.out.println(value);
        System.out.println("Mapa asignaciones: " +memoria);
        return value;
    }

    @Override
    public Integer visitInt(Anasint.IntContext ctx) {

        return Anasint.NUM;

    }

    @Override
    public Integer visitId(Anasint.IdContext ctx) {

        String id = ctx.IDENT().getText();

        if(!memoria.containsKey(id)){

            System.out.println("La variable '" +id+ "' no ha sido declarada o está vacía (línea "+ ctx.start.getLine() +", " +ctx.start.getCharPositionInLine()+ ")");

        }

        return Anasint.NUM;

    }

    @Override
    public Integer visitOpSeq(Anasint.OpSeqContext ctx) {

        String id = ctx.IDENT().getText();
        Integer re;
        if(!memoria.containsKey(id)){

            System.out.println("La variable '" +id+ "' no ha sido declara o está vacía (línea "+ ctx.start.getLine() +")");

        }

        if(memoria.containsKey(id)&&memoria.get(id)==58){

            re = Anasint.NUM;

        }else{

            re = Anasint.LOG;

        }

        return re;

    }

    @Override
    public Integer visitExpr_log(Anasint.Expr_logContext ctx) {
        //System.out.println(ctx.children);
        return Anasint.LOG;
    }

    @Override
    public Integer visitSeq_log(Anasint.Seq_logContext ctx) {

        return Anasint.SEQ + Anasint.LOG;

    }

    @Override
    public Integer visitSeq_num(Anasint.Seq_numContext ctx) {

        return Anasint.SEQ + Anasint.NUM;

    }

    @Override
    public Integer visitTipo(Anasint.TipoContext ctx) {

        Integer t = ctx.getStart().getType();
        //System.out.println("Tipo: " +ctx.children);
        return t;
    }

    @Override
    public Integer visitSeq(Anasint.SeqContext ctx) {

        Integer t = ctx.getStart().getType();

        return t;
    }



    //TODO



}
