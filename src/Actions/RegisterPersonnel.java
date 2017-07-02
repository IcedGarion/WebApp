package Actions;

import Beans.LoginBean;
import Beans.PersonBean;
import Beans.PharmacyBean;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class RegisterPersonnel extends Action
{
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception
    {
        PersonBean bean = (PersonBean) form;
        HttpSession session;
        Connection connection = null;
        Statement st = null;
        ResultSet resultSet;
        String usernameTF = "", username = "", password = "", role = "", cf = "", nome = "", cognome = "";
        String indirizzo = "", telefono = "", nomeF = "", dataNascita = "";
        int conta = 0, farmacia = -1;

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

            request.setAttribute("exitCode", "Errore Connessione al DB");
            return mapping.findForward("REGISTER");
        }

        try
        {
            st = connection.createStatement();
            username = bean.getUsername();

            //prima cerca se username esiste già
            String query = "SELECT * FROM Operatori WHERE username = '" + username + "'";
            resultSet = st.executeQuery(query);

            while(resultSet.next())
                conta++;

            if(conta != 0)
            {
                request.setAttribute("exitCode", "Username già esistente");
                return mapping.findForward("REGISTER");
            }

            //cerca idFarmacia del titolare che sta inserendo
            usernameTF = ((LoginBean) request.getSession().getAttribute("RegisterBean")).getUsername();
            query = "SELECT * FROM Operatori WHERE username = '" + usernameTF + "'";
            resultSet = st.executeQuery(query);

            while(resultSet.next())
                farmacia = resultSet.getInt("idFarmacia");

            //inserisce tutti i dati del form, con idfarmacia appena ricavato
            password = bean.getPassword();
            role = bean.getRole().toUpperCase();
            cf = bean.getCf();
            nome = bean.getNome();
            cognome = bean.getCognome();
            dataNascita = bean.getDataNascita();

            //inserice il nuovo titolare
            query = "INSERT INTO Operatori (cf, idFarmacia, ruolo, nome, cognome, dataNascita, username, pass) values ("
                    + "'" + cf + "', " + farmacia + ", " + "'" + role + "', " + "'" + nome + "', " + "'" + cognome + "', " + "'" + dataNascita + "', "
                    + "'" + username + "', " + "'" + password + "')";
            st.executeUpdate(query);

            request.setAttribute("exitCode", "REGISTRAZIONE AVVENUTA CON SUCCESSO");
            return mapping.findForward("REGISTER");
        }
        catch (Exception e)
        {
            System.out.println("Errore nella query");
            e.printStackTrace();
            connection.close();

            if(e.getMessage().contains("duplicate key"))
            {
                request.setAttribute("exitCode", "Utente gia' registrato!");
                return mapping.findForward("REGISTER");
            }
            else
            {
                request.setAttribute("exitCode", "Query sql non valida");
                return mapping.findForward("REGISTER");
            }
        }
    }
}
