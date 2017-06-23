<%@ page import="util.TableReader" %>
<%@ page import="Beans.LoginBean" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>NEW MAIL</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">
    <jsp:include page="../util/checkLog.jsp"/>
    <%
        String role = ((String) request.getSession().getAttribute("role")).toLowerCase();
    %>

</head>
<body>
<div id="container">
    <div id="header">
        <h2>Invia nuova mail</h2>
    </div> <!-- header -->
    <div id="cont">
        <div id="left" class="left">
            <jsp:include page="../util/sidebar.jsp"/>
        </div> <!-- left -->
        <div id="body">
            <!-- form per l'invio -->
            <form action="<%=request.getContextPath()%>/mail.do" method="post" name="form" onsubmit="return validateMailForm()">
                Username destinatari : <br>
                    <%
                        try
                        {
                        TableReader reader = new TableReader();
                        LoginBean bean = ((LoginBean) session.getAttribute("RegisterBean"));
                        ResultSet table = reader.buildNewMailTable(role, bean.getUsername());
                        String username;

                        while(table.next())
                        {
                            username = table.getString("username");
                    %>
                    <input type="checkbox" name="username" value="<%= username %>"><%= username %>
                    <%
                        }
                        }
                        catch (Exception e)
                        { }
                    %>
                <br>
                <input type="text" name="obj" id="obj" required>Oggetto<br>
                <input type="text" name="text" id="text" required>Testo mail...<br>
                <input type="submit" value="INVIA">
            </form>

        </div> <!-- body -->
        <div class="clear"/>
    </div>

    <div id= "footer">
        <h6>Creato da Garion Musetta _ Tutti i diritti sono riservati @2017</h6>
    </div> <!--footer-->
</div> <!-- container-->

<%
    String msg = (String) request.getSession().getAttribute("msg");

    if(msg != null)
    {%>
<script>
    alert("<%= msg %>");
</script>
<%}%>


</body>
</html>
