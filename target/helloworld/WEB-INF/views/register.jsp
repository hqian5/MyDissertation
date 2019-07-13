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
    <link rel='stylesheet' href='../../css/login.css' />
    <script src = 'https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js'></script>
    <script src='https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js'></script>
    <script src="http://code.jquery.com/jquery-1.11.1.js"></script>
    <link rel="stylesheet" href="../../bootstrap-4.3.1-dist/css/bootstrap.min.css">
    <script src="../../bootstrap-4.3.1-dist/js/bootstrap.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
</head>
<style>
    body{
        background-image: url("../../images/background3.jpg");
        background-size: 100%;
        background-repeat: repeat;
        font-family: Verdana, Genevs, Arial, sans-serif;
        text-align: center;
    }
</style>
<body>
<div class="container">
    <div id="login_frame">
        <h2>User Register</h2>
        <div class="row">
            <div class="col-md">
                <form id="userRegister" action="/user/register" method="post">
                    Username <br><input type="text" required id="uname" name="uname" class="text_field"><br>
                    Password <br><input type="password" required id="upassword" name="upassword" class="text_field"><br>
                    Personal name <br><input type="text" required id="realname" name="realname" class="text_field"><br>
                    Passport number <br><input type="text" required id="passport" name="passport" class="text_field"><br>
                    Email address <br><input type="text" required id="email" name="email" class="text_field"><br>
                    Mobile number <br><input type="text" required id="phone" name="phone" class="text_field"><br>
                    Your preference on flight <br><select required id="preference" name="preference" class="text_field">
                    <option value="cheap">cheap</option>
                    <option value="fast">fast</option>
                    <option value="less changes">less changes</option>
                </select><br><br>
                    <input type="submit" value="Register" class="btn-blue"><br><br>
                    <input type="button" value="Back" onclick="location.href='/back/login'" class="btn-blue">
                </form>
            </div>
        </div>
    </div>
</div>
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
