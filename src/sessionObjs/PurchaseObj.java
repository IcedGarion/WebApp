package sessionObjs;

import java.util.Date;

/**
 * Dice soltanto se è già stato aperto un acquisto (è in corso)
 * e si salva alcuni dati per non andarli a riprendere in db
 */
public class PurchaseObj
{
    private String cfOp;
    private Date date;
    private int idFarmacia;

    public PurchaseObj(String cfOp, Date date, int idFarmacia)
    {
        this.cfOp = cfOp;
        this.date = date;
        this.idFarmacia = idFarmacia;
    }

    public String getCfOp() { return cfOp; }

    public Date getDate() {
        return date;
    }

    public int getIdFarmacia() { return idFarmacia; }
}
