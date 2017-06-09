package Actions;

import Beans.LoginBean;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import util.loginCheck;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginAction extends Action
{
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception
    {
        //legge il bean del form login, imposta ruolo in session; ritorna stringa di errore/login_ok
        String result = loginCheck.check(((LoginBean) form), request, null);

        //se ritorna login_ok continuerà con la pag. richesta
        if(result.equals("LOGIN_OK"))
            return mapping.findForward("LOGIN_OK");
        //altrimenti manda a una pag. di errore
        else
            return mapping.findForward("ERROR");
    }
}
