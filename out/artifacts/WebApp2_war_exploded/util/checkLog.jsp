<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="util.loginCheck" %>
<%@ page import="Beans.LoginBean" %>
<html>
<body>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
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
</body>
</html>
