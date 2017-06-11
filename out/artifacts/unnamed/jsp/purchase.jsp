<%@ page import="util.loginCheck" %>
<%@ page import="Beans.LoginBean" %>
<%@ page import="util.TableReader" %>
<%@ page import="java.sql.ResultSet" %>

<!-- Tanti form quante le righe di prodotti. come in magazzino, bottone aggiungu aggiunge il prodotto, con relativa qtà,
    al "carrello" (un oggetto in session). Alla fine c'è un bottone "PROCEDI" (che non sta per forza in un form)
    che chiama la action (senza neanche il bean), la quale legge dal carrello
    ultima azione (checkout) elimina carrello da session-->


<!-- Poi magari compatta tutto in categorie (antidolorifico, antinfiammatorio....)
    che se le schiacci spawnano i prodotti che contiene -->

<!-- Poi magari all'inizio c'è una casella di ricerca per nome -->

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <link href="<%=request.getContextPath()%>/css/home.css" rel="stylesheet" type="text/css">

    <title>ACQUISTO</title>

    <!-- in ogni pagina controlla prima che si è loggati -->
    <%
        if(! (loginCheck.check((LoginBean) session.getAttribute("RegisterBean"), request, "pers").equals("LOGIN_OK")))
        {
            request.setAttribute("exitCode", "Login non effettuata");
    %>

         <!-- redirect verso pagina di errore -->
            <script type="text/javascript">
                window.location.replace('error.jsp');
            </script>
    <%
        }

        String role = (String) request.getSession().getAttribute("role");
    %>
</head>
<body>
<div id="container">
    <div id="header">
        <h2>NUOVO ACQUISTO</h2>
    </div> <!-- header -->
    <div id="body">

    <table>
        <tr>
            <th>Nome Prodotto</th>
            <th>Descrizione</th>
            <th class="short">Quantita' Disponibile</th>
            <th>Necessaria ricetta</th>
            <!-- <th>Immagine</th> -->
            <th class="short"class="last">Quantita' da acquistare</th>
            <th class="blank"> </th>
        </tr>

        <%
            TableReader reader = new TableReader();
            ResultSet table = reader.buildWarehouseTable(((LoginBean) session.getAttribute("RegisterBean")).getUsername());

            while(table.next())
            { %>
                <tr>
                    <td><%= table.getString("nome") %></td>
                    <td><%= table.getString("descrizione") %></td>
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
                        <input class="qty" type = "text" name = "qty" required value="1"> pezzi<br>
                    </td>
                    <td class="blank">
                        <input type="submit" value="ORDINA PRODOTTO">
                        <input type="text" name="productName" id="productName" value="<%= table.getString("nome") %>"
                               style="visibility:hidden">
                    </td>
                    </form>
                </tr>
            <% }  %>
    </table>

    <br>
        <form action="<%=request.getContextPath()%>/ProcessPurchase.do" method="post" name="form">
            <input type ="submit" value="PROCEDI ALL'ACQUISTO">
        </form>

    </div> <!-- body -->
    <div id="left">
        <ul>
            <li><a href="<%=request.getContextPath()%>/jsp/privateHome.jsp">HOME</a></li>
            <li><a href="<%=request.getContextPath()%>/jsp/account.jsp">ACCOUNT</a></li>
            <li><a href="<%=request.getContextPath()%>/jsp/mail.jsp">POSTA</a></li>
            <li><a href="<%=request.getContextPath()%>/jsp/logout.jsp">LOGOUT</a></li>
        </ul>
    </div> <!-- left -->

    <div id= "footer">
        <h6>footer</h6>
    </div> <!--footer-->
</div> <!-- container>
</body>
</html>
