<%@ page import="util.loginCheck" %>
<%@ page import="Beans.LoginBean" %>
<%@ page import="util.TableReader" %>
<%@ page import="java.sql.ResultSet" %>

<!-- Tanti form quante le righe di prodotti. come in magazzino, bottone aggiungi aggiunge il prodotto, con relativa qtà,
    al "carrello" (un oggetto in session). Alla fine c'è un bottone "PROCEDI" (che non sta per forza in un form)
    che chiama la action (senza neanche il bean), la quale legge dal carrello
    ultima azione (checkout) elimina carrello da session-->


<!-- Poi magari compatta tutto in categorie (antidolorifico, antinfiammatorio....)
    che se le schiacci spawnano i prodotti che contiene -->

<!-- Poi magari all'inizio c'è una casella di ricerca per nome -->

<!-- VALIDAZIONE! -->

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">

    <%
        if(! (loginCheck.check((LoginBean) session.getAttribute("RegisterBean"), request, "pers").equals("LOGIN_OK")))
        {
    %>

    <!-- redirect verso pagina di errore -->
    <script type="text/javascript">
        window.location.replace('error.jsp');
    </script>
    <%
        }

        //rimuove oggetto parziale coi dati del prodotto, usato in addToCart.java
        //combinato col js sotto
        request.getSession().removeAttribute("ricetta");
    %>
    <!-- forza la pagina a ricaricare se schiacciato il bottone indietro -->
    <script type="text/javascript">
        if (!!window.performance && window.performance.navigation.type === 2)
        {
            // value 2 means "The page was accessed by navigating into the history"
            console.log('Reloading');
            window.location.reload(); // reload whole page
        }
    </script>

    <title>ACQUISTO</title>
</head>
<<body onunload="">

<div class="wrapper style1">
    <div id="header">
        <div class="container">
            <nav id="nav">
                <jsp:include page="../util/bar.jsp"/>
            </nav>
        </div>
    </div>
    <div id="banner">
        <h2>nuovo acquisto</h2>
    </div>

            <table>
                <tr>
                    <th>Nome Prodotto</th>
                    <th>Descrizione</th>
                    <th>Prezzo</th>
                    <th>Quantita' Disponibile</th>
                    <th>Necessaria ricetta</th>
                    <!-- <th>Immagine</th> -->
                    <th>Quantita' da acquistare</th>
                    <th> </th>
                </tr>

                <%
                    try
                    {
                    TableReader reader = new TableReader();
                    ResultSet table = reader.buildWarehouseTable(((LoginBean) session.getAttribute("RegisterBean")).getUsername());

                    while(table.next())
                    { %>
                <tr>
                    <td><%= table.getString("nome") %></td>
                    <td><%= table.getString("descrizione") %></td>
                    <td><%= table.getString("prezzo") %></td>
                    <td><%= table.getString("quantitaDisponibile") %></td>
                    <td>
                        <% if(table.getBoolean("conRicetta"))
                        {%>
                        SI
                        <%}
                        else
                        {%>
                        NO
                        <%}
                        %>
                    </td>

                    <!-- <td>table.getPicture("immagine").toUpperCase() %></td> -->

                    <form action="<%=request.getContextPath()%>/addToCart.do" method="post" name="form">
                        <td>
                            <input class="qty" type = "text" name = "qty" id ="qty" required value="1"> pezzi<br>
                        </td>
                        <td>
                            <input type="text" name="productName" id="productName" value="<%= table.getString("codProdotto") %>"
                                   style="visibility:hidden">
                            <input id="small" type="submit" value="AGGIUNGI AL CARRELLO">
                        </td>
                    </form>
                </tr>
                <% }
                }catch (Exception e)
                {}
                %>
            </table>

            <br>
            <form action="<%=request.getContextPath()%>/checkout.do" method="post" name="form">
                <input type ="submit" value="PROCEDI ALL'ACQUISTO">
            </form>

        </div> <!-- body -->
        <div class="clear"/>
    </div>



    <footer id= "footer">
        <h6>Creato da Garion Musetta _ Tutti i diritti sono riservati @2017</h6>
    </footer> <!--footer-->
</div> <!-- container -->

<%

    String msg = (String) request.getSession().getAttribute("msg");

    if(msg != null)
    {%>
        <script>
            alert("<%= msg %>");
        </script>
    <%
        request.getSession().removeAttribute("msg");
    }%>

</body>
</html>
