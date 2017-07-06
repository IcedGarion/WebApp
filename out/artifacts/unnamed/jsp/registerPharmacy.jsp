<%@ page import="util.loginCheck" %>
<%@ page import="Beans.LoginBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/validationRegisters.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">

    <%
        if(! (loginCheck.check((LoginBean) session.getAttribute("RegisterBean"), request, "reg").equals("LOGIN_OK")))
        {
    %>

            <!-- redirect verso pagina di errore -->
            <script type="text/javascript">
                window.location.replace('error.jsp');
            </script>
    <%
        }
    %>

    <title>REGISTRA NUOVA FARMACIA</title>
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
        <h2>registra nuova farmacia</h2>
    </div>

    <div class = "forms">
            <h4>Dati Titolare Farmacia: </h4>
            <form action="<%=request.getContextPath()%>/registerPharmacy.do" method="post" name="form" onsubmit="return validatePharmacyForm()">
                Nome Titolare<br> <input type="text" name="nome" id="nome" required>
                Cognome Titolare<br> <input type="text" name="cognome" id="cognome" required>
                Codice Fiscale<br><input type="text" name="cf" id="cf" required>
                Username Titolare<br><input type="text" name="username" id="username" required>
                Password<br><input type="password" name="password" id="password" required>
                Conferma Password<br><input type="password" name="passwordConfirm" id="passwordConfirm" required>
                Data di Nascita (gg-mm-aaaa)<br><input type="text" name="dataNascita" id="dataNascita">
                <br>
                <h4>Dati Farmacia</h4>
                Nome Farmacia<br><input type="text" name="nomeF" id="nomeF" required>
                Indirizzo<br><input type="text" name="indirizzo" id="indirizzo" required>
                Numero di Telefono<br><input type="text" name="telefono" id="telefono" required>
                <br>
                <input type="submit" value="REGISTRA">
            </form>
    </div>


    <div id = "push"></div>
</div> <!-- wrapper-->
<div id = "footer">
    <h6>Creato da Garion Musetta @2017</h6>
</div>
</body>
</html>