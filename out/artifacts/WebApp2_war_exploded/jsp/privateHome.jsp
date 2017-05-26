<%--
  Created by IntelliJ IDEA.
  User: nb
  Date: 26/05/17
  Time: 16.34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>AREA PRIVATA</title>
</head>
<body>
    <% if ( request.getAttribute("role").equals("reg"))
    { %> REG <% }
    else
    { %> PERS <% } %>
</body>
</html>
