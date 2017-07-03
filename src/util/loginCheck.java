package util;

import Beans.LoginBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.*;

public class loginCheck
{
    //legge il bean del form login, imposta ruolo in session; ritorna stringa di errore/login_ok
    //controlla anche se i ruoli corrispondono
    public static String check(LoginBean form, HttpServletRequest request, String roleCheck) throws SQLException
    {
        LoginBean bean = (LoginBean) form;
        ResultSet resultSet;
        String username = "", password = "", role = "";
        boolean loginOk = false;
        TableReader reader = new TableReader();

        try
        {
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

            resultSet = reader.getTable("SELECT * FROM " + tableName + " WHERE username = '" + username
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
            request.getSession().setAttribute("role", "none");
            //e.printStackTrace();

            return "Query sql non valida";
        }

        if(loginOk)
        {
            if(roleCheck != null)
            {
                //controlla se ruolo è "pers" (tf, df, ob) (nel login bean)
                if(roleCheck.toLowerCase().equals("pers") && (role.toLowerCase().equals("tf") || role.toLowerCase().equals("df") || role.toLowerCase().equals("ob")))
                {
                    //salva il ruolo in session
                    request.getSession().setAttribute("role", role);
                    return "LOGIN_OK";
                }
                //se non è pers, sarà reg : controlla se nel login bean c'è reg
                else if(roleCheck.toLowerCase().equals(role.toLowerCase()))
                {
                    //salva il ruolo in session
                    request.getSession().setAttribute("role", role);
                    return "LOGIN_OK";
                }
                else
                {
                    request.getSession().setAttribute("exitCode", "Area riservata a " + roleCheck);
                    return "ERROR";
                }
            }
            //se roleCHeck è null, non controlla il ruolo
            else
            {
                //salva il ruolo in session
                request.getSession().setAttribute("role", role);
                return "LOGIN_OK";
            }
        }
        else
        {
            request.getSession().setAttribute("exitCode", "Username o Password non corretti");
            request.getSession().setAttribute("role", "none");
            return "ERROR";
        }
    }
}
