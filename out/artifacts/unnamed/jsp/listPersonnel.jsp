<%@ page import="Beans.LoginBean" %>
<%@ page import="util.TableReader" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="util.loginCheck" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/validation.js"></script>
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
    %>

    <title>LISTA PERSONALE</title>
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
        <h2>Lista personale</h2>
    </div>
    <table style="width:100%">
            <tr>
                <th>Nome</th>
                <th>Cognome</th>
                <th>Username</th>
                <th>Ruolo</th>
                <th>Codice Fiscale</th>
                <th>Data di nascita</th>
            </tr>
            <%
                try
                {
                TableReader reader = new TableReader();
                ResultSet table = reader.buildPersonnelTable(((LoginBean) session.getAttribute("RegisterBean")).getUsername());

                while(table.next())
                {
            %><tr>
            <td><%= table.getString("nome") %></td>
            <td><%= table.getString("cognome") %></td>
            <td><%= table.getString("username") %></td>
            <td><%= table.getString("ruolo").toUpperCase() %></td>
            <td><%= table.getString("cf") %></td>
            <td><%= table.getString("datanascita") %></td>
        </tr>
            <%}
            }
            catch(Exception e)
            {}
            %>
    </table>

    <div id= "footer">
        <h6>Creato da Garion Musetta _ Tutti i diritti sono riservati @2017</h6>
    </div>
</div>
</body>
</html>

