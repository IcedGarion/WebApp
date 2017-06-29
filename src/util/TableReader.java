package util;

import java.sql.*;

public class TableReader
{
    private Connection connection;
    private Statement st;
    private ResultSet resultSet;

    public TableReader() throws SQLException
    {
        try
        {
            Class.forName("org.postgresql.Driver");
            connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/contabilita", "ubuntu", "ubuntu");
        }
        catch(Exception e)
        {
            System.out.println("Errore connessione al DB");
            e.printStackTrace();
            connection.close();
        }
    }

    public ResultSet getTable(String query) throws SQLException
    {
        try
        {
            st = connection.createStatement();
            resultSet = st.executeQuery(query);
        }
        catch(Exception e)
        {
            System.out.println("Errore nella query");
            e.printStackTrace();
            connection.close();

            return null;
        }

        return resultSet;
    }

    public boolean update(String query) throws SQLException
    {
        try
        {
            st = connection.createStatement();
            st.executeUpdate(query);
        }
        catch(Exception e)
        {
            System.out.println("Errore nella query");
            e.printStackTrace();
            connection.close();

            return false;
        }

        return true;
    }

    public ResultSet buildPersonnelTable(String username) throws SQLException
    {
        ResultSet table;
        String query;
        int farmacia = -1;

        //prende idFarmacia per trovare la farmacia associata al mio username
        query = "SELECT idFarmacia FROM Operatori WHERE username = '" + username + "'";
        table = getTable(query);

        while(table.next())
            farmacia = table.getInt("idFarmacia");

        //prende tutti gli altri operatori della stessa farmacia
        query = "SELECT * FROM Operatori WHERE idFarmacia = " + farmacia;
        table = getTable(query);

        return table;
    }

    public ResultSet buildWarehouseTable(String username) throws SQLException
    {
        ResultSet table;
        String query;
        int farmacia = -1;

        //prende idFarmacia per trovare la farmacia associata al mio username
        query = "SELECT idFarmacia FROM Operatori WHERE username = '" + username + "'";
        table = getTable(query);

        while(table.next())
            farmacia = table.getInt("idFarmacia");

        //prende tutti i prodotti della farmacia
        query = "select prodotti.codProdotto, prodotti.nome, prodotti.prezzo, prodotti.descrizione, prodotti.immagine, magazzino.quantitaDisponibile, prodotti.conRicetta "
                + "from operatori join farmacie on operatori.idFarmacia = farmacie.id "
                + "join magazzino on farmacie.id = magazzino.idFarmacia "
                + "join prodotti on magazzino.codProdotto = prodotti.codprodotto "
                + "where operatori.username = '" + username + "'";

        table = getTable(query);

        return table;
    }

    public ResultSet buildAllOperatorsTable() throws SQLException
    {
        ResultSet table;
        String query;

        //prende tutti gli operatori di tutte le farmacie
        query = "SELECT cf from Operatori";

        return getTable(query);
    }

    public ResultSet buildNewMailTable(String role, String username) throws SQLException
    {
        ResultSet table;
        String query;
        int farmacia = -1, deleteRow = 0;

        if(role.toLowerCase().equals("reg"))
        {
            //prende tutti i nomi delle farmacie
            query = "SELECT nome AS username from Farmacie";
        }
        else
        {
            //prende idFarmacia per trovare la farmacia associata al mio username
            query = "SELECT idFarmacia FROM Operatori WHERE username = '" + username + "'";
            table = getTable(query);

            while(table.next())
                farmacia = table.getInt("idFarmacia");

            //prende tutti gli username degli operatori della stessa farmacia
            query = "SELECT username from Operatori WHERE idFarmacia = " + farmacia;
        }

/*      IMPLEMENTATO IN newMail.jsp


        //rimuove username del mittente dai possibili destinatari
        table = getTable(query);
        while(table.next())
        {
            deleteRow++;
            if(table.getString("username").equals(username))
                break;
        }

        table.absolute(deleteRow);
        table.deleteRow();
        //se si tratta di un pers, aggiunge username della farmacia
        table.moveToInsertRow();
        table.updateString("username",Configurations.REG_USERNAME);
        table.insertRow();
        //poi rimette a posto la tabella
        table.absolute(1);
*/

        return getTable(query);
    }

    public ResultSet buildSentMailTable(String role, String username) throws SQLException
    {
        ResultSet table;
        String query;

        if (role.toLowerCase().equals("reg"))
            query = "SELECT toReg, toOp, msg, oggetto, dt_invio FROM Messaggi WHERE fromReg = '" + username + "'";
        else
            query = "SELECT toReg, toOp, msg, oggetto, dt_invio FROM Messaggi WHERE fromOp = '" + username + "'";

        return getTable(query);
    }

    public ResultSet buildInboxMailTable(String role, String username) throws SQLException
    {
        ResultSet table;
        String query;

        if (role.toLowerCase().equals("reg"))
            query = "SELECT fromReg, fromOp, msg, oggetto, dt_invio FROM Messaggi WHERE toReg = '" + username + "'";
        else
            query = "SELECT fromReg, fromOp, msg, oggetto, dt_invio FROM Messaggi WHERE toOp = '" + username + "'";

        return getTable(query);
    }
}