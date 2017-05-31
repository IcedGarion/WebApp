<%@ page import="util.loginCheck" %>
<%@ page import="Beans.LoginBean" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>REGISTRA NUOVA FARMACIA</title>

    <!-- in ogni pagina controlla prima che si è loggati -->
    <%
        if(! (loginCheck.check((LoginBean) session.getAttribute("RegisterBean"), request, "reg").equals("LOGIN_OK")))
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
        <h2>REGISTRA NUOVA FARMACIA</h2>
    </div> <!-- header -->
    <div id="body">


        <!-- validazione input (tipo pass = pass) -->

        <h4>Dati Titolare Farmacia: </h4>
        <form action="/Progetto/registerPharmacy.do" method="post">
            <input type="text" name="cf">Codice Fiscale<br>
            <input type="text" name="username">Username Titolare<br>
            <input type="password" name="password">Password<br>
            <input type="password" name="passwordConfirm">Conferma Password<br>
            <input type="text" name="nome">Nome Titolare<br>
            <input type="text" name="cognome">Cognome Titolare<br>
            <input type="text" name="dataNascita">Data Nascita (gg-mm-aaaa)<br>
            <input type="text" name="codRegionale">Codice Regionale<br>
            <br>
            <h4>Dati Farmacia</h4>
            <input type="text" name="nomeF">Nome Farmacia<br>
            <input type="text" name="indirizzo">Indirizzp<br>
            <input type="text" name="telefono">Numero di Telefono<br>

            <input type="submit" value="REGISTRA">
        </form>
    </div> <!-- body -->
    <div id="left">
        <ul>
            <li><a href="privateHome.jsp">HOME</a></li>
            <li><a href="account.jsp">ACCOUNT</a></li>
            <li><a href="mail.jsp">POSTA</a></li>
            <li><a href="logout.jsp">LOGOUT</a></li>
        </ul>
    </div> <!-- left -->

    <div id= "footer">
        <h6>footer</h6>
    </div> <!--footer-->
</div> <!-- container>
</body>
</html>
