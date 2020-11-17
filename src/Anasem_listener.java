import java.util.HashMap;
import java.util.Map;

public class Anasem_listener extends AnasintBaseListener{

public Map<String, Integer> variables = new HashMap<>();

class Tipo{

    private int valor;
    public Tipo(){

        valor = -1;

    }

    public int getValor(){

        return valor;

    }

    public void setValor (int valor){

        if (valor == -1 || valor == Anasint.LOG || valor == Anasint.SEQ || valor == Anasint.NUM)
            this.valor = valor;
        else
            System.out.println("Tipo con valor incorrecto " +valor);

    }

}


    public void exitSentecia(Anasint.ExpresionesContext ctx) {
        Tipo tipo = new Tipo();
        exitExpr(ctx.expr(), tipo);
        if(tipo.getValor() == -1)
            System.out.println("ERROR");
        else
            System.out.println("NO ERROR");

    }

    public void exitExpr (Anasint.ExprContext ctx, Tipo tipo){



    }
}
