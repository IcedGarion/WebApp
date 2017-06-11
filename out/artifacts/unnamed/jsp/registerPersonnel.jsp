<%@ page import="util.loginCheck" %>
<%@ page import="Beans.LoginBean" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <link href="<%=request.getContextPath()%>/css/bootstrap.css" rel="stylesheet" type="text/css">

    <title>RESISTRA NUOVO PERSONALE</title>

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

    <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/validation.js"></script>
</head>
<body>
<div id="container">
    <div id="header">
        <h2>REGISTRA NUOVO COLLABORATORE</h2>
    </div> <!-- header -->
    <div id="body">
        <h4>Dati Operatore: </h4>
        <form action="<%=request.getContextPath()%>/registerPersonnel.do" method="post" name="form" onsubmit="return validatePersonnelForm()">
            <input type="text" name="nome" id="nome" required>Nome Titolare<br>
            <input type="text" name="cognome" id="cognome" required>Cognome Titolare<br>
            <input type="text" name="productName" id="productName" required>Codice Fiscale<br>
            <input type="text" name="username" id="username" required>Username Titolare<br>
            <input type="password" name="password" id="password" required>Password<br>
            <input type="password" name="passwordConfirm" id="passwordConfirm" required>Conferma Password<br>
            <input type="text" name="dataNascita" id="dataNascita">Data Nascita (gg-mm-aaaa)<br>
            <input type="text" name="codRegionale" id="codRegionale" required>Codice Regionale<br>
            <input type="radio" name="role" value="df" checked="checked">Dottore Farmacista<br>
            <input type="radio" name="role" value="ob">Operatore di banco<br>
            <input type="submit" value="REGISTRA">
        </form>
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
