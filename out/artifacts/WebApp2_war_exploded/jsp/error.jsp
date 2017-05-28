<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
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
<a href = "/index.html">Torna alla home</a>
</body>
</html>
