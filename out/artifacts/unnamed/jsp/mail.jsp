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
<div id="container">
    <div id="header">
        <h2>Mail</h2>
    </div> <!-- header -->
    <div id="cont">
        <div id="left" class="left">
            <jsp:include page="../util/sidebar.jsp"/>
        </div> <!-- left -->

        <div id="body">
            <h4><a href="<%=request.getContextPath()%>/jsp/newMail.jsp">Invia nuova Mail</a></h4>
            <h4><a href="<%=request.getContextPath()%>/jsp/inboxMail.jsp">Mail ricevute</a></h4>
            <h4><a href="<%=request.getContextPath()%>/jsp/sentMail.jsp">Mail inviate</a></h4>
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
