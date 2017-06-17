package Actions;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ProcessPurchase extends Action
{
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception
    {
        //recupera codAcquisto da session


        //mette a true acquisto where codAcquisto = quello corrente della session

        //alla fine farà...
        request.getSession().removeAttribute("ricetta");
        request.getSession().removeAttribute("cart");
        request.getSession().removeAttribute("quantity");
        request.getSession().removeAttribute("codAcquisto");


        return mapping.findForward(("PURCHASE_OK"));
    }
}
