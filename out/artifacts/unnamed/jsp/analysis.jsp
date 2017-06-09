<%@ page import="util.loginCheck" %>
<%@ page import="Beans.LoginBean" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <link href="<%=request.getContextPath()%>/css/bootstrap.css" rel="stylesheet" type="text/css">

    <title>ANALISI</title>

    <!-- in ogni pagina controlla prima che si è loggati -->
    <%
        String role = "";

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
        else
            role = (String) request.getSession().getAttribute("role");
    %>
</head>
<body>
    <!-- controlla attribute per vedere cosa mostrare -->

    <div id="container">
        <div id="header">
            <% if(role.equals("pers")) {%>
                <h2>Analisi Vendite Farmacia</h2>
            <%} else {%>
                <h2>Analisi Vendite Farmacia</h2>
            <% } %>
        </div> <!-- header -->
        <div id="body">
            <% if(role.equals("pers")) {%>

            <!-- tabellla -->


            <%} else {%>




            <% } %>

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
