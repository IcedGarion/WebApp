<%@ page import="Beans.LoginBean" %>
<%@ page import="util.TableReader" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="util.loginCheck" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/validationRegisters.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">

    <%
        if(! (loginCheck.check((LoginBean) session.getAttribute("RegisterBean"), request, "pers").equals("LOGIN_OK")))
        {
    %>

            <!-- redirect verso pagina di errore -->
            <script type="text/javascript">
                location.replace('<%=request.getContextPath()%>/jsp/error.jsp');
            </script>
    <%
        }
    %>
    <title>MAGAZZINO</title>
    <% String role = (String) request.getSession().getAttribute("role"); %>
</head>
<body>

<div class="wrapper style1">
    <div id="header">
        <div class="container">
            <nav id="nav">
                <jsp:include page="../util/bar.jsp"/>
            </nav>
        </div>
    </div>
    <div id="banner">
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
    </div>

            <table>
                <tr>
                    <th>Nome Prodotto</th>
                    <th>Descrizione</th>
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
                    try
                    {
                        TableReader reader = new TableReader();
                        LoginBean bean = ((LoginBean) session.getAttribute("RegisterBean"));

                        ResultSet table = reader.buildWarehouseTable(bean.getUsername());

                        while(table.next())
                        {
                %><tr>
                <td><%= table.getString("nome") %></td>
                <td><%= table.getString("descrizione") %></td>
                <td><%= table.getString("quantitaDisponibile") %></td>
                <td><%= table.getBoolean("conRicetta") %></td><%
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
                }
                catch(Exception e)
                {}
                %>
            </table>


    <div id = "push"></div>
</div> <!-- wrapper -->
<div id = "footer">
    <h6>Creato da Garion Musetta _ Tutti i diritti sono riservati @2017</h6>
</div>
</body>
</html>