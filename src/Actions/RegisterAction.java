package Actions;

import Beans.QueryBean;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

/**
 * Created by ubuntu on 12/05/17.
 */
public class RegisterAction extends Action
{
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception
    {
        QueryBean bean = (QueryBean) form;
        Connection connection = null;
        Statement st = null;
        String query = "";

        try
        {
            Class.forName("org.postgresql.Driver");
            connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/contabilita", "ubuntu", "ubuntu");
        }
        catch (Exception e)
        {
            System.out.println("Errore connessione al DB");
            e.printStackTrace();
            request.setAttribute("exitCode", "Errore Connessione al DB");
            connection.close();
            return mapping.findForward("ERROR");
        }

        try
        {
            st = connection.createStatement();
            query = bean.getQuery();
            st.executeUpdate(query);
        }
        catch(Exception e)
        {
            System.out.println("Errore nella query");
            e.printStackTrace();
            request.setAttribute("exitCode", "Query sql non valida");
            connection.close();
            return mapping.findForward("ERROR");
        }

        request.setAttribute("exitCode", "Query eseguita");
        connection.close();
        return mapping.findForward("Ok");
    }
}
