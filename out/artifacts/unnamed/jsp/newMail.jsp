<%@ page import="util.TableReader" %>
<%@ page import="Beans.LoginBean" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="util.Configurations" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/validationRegisters.js"></script>
    <jsp:include page="../util/checkLog.jsp"/>
    <%
        String role = ((String) request.getSession().getAttribute("role")).toLowerCase();
    %>

    <title>NEW MAIL</title>
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
        <h2>Invia nuova mail</h2>
    </div>

    <!-- form per l'invio -->
            <form action="<%=request.getContextPath()%>/mail.do" method="post" name="form" onsubmit="return validateMailForm()">

                Username destinatari : <br>
                    <%
                        try
                        {
                        TableReader reader = new TableReader();
                        LoginBean bean = ((LoginBean) session.getAttribute("RegisterBean"));
                        String userUsername = bean.getUsername();
                        ResultSet table = reader.buildNewMailTable(role, userUsername);
                        String username;
                        boolean reg = role.equals("reg");

                        while(table.next())
                        {
                            username = table.getString("username");
                            //stampa la checkbox solo se non è lo stesso utente che invia
                            if(!reg && username.equals(userUsername))
                                continue;
                    %>
                    <input type="checkbox" name="username" value="<%= username %>"><%= username %>
                    <%
                        }

                        //aggiunge anche username reg
                        if(role.equals("tf"))
                        {
                    %>
                    <input type="checkbox" name="username" value="<%= Configurations.REG_USERNAME %>"><%= Configurations.REG_USERNAME %>
                    <%
                        }




                         // invia a tutti check? -->













                        }
                        catch (Exception e)
                        {
                            e.printStackTrace();
                        }
                    %>
                <br>
                <input type="text" name="obj" id="obj" required>Oggetto<br>
                <input type="text" name="text" id="text" required>Testo mail...<br>
                <input type="submit" value="INVIA">
            </form>

    <div id= "footer">
        <h6>Creato da Garion Musetta _ Tutti i diritti sono riservati @2017</h6>
    </div>
</div>
</body>
</html>
