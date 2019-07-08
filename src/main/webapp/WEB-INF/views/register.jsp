<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 06/07/2019
  Time: 12:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register</title>
</head>
<body>
<h2>User Register</h2>
<form id="userRegister" action="/user/register" method="post">
    Username <br><input type="text" required id="uname" name="uname"><br>
    Password <br><input type="password" required id="upassword" name="upassword"><br>
    Personal name <br><input type="text" required id="realname" name="realname"><br>
    Passport number <br><input type="text" required id="passport" name="passport"><br>
    Email address <br><input type="text" required id="email" name="email"><br>
    Mobile number <br><input type="text" required id="phone" name="phone"><br>
    Your preference on flight <br><select required id="preference" name="preference">
    <option value="cheap">cheap</option>
    <option value="fast">fast</option>
    <option value="less changes">less changes</option>
    </select><br><br>
    <input type="submit" value="Register"><br><br>
    <input type="button" value="Back" onclick="location.href='/back/login'">
</form>
</body>
<script>
    if ('${status}' != ''){
        if ('${status}' == 0) {
            alert("Register successfully");
            location.href = '/register_ok/login'
        }
        else if ('${status}' == 1){
            alert("Username already exists");
        }
        else if ('${status}' == 2){
            alert("Registration failed");
        }
    }
</script>
</html>
