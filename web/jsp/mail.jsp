<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>MAIL</title>
    <jsp:include page="../util/checkLog.jsp"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">

    <%
        String role = ((String) request.getSession().getAttribute("role")).toLowerCase();
    %>

</head>
<body>
<div class = "wrapper style1">
    <div id="header">
        <div class="container">
            <nav id="nav">
                <jsp:include page="../util/bar.jsp"/>
            </nav>
        </div>
    </div> <!-- header -->

    <div id="banner">
        <h2>Mail</h2>
    </div>

        <div class="links">
            <ul>
                <li><h4><a href="<%=request.getContextPath()%>/jsp/newMail.jsp">Invia nuova Mail</a></h4></li>
                <li><h4><a href="<%=request.getContextPath()%>/jsp/inboxMail.jsp">Mail ricevute</a></h4></li>
                <li><h4><a href="<%=request.getContextPath()%>/jsp/sentMail.jsp">Mail inviate</a></h4></li>
            </ul>
        </div> <!-- body -->



    <div id = "push"></div>
</div> <!-- wrapper-->
<div id = "footer">
    <h6>Creato da Garion Musetta @2017</h6>
</div>
<%
    String msg = (String) request.getSession().getAttribute("msg");

    if(msg != null)
    {
%>
        <script>
            alert("<%= msg %>");
        </script>
<%
        request.getSession().removeAttribute("msg");
    }
%>

</body>
</html>
