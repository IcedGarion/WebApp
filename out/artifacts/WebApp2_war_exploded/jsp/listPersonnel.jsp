<%@ page import="util.loginCheck" %>
<%@ page import="Beans.LoginBean" %>
<%@ page import="util.TableReader" %>
<%@ page import="java.sql.ResultSet" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <link href="<%=request.getContextPath()%>/css/bootstrap.css" rel="stylesheet" type="text/css">

    <title>LISTA PERSONALE</title>

    <!-- in ogni pagina controlla prima che si è loggati -->
    <%
        if(! (loginCheck.check((LoginBean) session.getAttribute("RegisterBean"), request, "tf").equals("LOGIN_OK")))
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
        <h2>ELENCO PERSONALE FARMACIA</h2>
    </div> <!-- header -->
    <div id="body">
        <table style="width:100%">
            <tr>
                <th>Nome</th>
                <th>Cognome</th>
                <th>Username</th>
                <th>Ruolo</th>
                <th>Codice Fiscale</th>
                <th>Data di nascita</th>
                <th>Codice Regionale</th>
            </tr>
            <%
                TableReader reader = new TableReader();
                ResultSet table = reader.buildPersonnelTable(((LoginBean) session.getAttribute("RegisterBean")).getUsername());

                while(table.next())
                {
                    %><tr>
                    <td><%= table.getString("nome") %></td>
                    <td><%= table.getString("cognome") %></td>
                    <td><%= table.getString("username") %></td>
                    <td><%= table.getString("ruolo").toUpperCase() %></td>
                    <td><%= table.getString("productName") %></td>
                    <td><%= table.getString("datanascita") %></td>
                    <td><%= table.getString("codregionale") %></td>
                    </tr>
                <%}
            %>
        </table>
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
