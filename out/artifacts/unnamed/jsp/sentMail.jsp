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
    <table class="mail">
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
            <tr class="blank_row">
            <td colspan="3"></td>
            </tr>

            <tr><td width="15%">
            <h4>Data : </h4>
            </td><td width="85%">
            <%= table.getString("dt_invio") %>
            </td></tr>

            <tr><td width="15%">
            <h4>Inviata a : </h4>
            </td><td width="85%">
            <%
                dest = table.getString("toOp");
                if(dest == null)
                    dest = table.getString("toReg");
            %>
            <%= dest %>
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
                <h4>Nessuna mail inviata!</h4>
<%
            }
        }
        catch(Exception e)
        { }
%>

    </table>


    <div id = "push"></div>
</div> <!-- wrapper-->
<div id = "footer">
    <h6>Creato da Garion Musetta @2017</h6>
</div>
</body>
</html>
