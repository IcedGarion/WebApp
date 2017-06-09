package Beans;

import org.apache.struts.action.ActionForm;

public class ProductBean extends ActionForm
{
    private String cf;
    private String qty;

    public ProductBean()
    {}

    public String getCf() {
        return cf;
    }

    public void setCf(String cf) {
        this.cf = cf;
    }

    public String getQty() {
        return qty;
    }

    public void setQty(String qty) {
        this.qty = qty;
    }
}

