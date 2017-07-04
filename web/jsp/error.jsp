<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <link href="<%=request.getContextPath()%>/css/common.css" rel="stylesheet" type="text/css">

    <title>RESULTS</title>
</head>
<body>
<% String errorMsg = null;
    try
    {
        errorMsg = (String) request.getSession().getAttribute("exitCode");
        if(errorMsg == null)
        {
            errorMsg = (String) request.getAttribute("exitCode");
            if (errorMsg == null)
                errorMsg = "Login non effettuata";
        }
    }
    catch(Exception e)
    {
        errorMsg = "Login non effettuata";
    }
%>
<h1><%= errorMsg%></h1>
<%
    if(errorMsg.equals("Login non effettuata") || errorMsg.equals("Username o Password non corretti"))
    { %>
        <a href = "<%=request.getContextPath()%>/index.jsp">Torna alla pagina di Login</a>
    <%}
    else
    {%>
        <a href = "<%=request.getContextPath()%>/jsp/privateHome.jsp">Torna alla home</a>
    <%}

    request.getSession().removeAttribute("exitCode");
%>

<footer id= "footer">
    <h6>Creato da Garion Musetta _ Tutti i diritti sono riservati @2017</h6>
</footer>
</body>
</html>
