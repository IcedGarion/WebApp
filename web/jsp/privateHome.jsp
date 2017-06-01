<%@ page import="util.loginCheck" %>
<%@ page import="Beans.LoginBean" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>AREA PRIVATA</title>

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

    <% String role = (String) request.getSession().getAttribute("role"); %>
</head>
<body>
<div id="container">
    <div id="header">
        <%
            if (role.equals("reg"))
            { %>
                <h1>HOME REGIONE</h1>
            <% }
            else if(role.toUpperCase().equals("TF"))
            { %>
                <h1>HOME TITOLARE FARMACIA</h1>
            <% }
            else if(role.toUpperCase().equals("DF"))
            { %>
                <h1>HOME DOTTORE FARMACISTA</h1>
            <% }
            else if(role.toUpperCase().equals("OB"))
            { %>
                <h1>HOME OPERATORE DI BANCO</h1>
            <% }
         %>
    </div> <!-- header -->

    <div id="body">
        <%
            if (role.equals("reg"))
            { %>
                <ul>
                    <li><a href="<%=request.getContextPath()%>/jsp/registerPharmacy.jsp">Registra una nuova Farmacia</a></li>
                    <li><a href="<%=request.getContextPath()%>/jsp/analysis.jsp">Analisi Vendite</a></li>
                </ul>
            <% }
            else if(role.toUpperCase().equals("TF"))
            { %>
                <ul>
                    <li><a href="<%=request.getContextPath()%>/jsp/registerPersonnel.jsp">Registra Personale Collaboratore</a></li>
                    <li><a href="<%=request.getContextPath()%>/jsp/listPersonnel.jsp">Elenco Personale Farmacia</a></li>
                    <li><a href="<%=request.getContextPath()%>/jsp/purchase.jsp">Inserisci nuovo acquisto</a></li>
                    <li><a href="<%=request.getContextPath()%>/jsp/warehouse.jsp">Magazzino</a></li>
                    <li><a href="<%=request.getContextPath()%>/jsp/analysis.jsp">Analisi Vendite</a></li>
                </ul>
            <% }
            else if(role.toUpperCase().equals("DF") || role.toUpperCase().equals("OB"))
            { %>
                <ul>
                    <li><a href="<%=request.getContextPath()%>/jsp/purchase.jsp">Inserisci nuovo acquisto</a></li>
                </ul>
            <% }
        %>
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
</div>
</body>
</html>
