<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">

    <title>AREA PRIVATA</title>
    <jsp:include page="../util/checkLog.jsp"/>
    <% String role = (String) request.getSession().getAttribute("role"); %>
</head>
<body>
<footer class="wrapper style1">
    <div id="header">
        <div class="container">
            <nav id="nav">
                <jsp:include page="../util/bar.jsp"/>
            </nav>
        </div>
    </div>
    <div id="banner">
        <%
            if (role.equals("reg"))
            { %>
        <h2>HOME REGIONE</h2>
        <% }
        else if(role.toUpperCase().equals("TF"))
        { %>
        <h2>HOME TITOLARE FARMACIA</h2>
        <% }
        else if(role.toUpperCase().equals("DF"))
        { %>
        <h2>HOME DOTTORE FARMACISTA</h2>
        <% }
        else if(role.toUpperCase().equals("OB"))
        { %>
        <h2>HOME OPERATORE DI BANCO</h2>
        <% }
        %>
    </div>

    <div class="links">
    <%
            if (role.equals("reg"))
            { %>
        <ul>
            <li><h4><a href="<%=request.getContextPath()%>/jsp/registerPharmacy.jsp">Registra una nuova Farmacia</a></h4></li>
            <li><h4><a href="<%=request.getContextPath()%>/jsp/analysis.jsp">Analisi Vendite</a></h4></li>
        </ul>
        <% }
        else if(role.toUpperCase().equals("TF"))
        { %>
        <ul>
            <li><h4><a href="<%=request.getContextPath()%>/jsp/registerPersonnel.jsp">Registra Personale Collaboratore</a></h4></li>
            <li><h4><a href="<%=request.getContextPath()%>/jsp/listPersonnel.jsp">Elenco Personale Farmacia</a></h4></li>
            <li><h4><a href="<%=request.getContextPath()%>/jsp/purchase.jsp">Inserisci nuovo acquisto</a></h4></li>
            <li><h4><a href="<%=request.getContextPath()%>/jsp/warehouse.jsp">Magazzino</a></h4></li>
            <li><h4><a href="<%=request.getContextPath()%>/jsp/analysis.jsp">Analisi Vendite</a></h4></li>
        </ul>
        <% }
        else if(role.toUpperCase().equals("DF") || role.toUpperCase().equals("OB"))
        { %>
        <ul>
            <li><h4><a href="<%=request.getContextPath()%>/jsp/purchase.jsp">Inserisci nuovo acquisto</a></h4></li>
        </ul>
        <% }
        %>

    </div>

    <footer id = "footer">
        <h6>Creato da Garion Musetta _ Tutti i diritti sono riservati @2017</h6>
    </footer>
</div>
</body>
</html>
