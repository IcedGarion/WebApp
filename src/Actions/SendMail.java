package Actions;

import Beans.LoginBean;
import Beans.MailBean;
import Beans.PharmacyBean;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import util.TableReader;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by ubuntu on 23/06/17.
 */
public class SendMail extends Action
{
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception
    {
        MailBean bean = (MailBean) form;
        LoginBean login = (LoginBean) request.getSession().getAttribute("RegisterBean");
        String[] dests;
        String obj, msg, data, query, username, role;
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        TableReader reader = new TableReader();

        try
        {
            role = (String)request.getSession().getAttribute("role");
            username = login.getUsername();
            dests = bean.getUsername();
            obj = bean.getObj();
            msg = bean.getText();
            data = dateFormat.format(new Date());


            //da fare insert multiple per ogni String in dests!
            //e capire dove mettere null, se è toOp o toReg!



            if(role.toLowerCase().equals("reg"))
                query = "INSERT INTO messaggi(dt_invio, fromreg, toreg, fromop, toop, oggetto, msg)\n" +
                    "    VALUES ('" + data + "', '" + username + "', "lol", null, "lol", '" + obj + "', '" + msg + "')";
            else
                query = "INSERT INTO messaggi(dt_invio, fromreg, toreg, fromop, toop, oggetto, msg)\n" +
                        "    VALUES ('" + data + "', null, "lol", '" + username + "', "lol", '" + obj + "', '" + msg + "')";


            reader.update(query);
        }
        catch(Exception e)
        {
            request.getSession().setAttribute("exitCode", "Errore invio mail ");
            return mapping.findForward("ERROR");
        }

        request.getSession().setAttribute("msg", "Mail inviata! ");
        return mapping.findForward("SEND_OK");
    }

}