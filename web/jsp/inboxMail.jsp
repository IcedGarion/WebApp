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
<div id="container">
    <div id="header">
        <h2>Mail in arrivo</h2>
    </div> <!-- header -->
    <div id="cont">
        <div id="left" class="left">
            <jsp:include page="../util/sidebar.jsp"/>
        </div> <!-- left -->

        <div id="body">
            <!-- tABELLA PER LE MAIL -->
            <br>
            <%
                try
                {
                    TableReader reader = new TableReader();
                    LoginBean bean = ((LoginBean) session.getAttribute("RegisterBean"));
                    ResultSet table = reader.buildInboxMailTable(role, bean.getUsername());
                    String username, mitt;

                    while(table.next())
                    {
            %>
            <h4>Mittente : </h4>
            <%
                mitt = table.getString("fromOp");
                if(mitt == null)
                    mitt = table.getString("fromReg");
            %>
            <%= mitt %>

            <br>
            <h4>Oggetto : </h4>
            <%= table.getString("oggetto") %>

            <br>
            <h4>Data : </h4>
            <%= table.getString("dt_invio") %>

            <br>
            <h4>Messaggio : </h4>
            <br>
            <%= table.getString("msg") %>
            <%
                    }
                }
                catch(Exception e)
                {

                }
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
