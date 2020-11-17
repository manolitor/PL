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
        memoria2.put(id, value);
        //System.out.println(memoria2);
        return visit(ctx.tipo());
    }

    @Override
    public Integer visitDecl_seq(Anasint.Decl_seqContext ctx) {

        String id = ctx.vars().getText();
        Integer value = visit(ctx.seq());
        memoria2.put(id, value);
        //System.out.println(memoria2);
        return visit(ctx.tipo());
    }

    @Override
    public Integer visitAsignacion(Anasint.AsignacionContext ctx) {

        String id = ctx.idents().IDENT().getText();
        int value = visit(ctx.expresiones().expr());
        memoria.put(id, value);

        if(memoria2.get(id)!=memoria.get(id)){

            System.out.println("La variable: " +id+ " tiene un tipo incorrecto o no ha sido declarada");

        }
        //System.out.println(value);
        //System.out.println(memoria);
        return value;
    }

    @Override
    public Integer visitExpr_num(Anasint.Expr_numContext ctx) {
        //System.out.println(ctx.children);
        return Anasint.NUM;
    }

    @Override
    public Integer visitExpr_log(Anasint.Expr_logContext ctx) {
        //System.out.println(ctx.children);
        return Anasint.LOG;
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





}
