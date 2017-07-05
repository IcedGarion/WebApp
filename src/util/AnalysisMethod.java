package util;

import java.sql.ResultSet;
import java.sql.SQLException;

public class AnalysisMethod
{
    private TableReader reader;
    private String role;
    private int idFarmacia;
    private String queryDate;

    public AnalysisMethod(String username, String role, String start, String end) throws SQLException
    {
        String query;
        ResultSet table;

        this.reader = new TableReader();
        this.role = role;

        if(start != null && end != null)
            this.queryDate = " AND acquisti.data > '" + start + "' AND acquisti.data < '" + end + "'";
        else
            this.queryDate = "";

        if (role.equals("tf"))
        {
            //si salva idFarmacia
            query = "SELECT idFarmacia FROM Operatori where username = '" + username + "'";
            table = reader.getTable(query);
            while(table.next())
                this.idFarmacia = table.getInt("idFarmacia");
        }
    }

    public int getTotPurchases() throws SQLException
    {
        String queryForTf, queryForReg;

        //per tf, sceglie tutti gli acquisti degli operatori di quella farmacia (solo acquisti completati)
        queryForTf = "SELECT COUNT(*) AS count FROM Acquisti JOIN Operatori on Acquisti.cfOperatore = Operatori.cf"
                    + " WHERE Operatori.idFarmacia = " + idFarmacia + " AND Acquisti.completato = true";
        //per reg, sceglie tutti gli acquisti di tutti gli operatori (solo acquisti completati)
        queryForReg = "SELECT COUNT(*) FROM Acquisti JOIN Operatori on Acquisti.cfOperatore = Operatori.cf"
                    + " WHERE Acquisti.completato = true";


        queryForTf += queryDate;
        queryForReg += queryDate;

        return getTable(queryForTf, queryForReg);
    }

    public int getTotSold() throws SQLException
    {
        String queryForTf, queryForReg;

        //per tf, sceglie tutti i prodotti di tutti gli acquisti degli operatori di quella farmacia (solo acquisti completati)
        queryForTf = "SELECT SUM(Carrello.quantita) AS count FROM Acquisti JOIN Operatori on Acquisti.cfOperatore = Operatori.cf"
                    + " JOIN carrello on Acquisti.codAcquisto = Carrello.codAcquisto"
                    + " WHERE Operatori.idFarmacia = " + idFarmacia + "AND Acquisti.completato = true";
        //per reg, sceglie tutti i prodotti gli acquisti di tutti gli operatori (solo acquisti completati)
        queryForReg = "SELECT SUM(Carrello.quantita) AS count FROM Acquisti JOIN Operatori on Acquisti.cfOperatore = Operatori.cf"
                    + " JOIN carrello on Acquisti.codAcquisto = Carrello.codAcquisto"
                    + " WHERE Acquisti.completato = true";

        queryForTf += queryDate;
        queryForReg += queryDate;

        return getTable(queryForTf, queryForReg);
    }

    public int getTotSoldWithPrescription() throws SQLException
    {
        String queryForTf, queryForReg;

        //per tf, sceglie tutti i prodotti di tutti gli acquisti degli operatori di quella farmacia (solo acquisti completati)
        queryForTf = "SELECT SUM(Carrello.quantita) AS count FROM Acquisti JOIN Operatori on Acquisti.cfOperatore = Operatori.cf"
                    + " JOIN carrello on Acquisti.codAcquisto = Carrello.codAcquisto JOIN Ricette on Carrello.id = Ricette.idCarrello"
                    + " WHERE Operatori.idFarmacia = " + idFarmacia + "AND Acquisti.completato = true";

        //per reg, sceglie tutti i prodotti gli acquisti di tutti gli operatori (solo acquisti completati)
        queryForReg = "SELECT SUM(Carrello.quantita) AS count FROM Acquisti JOIN Operatori on Acquisti.cfOperatore = Operatori.cf"
                    + " JOIN carrello on Acquisti.codAcquisto = Carrello.codAcquisto JOIN Ricette on Carrello.id = Ricette.idCarrello"
                    + " WHERE Acquisti.completato = true";

        queryForTf += queryDate;
        queryForReg += queryDate;

        return getTable(queryForTf, queryForReg);
    }

    public int getTotPrescriptions() throws SQLException
    {
        String queryForTf, queryForReg;

        //per tf,
        queryForTf = "SELECT COUNT(*) AS count FROM Acquisti JOIN Operatori on Acquisti.cfOperatore = Operatori.cf"
                    + " JOIN carrello on Acquisti.codAcquisto = Carrello.codAcquisto JOIN Ricette on Carrello.id = Ricette.idCarrello"
                    + " WHERE Operatori.idFarmacia = " + idFarmacia + "AND Acquisti.completato = true";

        //per reg,
        queryForReg = "SELECT COUNT(*) AS count FROM Acquisti JOIN Operatori on Acquisti.cfOperatore = Operatori.cf"
                    + " JOIN carrello on Acquisti.codAcquisto = Carrello.codAcquisto JOIN Ricette on Carrello.id = Ricette.idCarrello"
                    + " WHERE Acquisti.completato = true";

        queryForTf += queryDate;
        queryForReg += queryDate;

        return getTable(queryForTf, queryForReg);
    }

    public float getMeanOfPrescription() throws SQLException
    {
        String queryForTf, queryForReg;

        //per tf, (simile a tot prodotti con ricetta) prende tutti i prodotti degli gli acquisti con ricetta
        //della farmacia dell'operatore che fa la query, e li divide per il numero di quegli acquisti con ricetta
        queryForTf = "SELECT AVG(Carrello.quantita) AS count FROM Acquisti JOIN Operatori on Acquisti.cfOperatore = Operatori.cf"
                + " JOIN carrello on Acquisti.codAcquisto = Carrello.codAcquisto JOIN Ricette on Carrello.id = Ricette.idCarrello"
                + " WHERE Operatori.idFarmacia = " + idFarmacia + "AND Acquisti.completato = true";

        //per reg, (simile) prende tutti i prodotti con ricetta venduti e divide per il numero i acquisti con ricetta
        queryForReg = "SELECT AVG(Carrello.quantita) AS count FROM Acquisti JOIN Operatori on Acquisti.cfOperatore = Operatori.cf"
                + " JOIN carrello on Acquisti.codAcquisto = Carrello.codAcquisto JOIN Ricette on Carrello.id = Ricette.idCarrello"
                + " WHERE Acquisti.completato = true";

        queryForTf += queryDate;
        queryForReg += queryDate;

        return getTable(queryForTf, queryForReg);
    }

    //result column is always named "count"
    private int getTable(String queryForTf, String queryForReg) throws SQLException
    {
        String query = "";
        ResultSet table;
        int tot = 0;

        //prende il ruolo in session e decide la query
        if(role.equals("tf"))
            query = queryForTf;
        else if(role.equals("reg"))
            query = queryForReg;

        table = reader.getTable(query);
        while(table.next())
            tot = table.getInt("count");

        return tot;
    }
}
