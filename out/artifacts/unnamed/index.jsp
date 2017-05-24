<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<html>
  <head>
    <title>CONNESSIONE AL DB JAVA</title>
  </head>
  <body>
  <div>
      <sql:setDataSource driver = "org.postgresql.Driver" url = "jdbc:postgresql://localhost:5432/contabilita" user = "ubuntu" password = "ubuntu" /> <!-- serve: scarica driver JAR postgres, fai un db con user pass ubuntu -->
      <sql:query var = "result" sql = "select * from Farmacie" />
      <h1>CONTENUTO DB:</h1>
      <UL>
          <c:forEach var = "row" items = "${result.rows}">
              <LI>${row.name}</LI>
          </c:forEach>
      </UL>
  </div>
  <br>
      <h1>FORM</h1>
      <form action = "register.do" method = "post">
        <input type = "text" name = "query">QUERY<br>
        <input type = "submit" value = "ESEGUI">
      </form>
  </body>
</html>
