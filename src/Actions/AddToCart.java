package Actions;

import Beans.LoginBean;
import Beans.ProductBean;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import sessionObjs.PurchaseObj;
import util.TableReader;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;

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
        String query, username, cf = "", codProdotto = "";
        int oldQty = -1, qty = 0, codAcquisto = -1, idFarmacia = -1;
        ResultSet table;
        TableReader reader = new TableReader();
        PurchaseObj acquisto = (PurchaseObj) request.getSession().getAttribute("cart");
        Date date = new Date();
        SimpleDateFormat sf = new SimpleDateFormat("yyyy.MM.dd");

        try
        {
            //l'acquisto non è ancora stato creato: (non c'è oggetto PurchaseObj in session)
            //allora questo è il primo prodotto e lo crea lui
            if (acquisto == null)
            {
                //recupera CF e idFamacia da username
                username = ((LoginBean) request.getSession().getAttribute("RegisterBean")).getUsername();
                query = "SELECT cf, idFarmacia FROM Operatori WHERE username = '" + username + "'";
                table = reader.getTable(query);

                while (table.next())
                {
                    cf = table.getString("cf");
                    idFarmacia = table.getInt("idFarmacia");
                }

                //insert nuovo acquisto
                query = "INSERT INTO acquisti(cfoperatore, totale, data) " +
                        "VALUES ('" + cf + "', 0, '" + sf.format(date) + "')";
                reader.update(query);

                //salva in session l'oggetto PurchaseObj a indicare che è stato aperto un acquisto (un "carrello")
                //con i dati appena inseriti
                acquisto = new PurchaseObj(cf, date, idFarmacia);
                request.getSession().setAttribute("cart", acquisto);
            }
            //altrimenti è già stato aggiunto qualche prodotto e quindi l'acquisto esiste in session
            else
            {
                cf = acquisto.getCfOp();
                date = acquisto.getDate();
                idFarmacia = acquisto.getIdFarmacia();
            }

            //recupera il codice dell'acquisto corrente
            query = "SELECT codAcquisto FROM acquisti WHERE cfOperatore = '" + cf + "' AND totale = 0 AND data = '" + sf.format(date) + "'";
            table = reader.getTable(query);

            while (table.next())
                codAcquisto = table.getInt("codAcquisto");

            //recupera i dati dal form e controlla le quantità
            codProdotto = bean.getProductName();
            qty = Integer.parseInt(bean.getQty());
            query = "SELECT quantitadisponibile FROM magazzino WHERE idFarmacia = " + idFarmacia +
                    " AND codProdotto = '" + codProdotto + "'";
            table = reader.getTable(query);

            while (table.next())
                oldQty = table.getInt("quantitadisponibile");

            if(oldQty < qty)
            {
                request.getSession().setAttribute("msg", "DISPONIBILITÀ SUPERATA!");
                return mapping.findForward("ADD_OK");
            }

            //insert nuovo carrello prodotto collegato all'acquisto
            query = "INSERT INTO carrello (codprodotto, quantita, codacquisto)" +
                    " VALUES ('" + codProdotto + "', " + qty + ", '" + codAcquisto + "');";
            reader.update(query);

            //aggiorna le quantità in magazzino
            query = "UPDATE magazzino SET quantitadisponibile = " + (oldQty - qty) +
                    " WHERE idFarmacia = " + idFarmacia + " AND codProdotto = '" + codProdotto + "'";
            reader.update(query);

        }
        catch(Exception e)
        {
            e.printStackTrace();
            request.getSession().setAttribute("msg", "ERRORE");
            return mapping.findForward("ERROR");
        }

        request.getSession().setAttribute("msg", "PRODOTTO AGGIUNTO AL CARRELLO");
        return mapping.findForward("ADD_OK");
    }
}
