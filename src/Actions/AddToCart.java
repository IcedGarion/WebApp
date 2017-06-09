package Actions;

import Beans.LoginBean;
import Beans.ProductBean;
import Beans.WarehouseBean;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import util.TableReader;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.ResultSet;

/**
 * Created by ubuntu on 09/06/17.
 */
public class AddToCart extends Action
{
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception
    {
        ProductBean bean = (ProductBean) form;
        boolean result;
        String query, productName, codProdotto = "";
        int qty;
        ResultSet table;
/*
        TableReader reader = new TableReader();
        qty = Integer.parseInt(bean.getQuantita());
        username = ((LoginBean) request.getSession().getAttribute("RegisterBean")).getUsername();


        //prende la farmacia de'operatore che sta eseguendo
        query = "SELECT idFarmacia FROM Operatori WHERE username = '" + username + "'";
        table = reader.getTable(query);

        while(table.next())
            farmacia = table.getInt("idFarmacia");


        //prende il codice del prodotto associato
        query = "SELECT codProdotto FROM Prodotti WHERE nome = '" + productName + "'";
        table = reader.getTable(query);

        while(table.next())
            codProdotto = table.getString("codProdotto");


        //legge il vecchio valore di quantità in magazzino
        query = "SELECT quantitadisponibile FROM Magazzino WHERE codProdotto = '" + codProdotto + "'"
                + " AND idFarmacia = " + farmacia;
        table = reader.getTable(query);

        while(table.next())
            oldQty = table.getInt("quantitadisponibile");


        //aggiorna la tabella magazzino
        query = "UPDATE Magazzino SET quantitadisponibile = " + (oldQty + qty) + " WHERE codProdotto = '" + codProdotto + "' AND idFarmacia = " + farmacia;
        result = reader.update(query);

        if(result)
            return mapping.findForward("REFILL_OK");
        else
        {
            request.setAttribute("exitCode", "Errore nell'ordine");
            return mapping.findForward("ERROR");
        }
        */

        return mapping.findForward("ERROR");
    }
}
