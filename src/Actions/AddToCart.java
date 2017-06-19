package Actions;

import Beans.LoginBean;
import Beans.ProductBean;
import Beans.RecipeBean;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import sessionObjs.CodPurchase;
import sessionObjs.OriginalQuantity;
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
        String query, username, cf = "", codProdotto = "", role = "", acquistoDate = "";
        Recipe ricetta;
        int oldQty = -1, qty = 0, codAcquisto = -1, idFarmacia = -1, idCarrello = -1;
        ResultSet table;
        TableReader reader = new TableReader();
        PurchaseObj acquisto = (PurchaseObj) request.getSession().getAttribute("cart");
        Date date = new Date();
        SimpleDateFormat recipeDateFormatter = new SimpleDateFormat("dd-MM-yyyy");
        SimpleDateFormat todaysDateFormatter = new SimpleDateFormat("dd-MM-yyyy kk:mm:ss");
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

                /*"VALIDAZIONE" QUANTITA... (in javascript non funziona)*/
                try
                {
                    qty = Integer.parseInt(prodBean.getQty());
                }
                catch(Exception e)
                {
                    request.getSession().setAttribute("msg", "QUANTITA' INSERITA NON CORRETTA");
                    return mapping.findForward("ADD_OK");
                }
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
                acquistoDate = todaysDateFormatter.format(date);
                query = "INSERT INTO acquisti(cfoperatore, totale, data, completato) " +
                        "VALUES ('" + cf + "', 0, '" + acquistoDate + "', false)";
                reader.update(query);

                //salva in session l'oggetto PurchaseObj a indicare che è stato aperto un acquisto (un "carrello")
                //con i dati appena inseriti
                acquisto = new PurchaseObj(cf, acquistoDate, idFarmacia);
                request.getSession().setAttribute("cart", acquisto);
            }
            //altrimenti è già stato aggiunto qualche prodotto e quindi l'acquisto esiste in session
            else
            {
                cf = acquisto.getCfOp();
                acquistoDate = acquisto.getFormatDate();
                idFarmacia = acquisto.getIdFarmacia();
            }

            //recupera il codice dell'acquisto corrente
            query = "SELECT codAcquisto FROM acquisti WHERE cfOperatore = '" + cf + "' AND data = '" + acquistoDate + "'";
            table = reader.getTable(query);

            while (table.next())
                codAcquisto = table.getInt("codAcquisto");

            //salva in session codAcquisti per il checkout
            request.getSession().setAttribute("codAcquisto", new CodPurchase(codAcquisto));

            //controlla se la quantità immessa è disponibile
            if(request.getSession().getAttribute("quantity") == null)
            {
                //se è sempre lo stesso acquisto potrebbe subire modifiche: si salva la prima quantità che legge
                query = "SELECT quantitadisponibile FROM magazzino WHERE idFarmacia = " + idFarmacia +
                        " AND codProdotto = '" + codProdotto + "'";
                table = reader.getTable(query);

                while (table.next())
                    oldQty = table.getInt("quantitadisponibile");

                request.getSession().setAttribute("quantity", new OriginalQuantity(oldQty));
            }
            else
            {
                //se l'acquisto era già iniziato, recupera quantità originale dall'oggetto salvato
                oldQty = ((OriginalQuantity) request.getSession().getAttribute("quantity")).getQty();
            }
            //solo a fine acquisto l'oggetto verrà distrutto


            if(oldQty < qty)
            {
                request.getSession().setAttribute("msg", "DISPONIBILITÀ SUPERATA!");
                return mapping.findForward("ADD_OK");
            }

            //insert nuovo carrello prodotto collegato all'acquisto
            query = "INSERT INTO carrello (codprodotto, quantita, codacquisto)" +
                    " VALUES ('" + codProdotto + "', " + qty + ", " + codAcquisto + ");";
            reader.update(query);

            //salva id Carrello (serial) appena aggiunto
            query = "SELECT id FROM Carrello WHERE codprodotto = '" + codProdotto + "' AND"
                    + " quantita = " + qty + " AND codacquisto = " + codAcquisto;
            table = reader.getTable(query);
            while (table.next())
                idCarrello = table.getInt("id");


            //calcola e aggiorna totale acquisto
            query = "SELECT prezzo FROM Prodotti WHERE codProdotto = '" + codProdotto + "'";
            table = reader.getTable(query);
            while (table.next())
                total = table.getFloat("prezzo");
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

                //inserisce dati della Ricetta (come codice usa codacquisto+codregionale)
                query = "INSERT INTO ricette(codricetta, idCarrello, codregionale, data)"+
                        " VALUES ('" + (codAcquisto + "," + codReg + recipeDateFormatter.format(date)) +"', '" + idCarrello +"', '" + codReg + "', '" + todaysDateFormatter.format(date) + "')";

                if(! reader.update(query))
                {
                    request.getSession().setAttribute("msg", "MEDICO NON TROVATO! ");
                    revertChanges(request, cf, idFarmacia, codProdotto, codAcquisto, oldQty);
                    return mapping.findForward("ADD_OK");
                }

                //cerca se paziente c'è già
                query = "SELECT * FROM Pazienti WHERE cf = '" + cfPaz + "'";
                table = reader.getTable(query);
                while (table.next())
                    conta++;

                //se non è presente, deve inserire il nuovo paziente
                if(conta == 0)
                {
                    query = "INSERT INTO pazienti(cf, codacquisto, nome, cognome, datanascita)" +
                            " VALUES ('" + cfPaz + "', " + codAcquisto + ", '" + nome + "', '" + cognome + "', '" + dataNascita + "')";
                    reader.update(query);
                }

                //rimuove oggetto in session: non serve più
                request.getSession().removeAttribute("ricetta");
            }


            //aggiorna le quantità in magazzino
            query = "UPDATE magazzino SET quantitadisponibile = " + (oldQty - qty) +
                    " WHERE idFarmacia = " + idFarmacia + " AND codProdotto = '" + codProdotto + "'";
            reader.update(query);

        }
        catch(Exception e)
        {
            e.printStackTrace();

            revertChanges(request, cf, idFarmacia, codProdotto, codAcquisto, oldQty);

            request.getSession().setAttribute("exitCode", "ERRORE AGGIUNTA AL CARRELLO");
            return mapping.findForward("ERROR");
        }

        request.getSession().setAttribute("msg", "PRODOTTO AGGIUNTO AL CARRELLO");
        return mapping.findForward("ADD_OK");
    }

    private static void revertChanges(HttpServletRequest request, String cf, int idFarmacia, String codProdotto, int codAcquisto, int oldQty)
    {
        String query;
        TableReader reader;

        try
        {
            reader = new TableReader();
            //se fallisce qualcosa dovrebbe rimettere a posto le quantità nel magazzino, oltre a cancellare
            //acquisto e carrello!
            if (oldQty != -1)
            {
                //se è arrivato a modificare le quantità ma poi c'è stata eccezione, ripristina quantità iniziale
                query = "UPDATE magazzino SET quantitadisponibile = " + oldQty +
                        " WHERE idFarmacia = " + idFarmacia + " AND codProdotto = '" + codProdotto + "'";
                reader.update(query);
            }

            //cancella il carrello collegato all'acquisto
            query = "DELETE FROM Carrello WHERE codAcquisto = " + codAcquisto;
            reader.update(query);


            //cancella l'acquisto dell'operatore, solo se non ha già inserito paziente
            if(request.getSession().getAttribute("ricetta") == null)
            {
                query = "DELETE FROM Acquisti WHERE cfOperatore = '" + cf + "'";
                reader.update(query);
            }

            //rimuove oggetti in session: non servono più perchèbisogna rifare tutto daccapo
            request.getSession().removeAttribute("ricetta");
            request.getSession().removeAttribute("cart");
            request.getSession().removeAttribute("quantity");
        }
        catch(Exception e)
        {}
    }

}
