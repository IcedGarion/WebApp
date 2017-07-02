package Actions;

import Beans.LoginBean;
import Beans.MailBean;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import util.TableReader;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.ResultSet;
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
        String obj, msg, data, query = "", username, role, dest, tf = "", queryTf;
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        TableReader reader = new TableReader();
        ResultSet table;

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

            if(dests.length > 0)
            {
                dest = dests[0];

                //regione non può inviare a "un'altra" regione
                if(role.toLowerCase().equals("reg"))
                {
                    //cerca username del titolare della farmacia
                    queryTf = "SELECT Operatori.username FROM Operatori JOIN Farmacie"
                    + " ON Operatori.idFarmacia = Farmacie.id"
                    + " WHERE Operatori.ruolo = 'TF' AND Farmacie.nome = '" + dest + "'";
                    table = reader.getTable(queryTf);

                    while(table.next())
                        tf = table.getString("username");

                    //invia al rispettivo titolare
                    query = "INSERT INTO messaggi(dt_invio, fromreg, toreg, fromop, toop, oggetto, msg)\n" +
                            "    VALUES ('" + data + "', '" + username + "', null, null, '" + tf + "', '" + obj + "', '" + msg + "')";

                }
                else
                {
                    //se il destinatario e' regione, setta la property toOp a null
                    if(dest.toLowerCase().startsWith("reg"))
                        query = "INSERT INTO messaggi(dt_invio, fromreg, toreg, fromop, toop, oggetto, msg)\n" +
                            "    VALUES ('" + data + "', null, '" + dest + "', '" + username + "', null, '" + obj + "', '" + msg + "')";
                    //viceversa
                    else
                        query = "INSERT INTO messaggi(dt_invio, fromreg, toreg, fromop, toop, oggetto, msg)\n" +
                                "    VALUES ('" + data + "', null, null, '" + username + "', '" + dest + "', '" + obj + "', '" + msg + "')";
                }

                for(int i=1; i<dests.length; i++)
                {
                    //accoda altre insert alla precedente, se ci sono piu' destinatari:
                    //stessa logica di prima
                    dest = dests[i];
                    if(role.toLowerCase().equals("reg"))
                    {
                        //cerca username del titolare della farmacia
                        queryTf = "SELECT Operatori.username FROM Operatori JOIN Farmacie"
                                + " ON Operatori.idFarmacia = Farmacie.id"
                                + " WHERE Operatori.ruolo = 'TF' AND Farmacie.nome = '" + dest + "'";
                        table = reader.getTable(queryTf);

                        while(table.next())
                            tf = table.getString("username");


                        query += ", ('" + data + "', '" + username + "', null, null, '" + tf + "', '" + obj + "', '" + msg + "')";
                    }
                    else
                    {
                        if(dest.toLowerCase().startsWith("reg"))
                            query += ", ('" + data + "', null, '" + dest + "', '" + username + "', null, '" + obj + "', '" + msg + "')";
                            //viceversa
                        else
                            query += ", ('" + data + "', null, null, '" + username + "', '" + dest + "', '" + obj + "', '" + msg + "')";
                    }
                }
            }
            else
            {
                request.getSession().setAttribute("msg", "Nessun destinatario scelto! ");
                return mapping.findForward("SEND_OK");
            }


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