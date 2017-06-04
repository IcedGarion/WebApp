package Beans;

import org.apache.struts.action.ActionForm;

/**
 * Created by ubuntu on 04/06/17.
 */
public class WarehouseBean extends ActionForm
{
    private String quantita;
    private String productName;

    public WarehouseBean()
    {}

    public String getQuantita() {
        return quantita;
    }

    public void setQuantita(String quantita) {
        this.quantita = quantita;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }
}
