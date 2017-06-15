package Actions;

import Beans.LoginBean;
import Beans.ProductBean;
import Beans.RecipeBean;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import sessionObjs.PurchaseObj;
import sessionObjs.Recipe;
import util.TableReader;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;

public class AddToCart extends Action
{
    /*
      in pratica: per prima cosa controlla se la action è stata richiamata da purchase o da recipe.jsp:
      nel secondo caso, oggetto in session sarà != null perchè serviva la ricetta. (spiegato dopo)

      Se è la prima volta: Recipe sarà null quindi cerca se serve la ricetta per il prodotto: se no,
      continua lineare fino a fine acquisto. Se invece serve la ricetta, salva in session oggetto Recipe
      con i dati del prodotto (codProdotto e qty, perchè poi il bean cambia - VEDI SOTTO). Poi chiama recipe.jsp che ha il form
      Recipe.jsp poi ha la action collegata di nuovo a qua, quindi rientra dall'inizio ma vede che oggetto Recipe != null!

      Allora se Recipe != null vuol dire che questo file è stato chiamato in seguito al form della Ricetta:
      quindi salta il primo passaggio di controllo del farmaco con/senza ricetta (tanto so già che serve ricetta e ho
      già anche tutti i dati) e continua normalmente con l'acquisto. QUando arriva alla fine, inserisce in db anche i dati
      relativi a ricetta/medici/pazienti o quello che è: dati raccolti dalla Recipe.jsp e passati tramite form bean
      a questa action (che dovrà comunque processare).
      (Quindi questa action riceve 2 form bean diversi a seconda di chi l'ha chiamata)
     */

    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception
    {
        //non basta: bisogna distinguere! Una volta productBean, una volta RecipeBean
        RecipeBean recBean;
        ProductBean prodBean;
        boolean conRicetta = true;
        String query, username, cf = "", codProdotto = "", role = "";
        Recipe ricetta;
        int oldQty = -1, qty = 0, codAcquisto = -1, idFarmacia = -1;
        ResultSet table;
        TableReader reader = new TableReader();
        PurchaseObj acquisto = (PurchaseObj) request.getSession().getAttribute("cart");
        Date date = new Date();
        SimpleDateFormat sf = new SimpleDateFormat("yyyy.MM.dd");
        float total = 0;

        try
        {
            //per prima cosa controlla se è stato chiamato dopo inserimento ricetta (e quindi ha già dei dati)
            ricetta = (Recipe) request.getSession().getAttribute("ricetta");

            if(ricetta == null)
            {
                //se sono qua mi ha chiamato purchase.jsp, quindi ho un bean ProductBean
                prodBean = (ProductBean) form;

                //controlla se serve ricetta e se si hanno i ruoli giusti
                codProdotto = prodBean.getProductName();
                qty = Integer.parseInt(prodBean.getQty());
                query = "SELECT conRicetta FROM Prodotti WHERE codProdotto = '" + codProdotto + "'";
                table = reader.getTable(query);

                while (table.next())
                    conRicetta = table.getBoolean("conRicetta");

                role = (String) request.getSession().getAttribute("role");

                if(conRicetta)
                {
                    //OB non possono vendere i prodotti con ricetta
                    if (role.toLowerCase().equals("ob"))
                    {
                        request.getSession().setAttribute("msg", "OPERATORE DI BANCO NON PUO' VENDERE UN PRODOTTO CON RICETTA!");
                        return mapping.findForward("ADD_OK");
                    }
                    //rimanda ad una pagina con form ricetta/pazienti/medici
                    else
                    {
                        //si passa codProdotto e quantità, così il form della ricetta non deve chiedere di nuovo
                        request.getSession().setAttribute("ricetta", new Recipe(codProdotto, qty));
                        return mapping.findForward("NEED_RECIPE");
                    }
                }
            }
            //altrimenti questa è la seconda volta che mi chiamano, ho già i dati della ricetta ma non ho più in bean Prodotto
            //quindi mi ero salvato prima i suoi dati in oggetto Recipe (ricetta)
            else
            {
                //se sono qua mi ha chiamato recipe.jsp e quindi ho un bean RecipeBean
                recBean = (RecipeBean) form;
                codProdotto = ricetta.getCodProdotto();
                qty = ricetta.getQty();
            }
            //arriva qua solo se il farmaco non era con ricetta, o se è già stato processato il form ricetta
            //e quindi questa action è stata richiamata

            //l'acquisto non è ancora stato creato: (non c'è oggetto PurchaseObj in session)
            //allora questo è il primo prodotto e lo crea lui
            if (acquisto == null)
            {
                //recupera CF e idFamacia da username
                username = ((LoginBean) request.getSession().getAttribute("RegisterBean")).getUsername();
                query = "SELECT cf, idFarmacia FROM Operatori WHERE username = '" + username + "'";
                table = reader.getTable(query);

                while (table.next())
                {
                    cf = table.getString("cf");
                    idFarmacia = table.getInt("idFarmacia");
                }

                //insert nuovo acquisto
                query = "INSERT INTO acquisti(cfoperatore, totale, data) " +
                        "VALUES ('" + cf + "', 0, '" + sf.format(date) + "')";
                reader.update(query);

                //salva in session l'oggetto PurchaseObj a indicare che è stato aperto un acquisto (un "carrello")
                //con i dati appena inseriti
                acquisto = new PurchaseObj(cf, date, idFarmacia);
                request.getSession().setAttribute("cart", acquisto);
            }
            //altrimenti è già stato aggiunto qualche prodotto e quindi l'acquisto esiste in session
            else
            {
                cf = acquisto.getCfOp();
                date = acquisto.getDate();
                idFarmacia = acquisto.getIdFarmacia();
            }

            //recupera il codice dell'acquisto corrente
            query = "SELECT codAcquisto FROM acquisti WHERE cfOperatore = '" + cf + "' AND totale = 0 AND data = '" + sf.format(date) + "'";
            table = reader.getTable(query);

            while (table.next())
                codAcquisto = table.getInt("codAcquisto");

            //controlla se la quantità immessa è disponibile
            query = "SELECT quantitadisponibile FROM magazzino WHERE idFarmacia = " + idFarmacia +
                    " AND codProdotto = '" + codProdotto + "'";
            table = reader.getTable(query);

            while (table.next())
                oldQty = table.getInt("quantitadisponibile");

            if(oldQty < qty)
            {
                request.getSession().setAttribute("msg", "DISPONIBILITÀ SUPERATA!");
                return mapping.findForward("ADD_OK");
            }

            //insert nuovo carrello prodotto collegato all'acquisto
            query = "INSERT INTO carrello (codprodotto, quantita, codacquisto)" +
                    " VALUES ('" + codProdotto + "', " + qty + ", " + codAcquisto + ");";
            reader.update(query);


            //calcola e aggiorna totale acquisto
            query = "SELECT prezzo FROM Prodotti WHERE codProdotto = '" + codProdotto + "'";
            table = reader.getTable(query);
            while (table.next())
                total = table.getFloat("quantitadisponibile");
            total = total * qty;

            query = "UPDATE Acquisti SET totale = " + total + " WHERE codAcquisto = '" + codAcquisto + "'";
            reader.update(query);


            //inserisce anche tutte le informazioni sulla ricetta, i medici, i pazienti.... che arrivano dal form e che ora sono
            //nel bean RecipeBean
            if(ricetta != null)
            {
                recBean = (RecipeBean) form;
                String cfPaz, nome, cognome, dataNascita, codReg;
                int conta = 0;

                //recupera dati dal form di recipe.jsp
                cfPaz = recBean.getCfPaz();
                nome = recBean.getNomePaz();
                cognome = recBean.getCognomePaz();
                dataNascita = recBean.getDataNascitaPaz();
                codReg = recBean.getCodRegMed();

                //cerca se paziente c'è già
                query = "SELECT * FROM Pazienti WHERE cf = '" + cfPaz + "'";
                reader.getTable(query);
                while (table.next() && (conta == 0))
                    conta++;

                //se non è presente, deve inserire il nuovo paziente
                if(conta == 0)
                {
                    query = "INSERT INTO pazienti(cf, codacquisto, nome, cognome, datanascita)" +
                            " VALUES ('" + cfPaz + "', " + codAcquisto + ", '" + nome + "', '" + cognome + "', '" + dataNascita + "')";
                    reader.update(query);
                }

                //inserisce dati della Ricetta (come codice usa codacquisto+codregionale)
                query = "INSERT INTO ricette(codricetta, codacquisto, codregionale, data)"+
                        " VALUES ('" + (codAcquisto + "," + codReg) +"', '" + codAcquisto +"', " + codReg + ", '" + sf.format(date) + "')";
                reader.update(query);

            }


            //aggiorna le quantità in magazzino
            query = "UPDATE magazzino SET quantitadisponibile = " + (oldQty - qty) +
                    " WHERE idFarmacia = " + idFarmacia + " AND codProdotto = '" + codProdotto + "'";
            reader.update(query);

        }
        catch(Exception e)
        {
            e.printStackTrace();


            //se fallisce qualcosa dovrebbe rimettere a posto le quantità nel magazzino, oltre a cancellare
            //acquisto e carrello!
            if(oldQty != -1)
            {

            }

            query = cancella carrello/i collegati all'acquisto codAcquisto;
            reader.update(query);

            query = cancella acquisto codAcquisto;
            reader.update(query);

            request.getSession().setAttribute("msg", "ERRORE");
            return mapping.findForward("ERROR");
        }

        request.getSession().setAttribute("msg", "PRODOTTO AGGIUNTO AL CARRELLO");
        return mapping.findForward("ADD_OK");
    }
}
