<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="<%=request.getContextPath()%>/css/common.css" rel="stylesheet" type="text/css">

    <title>HOME</title>
</head>
<body>
<div class="wrapper style1">
	<div id="loginBanner">
		<h2 id= "bannerh2">Contabilita'</h2>
	</div>

        <div id="login">
		<h1>Log in</h1>

		    <form action = "login.do" method = "post">
				Username <br><input type = "text" name = "username" size = "13" required>
				Password<br><input type = "password" name = "passwd" size = "13	" required>
                <br>
		        <input type = "radio" name = "role" value = "reg" checked = "checked">REGIONE<br>
		        <input type = "radio" name = "role" value = "pers">OPERATORE<br>
                <br>
		        <input type = "submit" value = "Log in">
		    </form>

        </div>

	<div id = "push"></div>
</div>
<div id = "footer">
	<h6>Creato da Garion Musetta @2017</h6>
</div>

</body>
</html>
