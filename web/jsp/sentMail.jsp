<%@ page import="util.TableReader" %>
<%@ page import="Beans.LoginBean" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>MAIL INVIATE</title>
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
        <h2>mail inviate</h2>
    </div>
            <!-- tABELLA PER LE MAIL -->
            <br>
<%
        try
        {
            TableReader reader = new TableReader();
            LoginBean bean = ((LoginBean) session.getAttribute("RegisterBean"));
            ResultSet table = reader.buildSentMailTable(role, bean.getUsername());
            String username, dest;
            int i = 0;

            while(table.next())
            {
                i++;
%>
            <h4>Destinatario : </h4>
            <%
                dest = table.getString("toOp");
                if(dest == null)
                    dest = table.getString("toReg");
            %>
            <%= dest %>

            <br>
            <h4>Oggetto : </h4>
            <%= table.getString("oggetto") %>

            <br>
            <h4>Data : </h4>
            <%= table.getString("dt_invio") %>

            <br>
            <h4>Messaggio : </h4>
            <%= table.getString("msg") %>
            <br>
<%
            }

            if(i == 0)
            {
%>
                <h4>Nessuna mail inviata!</h4>
<%
            }
        }
        catch(Exception e)
        { }
%>


    <div id= "footer">
        <h6>Creato da Garion Musetta _ Tutti i diritti sono riservati @2017</h6>
    </div> <!--footer-->
</div> <!-- container-->
</body>
</html>
