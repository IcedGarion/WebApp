<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<html>
  <head>
    <title>CONNESSIONE AL DB JAVA</title>
  </head>
  <body>
  <div>
      <sql:setDataSource
              var = "dataSource"
              driver = "org.postgresql.Driver"
              url = "jdbc:postgresql://localhost:5432/contabilita"
              user = "ubuntu" password = "ubuntu" /> <!-- serve: scarica driver JAR postgres, fai un db con user pass ubuntu -->
      <sql:query var = "result" dataSource="dataSource">select * from operatori; </sql:query>
      <h1>CONTENUTO DB1:</h1>
          <c:forEach var = "row" items = "${result.rows}">
              <c:out value="${row.cognome}" />
          </c:forEach>
  </div>
  <br>
      <h1>FORM</h1>
      <form action = "register.do" method = "post">
        <input type = "text" name = "query">QUERY<br>
        <input type = "submit" value = "ESEGUI">
      </form>
  </body>
</html>
