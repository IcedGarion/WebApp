package sessionObjs;

import java.util.Date;

/**
 * Dice soltanto se è già stato aperto un acquisto (è in corso)
 * e si salva alcuni dati per non andarli a riprendere in db
 */
public class PurchaseObj
{
    private String cfOp;
    private String formatDate;
    private int idFarmacia;

    public PurchaseObj(String cfOp, String date, int idFarmacia)
    {
        this.cfOp = cfOp;
        this.formatDate = date;
        this.idFarmacia = idFarmacia;
    }

    public String getCfOp() { return cfOp; }

    public String getFormatDate() {
        return formatDate;
    }

    public int getIdFarmacia() { return idFarmacia; }
}
