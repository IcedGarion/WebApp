package util;

import java.sql.ResultSet;
import java.sql.SQLException;

public class AnalysisMethod
{
    private TableReader reader;
    private String role;
    private int idFarmacia;

    public AnalysisMethod(String username, String role) throws SQLException
    {
        String query;
        ResultSet table;

        this.reader = new TableReader();
        this.role = role;

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
        String query = "";
        ResultSet table;
        int totPurchases = 0;

        if(role.equals("tf"))
        {
            //per tf, sceglie tutti gli acquisti degli operatori di quella farmacia (solo acquisti completati)
            query = "SELECT COUNT(*) AS count FROM Acquisti JOIN Operatori on Acquisti.cfOperatore = Operatori.cf"
                    + " WHERE Operatori.idFarmacia = " + idFarmacia + " AND Acquisti.completato = true";
        }
        else if(role.equals("reg"))
        {
            //per reg, sceglie tutti gli acquisti di tutti gli operatori (solo acquisti completati)
            query = "SELECT COUNT(*) FROM Acquisti JOIN Operatori on Acquisti.cfOperatore = Operatori.cf"
                    + " WHERE Acquisti.completato = true";
        }

        table = reader.getTable(query);
        while(table.next())
            totPurchases = table.getInt("count");

        return totPurchases;
    }

    public int getTotSold() throws SQLException
    {
        String query = "";
        ResultSet table;
        int totPurchases = 0;

        if(role.equals("tf"))
        {
            //per tf, sceglie tutti i prodotti di tutti gli acquisti degli operatori di quella farmacia (solo acquisti completati)
            query = "SELECT SUM(Carrello.quantita) AS count FROM Acquisti JOIN Operatori on Acquisti.cfOperatore = Operatori.cf"
                    + " JOIN carrello on Acquisti.codAcquisto = Carrello.codAcquisto"
                    + " WHERE Operatori.idFarmacia = " + idFarmacia + "AND Acquisti.completato = true";
        }
        else if(role.equals("reg"))
        {
            //per reg, sceglie tutti i prodotti gli acquisti di tutti gli operatori (solo acquisti completati)
            query = "SELECT SUM(Carrello.quantita) AS count FROM Acquisti JOIN Operatori on Acquisti.cfOperatore = Operatori.cf"
                    + " JOIN carrello on Acquisti.codAcquisto = Carrello.codAcquisto"
                    + " WHERE Acquisti.completato = true";
        }

        table = reader.getTable(query);
        while(table.next())
            totPurchases = table.getInt("count");

        return totPurchases;
    }

    public int getTotSoldWithPrescription()
    {
        return -1;
    }

    public int getTotPrescriptions()
    {
        return -1;
    }

    public int getMeanOfPrescription()
    {
        return -1;
    }
}
