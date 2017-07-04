<%@ page import="util.loginCheck" %>
<%@ page import="Beans.LoginBean" %>
<%@ page import="util.AnalysisMethod" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/validationRegisters.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">

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

<div class="wrapper style1">
    <div id="header">
        <div class="container">
            <nav id="nav">
                <jsp:include page="../util/bar.jsp"/>
            </nav>
        </div>
    </div>
    <div id="banner">
        <% if(role.equals("reg")) {%>
        <h2>Analisi Vendite Farmacie nella Regione</h2>
        <%} else {%>
        <h2>Analisi Vendite Farmacia</h2>
        <% } %>
    </div> <!-- header -->

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
            </table>

          <div id = "push"></div>
</div> <!--wrapper -->
<div id = "footer">
    <h6>Creato da Garion Musetta _ Tutti i diritti sono riservati @2017</h6>
</div>
</body>
</html>
