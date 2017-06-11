package Beans;

import org.apache.struts.action.ActionForm;

public class ProductBean extends ActionForm
{
    private String productName;
    private String qty;

    public ProductBean()
    {}

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getQty() {
        return qty;
    }

    public void setQty(String qty) {
        this.qty = qty;
    }
}

