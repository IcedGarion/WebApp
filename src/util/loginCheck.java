package util;

import Beans.LoginBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.*;

/**
 * Created by ubuntu on 28/05/17.
 */
public class loginCheck
{
    //legge il bean del form login, imposta ruolo in session; ritorna stringa di errore/login_ok
    public static String check(LoginBean form, HttpServletRequest request) throws SQLException
    {
        LoginBean bean = (LoginBean) form;
        HttpSession session;
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
            connection.close();

            return "Errore Connessione al DB";
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
            connection.close();

            return "Query sql non valida";
        }

        if(loginOk)
        {
            //salva il bean di login in session
            request.getSession().setAttribute("role", role);
            connection.close();
            return "LOGIN_OK";
        }
        else
        {
            request.setAttribute("exitCode", "Username o Password non corretti");
            connection.close();
            return "ERROR";
        }
    }
}
