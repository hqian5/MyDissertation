<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 08/07/2019
  Time: 00:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User homepage</title>
</head>
<body>
<form>
    <c:if test="${not empty user}">
        <h2>${user.username}, welcome to Birds Tracker<br></h2>
    </c:if>
    Please track your flight by typing the flight number
    <br><input type="text" required id="flight_no" name="flight_no"><br>
    <input type="submit" id="search">
    <input type="button" value="log out" onclick="location.href='/user/logout'">
</form>
</body>
</html>
