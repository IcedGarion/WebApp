package Actions;

import Beans.LoginBean;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * Created by ubuntu on 12/05/17.
 */
public class RegisterAction extends Action
{
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception
    {
        LoginBean bean = (LoginBean) form;
        Connection connection = null;
        Statement st = null;
        ResultSet resultSet;
        String username = "", password = "", role = "";
        boolean loginOk = false;

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
            username = bean.getUsername();
            password = bean.getPasswd();
            role = bean.getRole();
            String tableName;

            if(role.equals("reg"))
            {
                tableName = "regione";
            }
            else
            {
                tableName = "operatori";
            }

            resultSet = st.executeQuery("SELECT * FROM " + tableName + " WHERE username = '" + username
             + "' AND pass = '" + password + "'");


            while(resultSet.next())
            {
                String dbUsername = resultSet.getString("username");
                String db_pass = resultSet.getString("pass");

                if(dbUsername.equals(username) && (db_pass.equals(password)))
                {
                    loginOk = true;

                    if(! role.equals("reg"))
                        role = resultSet.getString("ruolo");
                }
            }
        }
        catch(Exception e)
        {
            System.out.println("Errore nella query");
            e.printStackTrace();
            request.setAttribute("exitCode", "Query sql non valida");
            connection.close();

            return mapping.findForward("ERROR");
        }

        if(loginOk)
        {
            request.setAttribute("role", role);
            connection.close();
            return mapping.findForward("LOGIN_OK");
        }
        else
        {
            request.setAttribute("exitCode", "Username o Password non corretti");
            connection.close();
            return mapping.findForward("ERROR");
        }
    }
}
