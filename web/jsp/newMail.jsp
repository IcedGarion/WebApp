<%@ page import="util.TableReader" %>
<%@ page import="Beans.LoginBean" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="util.Configurations" %>
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




                <!-- invia a tutti check? -->
                <!-- anche regione dest!
                    GUARDA IL TABLEREADER: aggiungi una colonna
                    POI LO STESSO CHE MANDA LA MAIL NON DEVE APPARIRE TRA I DEST!
                    https://www.tutorialspoint.com/jdbc/updating-result-sets.htm -->



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
                        if(!reg)
                        {
                    %>
                    <input type="checkbox" name="username" value="<%= Configurations.REG_USERNAME %>"><%= Configurations.REG_USERNAME %>
                    <%
                        }
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

        </div> <!-- body -->
        <div class="clear"/>
    </div>

    <div id= "footer">
        <h6>Creato da Garion Musetta _ Tutti i diritti sono riservati @2017</h6>
    </div> <!--footer-->
</div> <!-- container-->
</body>
</html>
