package Actions;

import Beans.LoginBean;
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
import java.util.Date;

/**
 * Created by ubuntu on 31/05/17.
 */
public class RegisterPharmacy extends Action
{
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        PharmacyBean bean = (PharmacyBean) form;
        HttpSession session;
        Connection connection = null;
        Statement st = null;
        ResultSet resultSet;
        String username = "", password = "", role = "", cf = "", nome = "", cognome = "", codReg = "", usernameF, passF, nomeF, dataNascita;
        boolean loginOk = false;

        try {
            Class.forName("org.postgresql.Driver");
            connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/contabilita", "ubuntu", "ubuntu");
        } catch (Exception e) {
            System.out.println("Errore connessione al DB");
            e.printStackTrace();
            connection.close();

            request.setAttribute("exitCode", "Errore Connessione al DB");
            return mapping.findForward("REGISTER");
        }

        try {
            st = connection.createStatement();
            username = bean.getUsername();
            password = bean.getPassword();
            role = "TF";
            cf = bean.getCf();
            nome = bean.getNome();
            cognome = bean.getCognome();
            codReg = bean.getCodRegionale();
            dataNascita = bean.getDataNascita();
            usernameF = bean.getUsernameF();
            passF = bean.getPasswordF();
            nomeF = bean.getNomeF();

            //inserice il nuovo titolare
            String query = "INSERT INTO Operatori (cf, ruolo, nome, cognome, dataNascita, codRegionale, username, pass) values ("
                    + "'" + cf + "', " + "'" + role + "', " + "'" + nome + "', " + "'" + cognome + "', " + "'" + dataNascita + "', "
                    + "'" + codReg + "', " + username + "', " + "'" + password + "')";
            st.executeUpdate(query);

            //inserisce farmacia collegata con cf
            query = "INSERT INTO regione(username, pass, cftitolarefarmacia, nomefarmacia) VALUES ("
                    + "'" + usernameF + "', " + "'" + passF + "', " + "'" + cf + "', " + "'" + nomeF + "')";
            st.executeUpdate(query);


            request.setAttribute("exitCode", "REGISTRAZIONE AVVENUTA CON SUCCESSO");
            return mapping.findForward("REGISTER");
        }
        catch (Exception e)
        {
            System.out.println("Errore nella query");
            e.printStackTrace();
            connection.close();

            request.setAttribute("exitCode", "Query sql non valida");
            return mapping.findForward("REGISTER");
        }
    }
}