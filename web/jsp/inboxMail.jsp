<%@ page import="util.TableReader" %>
<%@ page import="Beans.LoginBean" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>MAIL IN ARRIVO</title>
    <jsp:include page="../util/checkLog.jsp"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">

    <%
        String role = ((String) request.getSession().getAttribute("role")).toLowerCase();
    %>

</head>
<body>
<div class="wrapper style1">
    <div id="header">
        <div class="container">
            <nav id="nav">
                <jsp:include page="../util/bar.jsp"/>
            </nav>
        </div>
    </div>
    <div id="banner">
        <h2>Mail in arrivo</h2>
    </div>
    <!-- tABELLA PER LE MAIL -->
        <table class = "mail">
        <%
            try
            {
                int i = 0;
                TableReader reader = new TableReader();
                LoginBean bean = ((LoginBean) session.getAttribute("RegisterBean"));
                ResultSet table = reader.buildInboxMailTable(role, bean.getUsername());
                String username, mitt;

                 while(table.next())
                {
                    i++;
        %>
                    <tr class="blank_row">
                    <td colspan="3"></td>
                    </tr>

                    <tr><td width="15%">
                    <h4>Data : </h4>
                    </td><td width="85%">
                    <%= table.getString("dt_invio") %>
                    </td></tr>

                    <tr><td width="15%">
                    <h4>Mittente : </h4>
                    <%
                        mitt = table.getString("fromOp");
                        if(mitt == null)
                            mitt = table.getString("fromReg");
                    %>
                    </td><td width="85%">
                    <%= mitt %>
                    </td></tr>

                    <tr><td width="15%">
                    <h4>Oggetto : </h4>
                    </td><td width="85%">
                    <%= table.getString("oggetto") %>
                    </td></tr>

                    <tr><td width="15%">
                    <h4>Messaggio : </h4>
                    </td><td width="85%">
                    <%= table.getString("msg") %>
                    </td></tr>

                <tr class="blank_row">
                <td colspan="3"></td>
                </tr>

                    <%
                }

                if(i == 0)
                {
        %>
                    <h4>Nessuna mail ricevuta!</h4>
        <%
                }
            }
            catch(Exception e)
            {

            }
        %>
        </table>

    <footer id= "footer">
        <h6>Creato da Garion Musetta _ Tutti i diritti sono riservati @2017</h6>
    </footer>
</div>
</body>
</html>
