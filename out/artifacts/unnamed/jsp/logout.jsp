<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">

    <title>LOGOUT</title>
    <jsp:include page="../util/checkLog.jsp"/>
</head>
<body>
<div id="wrapper style1">
    Logout in corso...

    <%
        request.getSession().removeAttribute("RegisterBean");
    %>
    <script type="text/javascript">
        window.location.replace('<%=request.getContextPath()%>/index.jsp');
    </script>


    <div id = "push"></div>
</div> <!-- wrapper-->
<div id = "footer">
    <h6>Creato da Garion Musetta _ Tutti i diritti sono riservati @2017</h6>
</div>
</body>
</html>
