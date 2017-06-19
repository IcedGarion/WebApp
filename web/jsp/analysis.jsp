<%@ page import="util.loginCheck" %>
<%@ page import="Beans.LoginBean" %>
<%@ page import="util.TableReader" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="util.AnalysisMethod" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/validation.js"></script>

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
        if((! role.equals("reg")) && (! role.equals("tf")))
        {
            request.setAttribute("exitCode", "Area riservata! ");
    %>

    <!-- redirect verso pagina di errore -->
    <script type="text/javascript">
        window.location.replace('error.jsp');
    </script>

    <%   }
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
            <table>
                <tr>
                    <th>Numero complessivo di acquisti</th>
                    <th>Numero complessivo di prodotti venduti</th>
                    <th>Numero Farmaci con ricetta</th>
                    <th>Numero di ricette</th>
                    <th>Numero medio farmaci per ricetta</th>
                </tr>
            <%
                try
                {
                    LoginBean bean = ((LoginBean) session.getAttribute("RegisterBean"));
                    AnalysisMethod analysis = null;

                    if(role.equals("tf"))
                        analysis = new AnalysisMethod(bean.getUsername(), "tf");
                    else if(role.equals("reg"))
                        analysis = new AnalysisMethod(bean.getUsername(), "reg");
             %>
                <tr>
                    <td><%= analysis.getTotPurchases() %></td>
                    <td><%= analysis.getTotSold() %></td>
                    <td><%= analysis.getTotSoldWithPrescription() %></td>
                    <td><%= analysis.getTotPrescriptions() %></td>
                    <td><%= analysis.getMeanOfPrescription() %></td>
                </tr>
            <%
                }
                catch (Exception e)
                {
                    e.printStackTrace();
                }
            %>

        </div> <!-- body -->
        <div class="clear"/>
        <div id= "footer">
            <h6>Creato da Garion Musetta _ Tutti i diritti sono riservati @2017</h6>
        </div> <!--footer-->
    </div> <!-- container-->
</div>
</body>
</html>
