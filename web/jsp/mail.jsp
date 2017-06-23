<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>MAIL</title>
    <jsp:include page="../util/checkLog.jsp"/>
    <%
        String role = ((String) request.getSession().getAttribute("role")).toLowerCase();
    %>

</head>
<body>
<div id="container">
    <div id="header">
        <h2>Mail Inbox</h2>
    </div> <!-- header -->
    <div id="cont">
        <div id="left" class="left">
            <jsp:include page="../util/sidebar.jsp"/>
        </div> <!-- left -->

        <div id="right">
            <h4><a href="newMail.jsp">Invia nuova Mail</a></h4>
        </div>

        <div id="body">
            <!-- Costruisce "tabella" mail in arrivo -->
            <%

            %>
        </div> <!-- body -->
        <div class="clear"/>
    </div>

    <div id= "footer">
        <h6>Creato da Garion Musetta _ Tutti i diritti sono riservati @2017</h6>
    </div> <!--footer-->
</div> <!-- container-->
</body>
</html>
