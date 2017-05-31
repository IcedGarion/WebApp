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

    <script type="text/javascript">
    function continueornot()
    {
        var cf = document.forms["form"]["cf"].value;
        var pass1 = document.forms["form"]["password"].value;
        var pass2 = document.forms["form"]["passwordConfirm"].value;
        var data = document.forms["form"]["dataNascita"].value;
        var tel = document.forms["form"]["telefono"].value;

        if (cf.length != 16)
        {
            alert("Codice Fiscale non valido!");
            //document.getElementById("cf").style.backgroundColor = "red";
            return false;
        }
        if(! (pass1 == pass2))
        {
            alert("Le password non corrispondono");
            //document.getElementById("password").style.backgroundColor = "red";
            //document.getElementById("passwordConfirm").style.backgroundColor = "red";
            return false;
        }

        return true;
    }
    </script>
</head>
<body>
<div id="container">
    <div id="header">
        <h2>REGISTRA NUOVA FARMACIA</h2>
    </div> <!-- header -->
    <div id="body">


        <!-- validazione input (tipo pass = pass) -->

        <h4>Dati Titolare Farmacia: </h4>
        <form action="/Progetto/registerPharmacy.do" method="post" name="form" onsubmit="return continueornot()">
            <input type="text" name="nome" required>Nome Titolare<br>
            <input type="text" name="cognome" required>Cognome Titolare<br>
            <input type="text" name="cf" required>Codice Fiscale<br>
            <input type="text" name="username" required>Username Titolare<br>
            <input type="password" name="password" required>Password<br>
            <input type="password" name="passwordConfirm" required>Conferma Password<br>
            <input type="text" name="dataNascita">Data Nascita (gg-mm-aaaa)<br>
            <input type="text" name="codRegionale" required>Codice Regionale<br>
            <br>
            <h4>Dati Farmacia</h4>
            <input type="text" name="nomeF" required>Nome Farmacia<br>
            <input type="text" name="indirizzo">Indirizzo<br>
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
