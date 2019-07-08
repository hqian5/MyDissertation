<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 30/06/2019
  Time: 17:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Log in</title>
</head>
<body>
<h2>User Login</h2>
<form id="userLogin" action="/user/login" method="post">
    Username <br><input type="text" required id="username" name="username"><br>
    Password <br><input type="password" required id="userpassword" name="userpassword"><br><br>
    <input type="submit" value="Log in">
    <input type="button" value="Register" onclick="location.href='/login/register'"><br><br>
    <input type="button" value="Back" onclick="location.href='/back/index'">
</form>
</body>

<script>
    if ('${status}' != ''){
        if ('${status}' == 0) {
            alert("User login successfully");
            location.href = '/user/home';
        }
        else if ('${status}' == 1){
            alert("Account does not exist");
        }
        else if ('${status}' == 2) {
            alert("Wrong password");
        }
    }
</script>
</html>
