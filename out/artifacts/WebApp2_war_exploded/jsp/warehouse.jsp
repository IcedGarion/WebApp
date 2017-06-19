<%@ page import="Beans.LoginBean" %>
<%@ page import="util.TableReader" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="util.loginCheck" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
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
<div id="container">
    <div id="header">

        <%
            if(((String) request.getSession().getAttribute("role")).toLowerCase().equals("tf"))
            { %>
        <h1>GESTIONE MAGAZZINO</h1>
        <%}
        else
        { %>
        <h1>ELENCO PRODOTTI MAGAZZINO</h1>
        <%}
        %>

    </div> <!-- header -->

    <div id="cont">
        <div id="left" class="left">
            <jsp:include page="../util/sidebar.jsp"/>
        </div> <!-- left -->
        <div id="body" class="right">
            <table style="width:100%">
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
                <td><%= table.getBoolean("conRicetta") %></td>
                <!-- Noe-> fossi in te eviterei di far processare immagini a java, io l'ho tolto-->
                <!-- <td>table.getPicture("immagine").toUpperCase() %></td> -->
                <%
                    if(role.toLowerCase().equals("tf"))
                    { %>
                <form action="<%=request.getContextPath()%>/refillWarehouse.do" method="post" name="form">
                    <td>
                        <!-- Noe-> potresti usare <input type=number name=quantita min=1 max=50-->
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
        </div> <!-- body -->

        <div class="clear"/>
    </div>

    <div id= "footer">
        <script>
            $("#footer").load("../util/footer.html");
        </script>
    </div> <!--footer-->
</div> <!-- container -->
</body>
</html>