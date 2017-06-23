<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="util.loginCheck" %>
<%@ page import="Beans.LoginBean" %>
<html>
<body>
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<%
    if(! (loginCheck.check((LoginBean) session.getAttribute("RegisterBean"), request, null).equals("LOGIN_OK")))
    {
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
