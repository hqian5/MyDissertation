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
        background-image: url("../../images/background6.jpg");
        background-size: 100%;
        background-repeat: repeat;
        font-family: Verdana, Genevs, Arial, sans-serif;
        text-align: center;
    }
</style>
<body>
<div id="tracker" class="container">
    <div id="login_frame">
        <c:if test="${not empty user}">
            <h2>${user.username}, welcome to Birds Tracker<br></h2>
        </c:if>
        <div class="row">
            <div class="col-md">
                <form id="flightSearch" action="/search/flight" method="post">
                    Please track your flight by typing the flight number
                    <br><input type="text" required id="flight_no" name="flight_no" class="text_field"><br>
                    <input type="submit" id="search" class="btn-blue">
                    <input type="button" value="log out" onclick="location.href='/user/logout'" class="btn-blue">
                    <br><br>
                </form>
            </div>
        </div>
    </div>
</div>

<div id="result" class="container" style="display: none">
    <h2>Please check the flight information</h2>
    <div class="row">
        <div class="col-md">
            <label id="flightNumber" class="label_input"></label><br>
            <label id="departureTime" class="label_input"></label><br>
            <label id="arrivalTime" class="label_input"></label><br>
            <label id="departureAirport" class="label_input"></label><br>
            <label id="arrivalAirport" class="label_input"></label><br>
            <br><input type="button" value="Back" class="btn-blue" onclick="location.href='/back/userhome'">
        </div>
    </div>
</div>
</body>
<script>
    if ('${status}' != ''){
        if ('${status}' == 1){
            alert("The flight does not exist");
        }
        else if ('${status}' == 0){
            alert("Click 'OK' to track your flight");
            var result = document.getElementById("result");
            var tracker = document.getElementById("tracker");
            result.style.display = "";
            tracker.style.display = "none";
            document.getElementById("flightNumber").innerText = 'Flight number: ${searchResult.flightNumber}';
            document.getElementById("departureTime").innerText = 'Departure at ${searchResult.departureTime}';
            document.getElementById("arrivalTime").innerText = 'Arrival at ${searchResult.arrivalTime}'
            document.getElementById("departureAirport").innerText = 'Departure airport: ${searchResult.departureAirport}';
            document.getElementById("arrivalAirport").innerText = 'Arrival airport: ${searchResult.arrivalAirport}'
        }
    }
</script>
</html>
