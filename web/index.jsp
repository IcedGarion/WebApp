<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="css/common.css" rel="stylesheet" type="text/css">
    <title>HOME</title>
</head>
<body>
<div class="wrapper style1">
	<div id="banner">
    			<h2>Contabilita'</h2>
	</div>

        <div id="login">
		<h1>Log in</h1>
			<!-- <a href="" title="REGIONE : Username = codice regione &#13;PERSONALE FARMACIA : Username = il tuo username definito in fase di registrazione">?</a> -->

		    <form action = "login.do" method = "post">
				Username <br><input type = "text" name = "username" size = "13" required>
				Password<br><input type = "password" name = "passwd" size = "13	" required>
		        <input type = "radio" name = "role" value = "reg" checked = "checked">REGIONE<br>
		        <input type = "radio" name = "role" value = "pers">OPERATORE<br>
		        <input type = "submit" value = "Log in">
		    </form>

        </div>

	<div id = "push"></div>
</div>
<div id = "footer">
	<h6>Creato da Garion Musetta _ Tutti i diritti sono riservati @2017</h6>
</div>
</body>
</html>
