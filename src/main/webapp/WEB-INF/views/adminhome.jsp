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
    <title>Admin homepage</title>
</head>
<body>
<h2>Flights Generators</h2>
<form id="flightInput" action="/input/flight" method="post">
    Flight number <br><input type="text" required id="flight_number" name="flight_number"><br>
    Departure time <br><input type="datetime-local" required id="departure_time" name="departure_time"><br>
    Arrival time <br><input type="datetime-local" required id="arrival_time" name="arrival_time"><br>
    Departure airport <br><select required id="departure_airport" name="departure_airport">
        <option value="London">London</option>
        <option value="Paris">Paris</option>
        <option value="Berlin">Berlin</option>
        <option value="Amsterdam">Amsterdam</option>
        <option value="Helsinki">Helsinki</option>
    </select><br>
    Arrival airport <br><select required id="arrival_airport" name="arrival_airport">
        <option value="London">London</option>
        <option value="Paris">Paris</option>
        <option value="Berlin">Berlin</option>
        <option value="Amsterdam">Amsterdam</option>
        <option value="Helsinki">Helsinki</option>
    </select><br>
    Seat number <br><input type="number" required id="seat_number" name="seat_number"><br>
    Seat available <br><input type="number" required id="seat_free" name="seat_free"><br>
    Price <br><input type="number" required id="price" name="price"><br><br>
    <input type="submit" value="Input flight">
    <input type="button" value="log out" onclick="location.href='/admin/logout'">
</form>
</body>
<script>
    if ('${status}' != ''){
        if ('${status}' == 1){
            alert("Flight already exists");
        }
        else if ('${status}' == 0){
            alert("Flight input successfully");
        }
        else if ('${status}' == 2){
            alert("Flight input failed");
        }
    }
</script>
</html>
