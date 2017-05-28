<%--
  Created by IntelliJ IDEA.
  User: nb
  Date: 26/05/17
  Time: 16.34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>AREA PRIVATA</title>

    <% String role = (String) request.getAttribute("role"); %>
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
                    <li><a href="registerPharmacy.jsp">Registra una nuova Farmacia</a></li>
                    <li><a href="listPharmacy.jsp">Elenco Farmacie</a></li>
                    <li><a href="analysis.jsp">Analisi Vendite</a></li>
                </ul>
            <% }
            else if(role.toUpperCase().equals("TF"))
            { %>
                <ul>
                    <li><a href="registerPersonnel.jsp">Registra Personale Collaboratore</a></li>
                    <li><a href="listPersonnel.jsp">Elenco Personale Farmacia</a></li>
                    <li><a href="purchase.jsp">Inserisci nuovo acquisto</a></li>
                    <li><a href="warehouse.jsp">Magazzino</a></li>
                    <li><a href="analysis.jsp">Analisi Vendite</a></li>
                </ul>
            <% }
            else if(role.toUpperCase().equals("DF") || role.toUpperCase().equals("OB"))
            { %>
                <ul>
                    <li><a href="purchase.jsp">Inserisci nuovo acquisto</a></li>
                </ul>
            <% }
        %>
    </div> <!-- body -->

    <div id= "footer">
        <h6>ci pensiamo poi</h6>
    </div> <!--footer-->
</div>
</body>
</html>
