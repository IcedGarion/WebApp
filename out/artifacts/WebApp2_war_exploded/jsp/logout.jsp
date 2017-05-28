<%@ page import="util.loginCheck" %>
<%@ page import="Beans.LoginBean" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>LOGOUT</title>

    <!-- in ogni pagina controlla prima che si è loggati -->
    <%
        if(! (loginCheck.check((LoginBean) session.getAttribute("RegisterBean"), request, null).equals("LOGIN_OK")))
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
    </div> <!-- header -->
    <div id="body">
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
