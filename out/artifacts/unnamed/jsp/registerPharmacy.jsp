<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>REGISTRA NUOVA FARMACIA</title>
    <jsp:include page="../util/checkLog.jsp"/>
    <script type="text/javascript" src="../javascript/validation.js"></script>
</head>
<body>
<div id="container">
    <div id="header">
        <h1>REGISTRA NUOVA FARMACIA</h1>
    </div> <!-- header -->

    <div id="cont">
        <div id="left" class="left">
            <jsp:include page="../util/sidebar.jsp"/>
        </div> <!-- left -->
        <div id="body" class="right">

            <h4>Dati Titolare Farmacia: </h4>
            <form action="<%=request.getContextPath()%>/registerPharmacy.do" method="post" name="form" onsubmit="return validatePharmacyForm()">
                <input type="text" name="nome" id="nome" required>Nome Titolare<br>
                <input type="text" name="cognome" id="cognome" required>Cognome Titolare<br>
                <input type="text" name="productName" id="productName" required>Codice Fiscale<br>
                <input type="text" name="username" id="username" required>Username Titolare<br>
                <input type="password" name="password" id="password" required>Password<br>
                <input type="password" name="passwordConfirm" id="passwordConfirm" required>Conferma Password<br>
                <!-- Noe-> per la data di nascita c'Ã¨ <input type="date" name="dataNascita">,
                ma non Ã¨ supportato da firefox e da explorer 11 e precedenti -->
                <input type="text" name="dataNascita" id="dataNascita">Data Nascita (gg-mm-aaaa)<br>
                <input type="text" name="codRegionale" id="codRegionale" required>Codice Regionale<br>
                <br>
                <h4>Dati Farmacia</h4>
                <input type="text" name="nomeF" id="nomeF" required>Nome Farmacia<br>
                <input type="text" name="indirizzo" id="indirizzo" required>Indirizzo<br>
                <input type="text" name="telefono" id="telefono" required>Numero di Telefono<br>

                <input type="submit" value="REGISTRA">
            </form>
        </div> <!-- body -->
        <div class="clear"/>
    </div>
    <div id= "footer">
        <h6>Creato da Garion Musetta _ Tutti i diritti sono riservati @2017</h6>
    </div> <!--footer-->
</div> <!-- container-->
</body>
</html>