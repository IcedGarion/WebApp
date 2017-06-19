<%@ page import="util.loginCheck" %>
<%@ page import="Beans.LoginBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>ANALISI</title>
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
    %>    <%
        String role = ((String) request.getSession().getAttribute("role")).toLowerCase();

        //possono entrare solo tf e reg
        if((! role.equals("reg")) || (! role.equals("tf")))
        {
            request.setAttribute("exitCode", "Area riservata! ");
    %>

    <!-- redirect verso pagina di errore -->
    <script type="text/javascript">
        window.location.replace('error.jsp');
    </script>

        }
    %>
</head>
<body>
<!-- controlla attribute per vedere cosa mostrare -->

<div id="container">
    <div id="header">
        <% if(role.equals("reg")) {%>
        <h1>Analisi Vendite Farmacie nella Regione</h1>
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
