<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 18/07/2019
  Time: 01:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Simulation</title>
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

        <h2>Simulating flights</h2><br>
        <input type="button" value="Flights Home" onclick="location.href='/manage/flights'" class="btn-blue"><br><br>
        <form id="simulating" name="simulating" action="/simulating/flights" method="post">
            Simulating current time: <input type="time" id="simulationTime" name="simulationTime"
                                            class="text_field" value="${time}" readonly><br><br>
            Simulating airport: <input type="text" id="simulationAirport" name="simulationAirport"
                                       value="${airport}" class="text_field" readonly><br><br>
        </form>

        <table class="table" id="nowFlights" align="center" valign="center">
            <thead class="thead-dark">
            <tr>
                <th scope="col" align="center" valign="center">ID</th>
                <th scope="col" align="center" valign="center">Flight number</th>
                <th scope="col" align="center" valign="center">Departure time</th>
                <th scope="col" align="center" valign="center">Arrival time</th>
                <th scope="col" align="center" valign="center">Departure airport</th>
                <th scope="col" align="center" valign="center">Arrival airport</th>
                <th scope="col" align="center" valign="center">Seat number</th>
                <th scope="col" align="center" valign="center">Available seat number</th>
                <th scope="col" align="center" valign="center">Price</th>
                <th scope="col" align="center" valign="center">Status</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach varStatus="s" items="${simulationFlights}" var="item">
                <tr>
                    <td align="center" valign="center">${item.flightid}</td>
                    <td align="center" valign="center">${item.flightNumber}</td>
                    <td align="center" valign="center">${item.departureTime}</td>
                    <td align="center" valign="center">${item.arrivalTime}</td>
                    <td align="center" valign="center">${item.departureAirport}</td>
                    <td align="center" valign="center">${item.arrivalAirport}</td>
                    <td align="center" valign="center">${item.seatNumber}</td>
                    <td align="center" valign="center">${item.seatFree}</td>
                    <td align="center" valign="center">${item.price}</td>
                    <td align="center" valign="center">${item.flightStatus}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>

<script>
    if ('${status}' != ''){
        if ('${status}' == 0) {
            alert("There is no data available");
        }
        else if ('${status}' == 1){
            alert("Please check the status of flights");
        }
    }

    setTimeout("simulating.submit();", 3000);
</script>
</html>
