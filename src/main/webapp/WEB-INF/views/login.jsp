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
        background-image: url("../../images/background1.jpg");
        background-size: 100%;
        background-repeat: repeat;
        font-family: Verdana, Genevs, Arial, sans-serif;
        text-align: center;
    }
</style>
<body>
<div class="container">
    <div id="login_frame">
        <h2>User Login</h2>
        <div class="row">
            <div class="col-md">
                <form id="userLogin" action="/user/login" method="post">
                    <label class="label_input">Username</label>
                    <br><input type="text" required id="username" name="username" class="text_field"><br>
                    <label class="label_input">Password</label>
                    <br><input type="password" required id="userpassword" name="userpassword" class="text_field"><br><br>
                    <input type="submit" value="Log in" class="btn-blue">
                    <input type="button" value="Register" onclick="location.href='/login/register'" class="btn-blue"><br><br>
                    <input type="button" value="Back" onclick="location.href='/back/index'" class="btn-blue">
                </form>
            </div>
        </div>
    </div>
</div>
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
