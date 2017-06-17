package Actions;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import sessionObjs.CodPurchase;
import util.TableReader;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.ResultSet;

public class ProcessPurchase extends Action
{
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception
    {
        TableReader reader;
        String query;
        ResultSet table;
        boolean completato = true, ok = false;

        try
        {
            reader = new TableReader();

            //recupera codAcquisto da session
            int codAcquisto = ((CodPurchase) request.getSession().getAttribute("codAcquisto")).getCodAcquisto();

            //mette a true acquisto where codAcquisto = quello corrente della session
            query = "SELECT completato FROM Acquisti WHERE codAcquisto = " + codAcquisto;
            table = reader.getTable(query);
            while (table.next())
                completato = table.getBoolean("completato");

            if(completato)
            {
                request.getSession().setAttribute("exitCode", "ERRORE NEL CHECKOUT : Acquisto già completato");
                return mapping.findForward("ERROR");
            }

            query = "UPDATE Acquisti SET completato = true WHERE codAcquisto = " + codAcquisto;
            ok = reader.update(query);

            if(! ok)
            {
                request.getSession().setAttribute("exitCode", "ERRORE NEL CHECKOUT");
                return mapping.findForward("ERROR");
            }

            //alla fine svuota tutti gli oggetti in session
            request.getSession().removeAttribute("ricetta");
            request.getSession().removeAttribute("cart");
            request.getSession().removeAttribute("quantity");
            request.getSession().removeAttribute("codAcquisto");
        }
        catch(Exception e)
        {
            request.getSession().setAttribute("exitCode", "ERRORE NEL CHECKOUT");
            return mapping.findForward("ERROR");
        }

        request.getSession().setAttribute("msg", "ACQUISTO COMPLETATO");
        return mapping.findForward(("PURCHASE_OK"));
    }
}
