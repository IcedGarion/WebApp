<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>
        <ul>
            <li class="active"><a href="<%=request.getContextPath()%>/jsp/privateHome.jsp">Home</a></li>
            <li>
                <a href="<%=request.getContextPath()%>/jsp/mail.jsp">Mail</a>
                <ul>
                    <li><a href="<%=request.getContextPath()%>/jsp/newMail.jsp">Nuova Mail</a></li>
                    <li><a href="<%=request.getContextPath()%>/jsp/inboxMail.jsp">Posta Ricevuta</a></li>
                    <li><a href="<%=request.getContextPath()%>/jsp/sentMail.jsp">Posta Inviata</a></li>
                </ul>
            </li>
            <li><a href="<%=request.getContextPath()%>/jsp/account.jsp">Account</a></li>
            <li><a href="<%=request.getContextPath()%>/jsp/logout.jsp">Logout</a></li>
        </ul>

</body>
</html>
