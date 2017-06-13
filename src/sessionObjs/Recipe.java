package sessionObjs;

/**
 * Created by ubuntu on 13/06/17.
 */
public class Recipe
{
    private String codProdotto;
    private int qty;

    public Recipe(String codProdotto, int qty)
    {
        this.codProdotto = codProdotto;
        this.qty = qty;
    }

    public String getCodProdotto()
    {
        return codProdotto;
    }

    public void setCodProdotto(String codProdotto)
    {
        this.codProdotto = codProdotto;
    }

    public int getQty()
    {
        return qty;
    }

    public void setQty(int qty)
    {
        this.qty = qty;
    }
}
