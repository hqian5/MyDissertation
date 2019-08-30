<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 24/07/2019
  Time: 15:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Manage trips</title>
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
<body onload="checkOptions()">
<div class="container">
    <div id="login_frame">
        <c:if test="${not empty user}">
            <h2>${user.username}, please manage your trips</h2>
        </c:if>
        <div id="trips">
            <table class="table" id="userTrips" align="center" valign="center">
                <thead class="thead-dark">
                <tr>
                    <th scope="col" align="center" valign="center" style="display: none">ID</th>
                    <th scope="col">Flight number</th>
                    <th scope="col">Departure time</th>
                    <th scope="col">Arrival time</th>
                    <th scope="col">From</th>
                    <th scope="col">To</th>
                    <th scope="col">Status</th>
                    <th scope="col">Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach varStatus="s" items="${trips}" var="item">
                    <tr>
                        <td align="center" valign="center" style="display: none">${item.flightid}</td>
                        <td align="center" valign="center">${item.flightNumber}</td>
                        <td align="center" valign="center">${item.departureTime}</td>
                        <td align="center" valign="center">${item.arrivalTime}</td>
                        <td align="center" valign="center">${item.departureAirport}</td>
                        <td align="center" valign="center">${item.arrivalAirport}</td>
                        <td align="center" valign="center">${item.flightStatus}</td>
                        <c:if test="${item.flightStatus != 'On time'}">
                            <td align="center" valign="center">
                                <input type="button" value="Optional flights" class="btn-blue"
                                onclick="document.getElementById('date').value = '${item.departureTime}';
                                        document.getElementById('flightId').value = '${item.flightid}';
                                        document.getElementById('departure').value = '${item.departureAirport}';
                                        document.getElementById('arrival').value = '${item.arrivalAirport}';
                                        optionalFlights();">
                            </td>
                        </c:if>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <form id="optionalConfirm" name="optionalConfirm" action="/optional/confirm" method="post">
                <input type="number" id="flightId" name="flightId" readonly required style="display: none">
                <input type="text" id="date" name="date" readonly required style="display: none">
                <input type="text" id="departure" name="departure" readonly required style="display: none">
                <input type="text" id="arrival" name="arrival" readonly required style="display: none">
            </form>
            <input type="button" value="User Home" onclick="location.href='/user/home'" class="btn-blue">
        </div>

        <div id="option">
            <table class="table" id="options" align="center" valign="center">
                <thead class="thead-dark">
                <tr>
                    <th scope="col" style="display: none">ID</th>
                    <th scope="col">Flight number</th>
                    <th scope="col">Departure time</th>
                    <th scope="col">From</th>
                    <th scope="col">To</th>
                    <th scope="col">Arrival airport</th>
                    <th scope="col">Seat number</th>
                    <th scope="col">Available seat number</th>
                    <th scope="col">Price</th>
                    <th scope="col">Status</th>
                    <th scope="col">Buy</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach varStatus="s" items="${options}" var="item">
                    <tr>
                        <td align="center" valign="center" style="display: none">${item.flightid}</td>
                        <td align="center" valign="center">${item.flightNumber}</td>
                        <td align="center" valign="center">${item.departureTime}</td>
                        <td align="center" valign="center">${item.arrivalTime}</td>
                        <td align="center" valign="center">${item.departureAirport}</td>
                        <td align="center" valign="center">${item.arrivalAirport}</td>
                        <td align="center" valign="center">${item.seatNumber}</td>
                        <td align="center" valign="center">${item.seatFree}</td>
                        <td align="center" valign="center">${item.price}</td>
                        <td align="center" valign="center">${item.flightStatus}</td>
                        <td align="center" valign="center">
                            <input type="button" value="Buy" class="btn-blue" onclick="confirmBuy();
                                    document.getElementById('confirmId').value = '${item.flightid}';
                                    document.getElementById('userId').value = '${user.userid}';
                                    document.getElementById('confirmFlight').value = '${item.flightNumber}';">
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <form id="buyConfirm" action="/buy/options" method="post" style="display: none">
                <input type="number" id="confirmId" name="confirmId" class="text_field" style="display: none" readonly required>
                <input type="number" id="userId" name="userId" class="text_field" style="display: none" readonly required><br>
                Confirm flight number:
                <br><input type="text" id="confirmFlight" name="confirmFlight" class="text_field" style="width: 90px" readonly required><br><br>
                <input type="submit" value="Confirm" class="btn-blue">
                <input type="button" value="Cancel" class="btn-blue" onclick="showTickets()">
            </form><br><br>
            <input type="button" value="Back" onclick="showTrips()" class="btn-blue">
        </div>
    </div>
</div>
</body>
<script>
    if ('${status}' != ''){
        if ('${status}' == 0){
            alert("Please manage your trips");
        }
        else if ('${status}' == 1){
            alert("You have not bought any tickets");
        }
        else if ('${status}' == 2){
            alert("Please view optional tickets");
        }
        else if ('${status}' == 3){
            alert("Sorry, there are no optional tickets");
        }
        else if ('${status}' == 4){
            alert("You have successfully bought an optional ticket");
        }
        else if ('${status}' == 5){
            alert("You failed to buy an optional ticket");
        }
    }
    
    function optionalFlights() {
        document.forms["optionalConfirm"].submit();
    }

    function checkOptions() {
        if ('${options}'.length === 0){
            document.getElementById("option").style.display = "none";
        }
        else {
            document.getElementById("option").style.display = "";
            document.getElementById("trips").style.display = "none";
        }
    }

    function confirmBuy() {
        document.getElementById("buyConfirm").style.display = "";
    }

    function showTickets() {
        document.getElementById("buyConfirm").style.display = "none";
    }

    function showTrips() {
        document.getElementById("option").style.display = "none";
        document.getElementById("trips").style.display = "";
    }
</script>
</html>
