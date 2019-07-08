<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 05/07/2019
  Time: 23:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Administrator</title>
</head>
<body>
<h2>Administrator Login</h2>
<form id="adminLogin" action="/admin/login" method="post">
    Username <br><input type="text" required id="adname" name="adname"><br>
    Password <br><input type="password" required id="adpassword" name="adpassword"><br><br>
    <input type="submit" value="login">
    <input type="button" value="Back" onclick="location.href='/back/index'">
</form>
</body>

<script>
    if ('${status}' != ''){
        if ('${status}' == 0) {
            alert("Administrator login successfully");
            location.href = '/admin/home';
        }
        else if ('${status}' == 1){
            alert("Account does not exist");
        }
        else if ('${status}' == 2){
            alert("Wrong password")
        }
    }
</script>
</html>
