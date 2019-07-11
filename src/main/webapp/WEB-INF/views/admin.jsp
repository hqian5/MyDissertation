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
        background-image: url("../../images/background4.jpg");
        background-size: 100%;
        background-repeat: repeat;
        font-family: Verdana, Genevs, Arial, sans-serif;
        text-align: center;
    }
</style>
<body>
<div class="container">
    <div id="login_frame">
        <h2>Administrator Login</h2>
        <div class="row">
            <div class="col-md">
                <form id="adminLogin" action="/admin/login" method="post">
                    <label class="label_input">Username</label>
                    <br><input type="text" required id="adname" name="adname" class="text_field"><br>
                    <label class="label_input">Password</label>
                    <br><input type="password" required id="adpassword" name="adpassword" class="text_field"><br><br>
                    <input type="submit" value="Log in" class="btn-blue">
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
