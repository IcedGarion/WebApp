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
    Logout in corso...

    <%
        request.getSession().removeAttribute("RegisterBean");
    %>
        <script type="text/javascript">
            window.location.replace('<%=request.getContextPath()%>/index.html');
        </script>
</div> <!-- container>
</body>
</html>
