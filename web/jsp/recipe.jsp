<%@ page import="util.loginCheck" %>
<%@ page import="Beans.LoginBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/validationRecipe.js"></script>

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

    <title>INFORMAZIONI RICETTA</title>
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
        <h2>ricetta</h2>
    </div>

    <div class ="forms">
        <form action="<%=request.getContextPath()%>/addRecipeToCart.do" method="post" name="form" onsubmit="return validatePrescriptionForm()">
            <h4>Dati Paziente: </h4>
            Codice fiscale paziente<br> <input type="text" name="cfPaz" id="cfPaz" required>
            Nome paziente<br> <input type="text" name="nomePaz" id="nomePaz" required>
            Cognome paziente<br> <input type="text" name="cognomePaz" id="cognomePaz" required>
            Data di nascita Paziente<br> <input type="text" name="dataNascitaPaz" id="dataNascitaPaz" required>

            <h4>Dati Ricetta:</h4>
            Codice regionale medico<br> <input type="text" name="codRegMed" id="codRegMed" required>
            <br>
            <input type="submit" value="REGISTRA">
        </form>
    </div>


    <div id = "push"></div>
</div> <!-- wrapper -->
<div id = "footer">
    <h6>Creato da Garion Musetta @2017</h6>
</div>
</body>
</html>
