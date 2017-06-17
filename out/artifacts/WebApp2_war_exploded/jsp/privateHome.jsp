<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>AREA PRIVATA</title>
    <jsp:include page="../util/checkLog.jsp"/>
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
    <div id="cont">
        <div id="left" class="left">
            <jsp:include page="../util/sidebar.jsp"/>
        </div> <!-- left -->
        <div id="body" class="right">
            <%
                if (role.equals("reg"))
                { %>
            <ul>
                <li><a href="<%=request.getContextPath()%>/jsp/registerPharmacy.jsp">Registra una nuova Farmacia</a></li>
                <li><a href="<%=request.getContextPath()%>/jsp/medics.jsp">Elenco Medici nella Regione</a></li>
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
        <div class="clear"/>
    </div>

    <div id= "footer">
        <h6>Creato da Garion Musetta _ Tutti i diritti sono riservati @2017</h6>
    </div>
</div>
</body>
</html>
