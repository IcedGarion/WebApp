<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="css/common.css" rel="stylesheet" type="text/css">
    <title>HOME</title>
</head>
<body>
<div class="wrapper style1">
	<div id="header">
        <div class="container">
            <nav id="nav" hidden>
                <jsp:include page="/util/bar.jsp"/>
            </nav>
        </div>
	</div>
	<div id="banner">
    			<h2>Contabilità</h2>
	</div>

        <div id="login">
		<h1>Log in</h1>	<a href="" title="REGIONE : Username = codice regione &#13;PERSONALE FARMACIA : Username = il tuo username definito in fase di registrazione">?</a> <br>
		    <form action = "login.do" method = "post">
		        <input type = "text" name = "username" required>Username <br>
		        <input type = "password" name = "passwd" required>Password<br>
		        <input type = "radio" name = "role" value = "reg" checked = "checked">REGIONE<br>
		        <input type = "radio" name = "role" value = "pers">OPERATORE<br>
		        <input type = "submit" value = "Log in">
		    </form>

        </div>

	<div id= "footer">
	    <h6>Creato da Garion Musetta _ Tutti i diritti sono riservati @2017</h6>
	</div> <!--footer-->
</div>
</body>
</html>
