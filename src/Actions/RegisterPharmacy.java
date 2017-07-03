package Actions;

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
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class RegisterPharmacy extends Action
{
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception
    {
        PharmacyBean bean = (PharmacyBean) form;
        ResultSet resultSet;
        String username = "", password = "", role = "", cf = "", nome = "", cognome = "";
        String indirizzo = "", telefono = "", nomeF = "", dataNascita = "";
        TableReader reader;

        try
        {
            reader = new TableReader();
            username = bean.getUsername();
            password = bean.getPassword();
            role = "TF";
            cf = bean.getCf();
            nome = bean.getNome();
            cognome = bean.getCognome();
            dataNascita = bean.getDataNascita();
            nomeF = bean.getNomeF();
            indirizzo = bean.getIndirizzo();
            telefono = bean.getTelefono();

            //controlla se la farmacia esiste gia
            String query = "SELECT * FROM Farmacie WHERE nome = '" + nomeF + "'" + " AND indirizzo = '" + indirizzo +
                    "' AND telefono = '" + telefono + "'";
            resultSet = reader.getTable(query);
            int conta = 0;

            while(resultSet.next())
                conta++;

            if(conta != 0)
            {
                request.setAttribute("exitCode", "Farmacia già esistente");
                return mapping.findForward("REGISTER");
            }

            //controlla se titolare esiste gia' come operatore
            query = "SELECT * FROM Operatori WHERE username = '" + username + "'";
            resultSet = reader.getTable(query);
            conta = 0;

            while(resultSet.next())
                conta++;

            if(conta != 0)
            {
                request.setAttribute("exitCode", "Operatore già esistente");
                return mapping.findForward("REGISTER");
            }

            //inserisce farmacia collegata con cf
            query = "INSERT INTO Farmacie (nome, indirizzo, telefono) VALUES ("
                    + "'" + nomeF + "', " + "'" + indirizzo + "', " + "'" + telefono + "')";
            reader.update(query);

            //recupera id farmacia appena inserita
            query = "SELECT id FROM Farmacie WHERE nome = '" + nomeF + "' AND indirizzo = '" + indirizzo + "' AND telefono = '" + telefono + "'";
            resultSet = reader.getTable(query);
            int idFarmacia = 0;
            while(resultSet.next())
                idFarmacia = resultSet.getInt("id");

            //inserice il nuovo titolare
            query = "INSERT INTO Operatori (cf, idFarmacia, ruolo, nome, cognome, dataNascita, username, pass) values ("
                    + "'" + cf + "', " + "'" + idFarmacia + "', " + "'" + role + "', " + "'" + nome + "', " + "'" + cognome + "', " + "'" + dataNascita + "', "
                    + "'" + username + "', " + "'" + password + "')";
            reader.update(query);

            request.setAttribute("exitCode", "REGISTRAZIONE AVVENUTA CON SUCCESSO");
            return mapping.findForward("REGISTER");
        }
        catch (Exception e)
        {
            System.out.println("Errore nella query");
            e.printStackTrace();

            request.setAttribute("exitCode", "Query sql non valida");
            return mapping.findForward("REGISTER");
        }
    }
}