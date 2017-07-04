<%@ page import="util.TableReader" %>
<%@ page import="Beans.LoginBean" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="util.Configurations" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/validationRegisters.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/util.js"></script>
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

    <div class = "forms">
    <!-- form per l'invio -->
            <form action="<%=request.getContextPath()%>/mail.do" method="post" name="form">

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
                        int i = 1;

                        while(table.next())
                        {
                            if((i % 4) == 0)
                                %> <br> <%
                            username = table.getString("username");
                            //stampa la checkbox solo se non è lo stesso utente che invia
                            if(!reg && username.equals(userUsername))
                                continue;
                    %>
                             <input type="checkbox" name="username" value="<%= username %>"><%= username %>
                    <%

                            i++;
                        }

                        //aggiunge anche username reg
                        if(role.equals("tf"))
                        {
                    %>
                            <br>  <input type="checkbox" name="username" value="<%= Configurations.REG_USERNAME %>"><%= Configurations.REG_USERNAME %>
                    <%
                        }
                    %>
                    <!-- invia a tutti check -->
                    <br>
                    <input type="checkbox" name="all" onClick="selectAll(this, 'username')" /> Seleziona tutti<br/>
                    <%
                        }
                        catch (Exception e)
                        {
                            e.printStackTrace();
                        }
                    %>
                <br>
                Oggetto<br> <input type="text" name="obj" id="obj" required>
                <textarea name="text" id="text" rows="20" cols="38" onfocus="clearArea(this);" required>Testo mail...</textarea><br>
                <input type="submit" value="INVIA">
            </form>
    </div>

    <footer id= "footer">
        <h6>Creato da Garion Musetta _ Tutti i diritti sono riservati @2017</h6>
    </footer>
</div>
</body>
</html>
