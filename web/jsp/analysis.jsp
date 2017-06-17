<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>ANALISI</title>
    <jsp:include page="../util/checkLog.jsp"/>
    <%
        String role = (String) request.getSession().getAttribute("role");
    %>
</head>
<body>
<!-- controlla attribute per vedere cosa mostrare -->

<div id="container">
    <div id="header">
        <% if(role.equals("pers")) {%>
        <h1>Analisi Vendite Farmacia</h1>
        <%} else {%>
        <h1>Analisi Vendite Farmacia</h1>
        <% } %>
    </div> <!-- header -->
    <div id="cont">
        <div id="left" class="left">
            <jsp:include page="../util/sidebar.jsp"/>
        </div>
        <div id="body" class="right">
            <%
                if(role.equals("pers"))
                {
            %>

            <!-- tabellla -->


            <%
            }
            else
            {
            %>
            <%
                }
            %>

        </div> <!-- body -->
        <div class="clear"/>
        <div id= "footer">
            <h6>Creato da Garion Musetta _ Tutti i diritti sono riservati @2017</h6>
        </div> <!--footer-->
    </div> <!-- container-->
</body>
</html>
