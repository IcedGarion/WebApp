<%@ page import="util.loginCheck" %>
<%@ page import="Beans.LoginBean" %>
<%@ page import="util.TableReader" %>
<%@ page import="java.sql.ResultSet" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>MAGAZZINO</title>

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
    %>
</head>
<body>
<div id="container">
    <div id="header">

        <%
            if(((String) request.getSession().getAttribute("role")).toLowerCase().equals("tf"))
            { %>
                <h2>GESTIONE MAGAZZINO</h2>
            <%}
            else
            { %>
                <h2>ELENCO PRODOTTI MAGAZZINO</h2>
            <%}
        %>

    </div> <!-- header -->
    <div id="body">
    </div> <!-- body -->

    <table style="width:100%">
        <tr>
            <th>Nome Prodotto</th>
            <th>Descrizione</th>
            <th>Quantita' Disponibile</th>
        </tr>
        <%
            TableReader reader = new TableReader();
            ResultSet table = reader.buildWarehouseTable(((LoginBean) session.getAttribute("RegisterBean")).getUsername());


            //DA AGGIUNGERE BOTTONE AGGIUNGI PER IL TITOLARE!


            while(table.next())
            {
        %><tr>
        <td><%= table.getString("nome") %></td>
        <td><%= table.getString("descrizione") %></td>
        <td><%= table.getString("quantitaDisponibile") %></td>
        <!-- <td>table.getPicture("immagine").toUpperCase() %></td> -->
    </tr>
        <%}
        %>
    </table>

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
