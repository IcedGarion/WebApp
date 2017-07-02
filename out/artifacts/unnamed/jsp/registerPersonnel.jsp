<%@ page import="util.loginCheck" %>
<%@ page import="Beans.LoginBean" %>
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
                window.location.replace('error.jsp');
            </script>
    <%
        }
    %>

    <title>RESISTRA NUOVO PERSONALE</title>
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
        <h2>registra nuovo collaboratore</h2>
    </div>
            <h4>Dati Operatore: </h4>
            <form action="<%=request.getContextPath()%>/registerPersonnel.do" method="post" name="form" onsubmit="return validatePersonnelForm()">
                <input type="text" name="nome" id="nome" required>Nome Operatore<br>
                <input type="text" name="cognome" id="cognome" required>Cognome Operatore<br>
                <input type="text" name="cf" id="cf" required>Codice Fiscale<br>
                <input type="text" name="username" id="username" required>Username<br>
                <input type="password" name="password" id="password" required>Password<br>
                <input type="password" name="passwordConfirm" id="passwordConfirm" required>Conferma Password<br>
                <input type="text" name="dataNascita" id="dataNascita">Data di Nascita (gg-mm-aaaa)<br>
                <input type="radio" name="role" value="df" checked="checked">Dottore Farmacista<br>
                <input type="radio" name="role" value="ob">Operatore di banco<br>
                <input type="submit" value="REGISTRA">
            </form>
    <div id= "footer">
        <h6>Creato da Garion Musetta _ Tutti i diritti sono riservati @2017</h6>
    </div> <!--footer-->
</div> <!-- container-->
</body>
</html>