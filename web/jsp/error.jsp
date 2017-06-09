<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <link href="<%=request.getContextPath()%>/css/bootstrap.css" rel="stylesheet" type="text/css">

    <title>RESULTS</title>
</head>
<body>
<% String errorMsg = null;
    try
    {
        errorMsg = (String) request.getAttribute("exitCode");
        if(errorMsg == null)
            errorMsg = "Login non effettuata";
    }
    catch(Exception e)
    {
        errorMsg = "Login non effettuata";
    }
%>
<h1><%= errorMsg%></h1>
<%
    if(errorMsg.equals("Login non effettuata"))
    { %>
        <a href = "<%=request.getContextPath()%>/index.html">Torna alla pagina di Login</a>
    <%}
    else
    {%>
        <a href = "<%=request.getContextPath()%>/jsp/privateHome.jsp">Torna alla home</a>
    <%}
%>
</body>
</html>
