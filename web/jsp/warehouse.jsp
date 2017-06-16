<%@ page import="util.loginCheck" %>
<%@ page import="Beans.LoginBean" %>
<%@ page import="util.TableReader" %>
<%@ page import="java.sql.ResultSet" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <link href="<%=request.getContextPath()%>/css/bootstrap.css" rel="stylesheet" type="text/css">

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

    <% String role = (String) request.getSession().getAttribute("role"); %>

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
            <th>Prezzo</th>
            <th>Quantita' Disponibile</th>
            <th>Necessaria ricetta</th>
            <!-- <th>Immagine</th> -->
            <%
                if(role.toLowerCase().equals("tf"))
                { %>
                    <th>Quantita' da ordinare</th>
                    <th>EFFETTUA ORDINE</th>
                <% }
            %>
        </tr>
        <%

            TableReader reader = new TableReader();
            LoginBean bean = ((LoginBean) session.getAttribute("RegisterBean"));

            ResultSet table = reader.buildWarehouseTable(bean.getUsername());

            while(table.next())
            {
              %><tr>
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
                <%
                    if(role.toLowerCase().equals("tf"))
                    { %>
                        <form action="<%=request.getContextPath()%>/refillWarehouse.do" method="post" name="form">
                        <td>
                        <select name="quantita" id="quantita" required="required">
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="10">10</option>
                            <option value="20">20</option>
                            <option value="50">50</option>
                        </select>
                        </td>
                        <td>
                            <input type="submit" value="ORDINA PRODOTTO">
                            <input type="text" name="productName" id="productName" value="<%= table.getString("nome") %>"
                              style="visibility:hidden">
                        </td>
                        </form>
                    <% }
                %>
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
    </div> <!--footer -->
</div> <!-- container -->
</body>
</html>
