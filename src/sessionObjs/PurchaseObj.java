package sessionObjs;

import java.util.Date;

/**
 * Created by ubuntu on 11/06/17.
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
