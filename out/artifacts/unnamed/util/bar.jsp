<%@ page import="Beans.LoginBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>
        <ul>
            <b>@<%= ((LoginBean) request.getSession().getAttribute("RegisterBean")).getUsername() %></b>
            &nbsp;&nbsp;&nbsp;
            <li class="active"><a href="<%=request.getContextPath()%>/jsp/privateHome.jsp">Home</a></li>
            <li><a href="<%=request.getContextPath()%>/jsp/mail.jsp">Mail</a></li>
            <li><a href="<%=request.getContextPath()%>/jsp/logout.jsp">Logout</a></li>
        </ul>

</body>
</html>
