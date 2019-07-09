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
<form id="flightSearch" action="/search/flight" method="post">
    <c:if test="${not empty user}">
        <h2>${user.username}, welcome to Birds Tracker<br></h2>
    </c:if>
    Please track your flight by typing the flight number
    <br><input type="text" required id="flight_no" name="flight_no"><br>
    <input type="submit" id="search">
    <input type="button" value="log out" onclick="location.href='/user/logout'">
    <br><br>
    <div id="result" style="display: none">
        <label id="flightNumber"></label><br>
        <label id="departureTime"></label><br>
        <label id="arrivalTime"></label><br>
        <label id="departureAirport"></label><br>
        <label id="arrivalAirport"></label><br>
    </div>

</form>
</body>
<script>
    if ('${status}' != ''){
        if ('${status}' == 1){
            alert("The flight does not exist");
        }
        else if ('${status}' == 0){
            alert("Click 'OK' to track your flight");
            var result = document.getElementById("result");
            result.style.display = "";
            document.getElementById("flightNumber").innerText = 'Flight number: ${searchResult.flightNumber}';
            document.getElementById("departureTime").innerText = 'Departure at ${searchResult.departureTime}';
            document.getElementById("arrivalTime").innerText = 'Arrival at ${searchResult.arrivalTime}'
            document.getElementById("departureAirport").innerText = 'Departure airport: ${searchResult.departureAirport}';
            document.getElementById("arrivalAirport").innerText = 'Arrival airport: ${searchResult.arrivalAirport}'
        }
    }
</script>
</html>
