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
            <h2>${user.username}, welcome to Birds Tracker</h2>
        </c:if>
        <div class="row">
            <div class="col-md">
                <form id="flightSearch" action="/search/flight" method="post">
                    Please track your flight by typing the flight number
                    <br><input type="text" required id="flight_no" name="flight_no" class="text_field"><br><br>
                    <input type="submit" value="Track" class="btn-blue">
                </form>

                <form id="buyTickets" action="/buy/tickets" method="post">
                    <h2>Please search tickets</h2>
                    Departure date:
                    <br><input type="date" id="ticketDate" name="ticketDate" class="text_field" required><br>
                    Departure from:
                    <br><select id="ticketFrom" name="ticketFrom" class="text_field">
                    <option value="London">London</option>
                    <option value="Paris">Paris</option>
                    <option value="Berlin">Berlin</option>
                    <option value="Amsterdam">Amsterdam</option>
                    <option value="Helsinki">Helsinki</option>
                    <option value="Frankfurt">Frankfurt</option>
                    <option value="Istanbul">Istanbul</option>
                    <option value="Munich">Munich</option>
                    <option value="Rome">Rome</option>
                    <option value="Moscow">Moscow</option>
                </select><br>
                    To:
                    <br><select id="ticketTo" name="ticketTo" class="text_field">
                    <option value="London">London</option>
                    <option value="Paris">Paris</option>
                    <option value="Berlin">Berlin</option>
                    <option value="Amsterdam">Amsterdam</option>
                    <option value="Helsinki">Helsinki</option>
                    <option value="Frankfurt">Frankfurt</option>
                    <option value="Istanbul">Istanbul</option>
                    <option value="Munich">Munich</option>
                    <option value="Rome">Rome</option>
                    <option value="Moscow">Moscow</option>
                </select><br><br>
                    <input type="submit" value="Search" class="btn-blue">
                </form>

                <h2>Manage your trips</h2>
                <form id="userManage" action="/user/manage" method="post">
                    <input type="number" id="manageId" name="manageId" value="${user.userid}" style="display: none">
                    <input type="submit" value="My trips" class="btn-blue"><br><br>
                    <input type="button" value="log out" onclick="location.href='/user/logout'" class="btn-blue">
                </form>
                <br><br>
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
            <label id="flightStatus" class="label_input"></label><br>
            <br><input type="button" value="refresh" class="btn-blue" onclick="retrack()">
            <input type="button" value="Back" class="btn-blue" onclick="location.href='/user/home'">
        </div>
    </div>
</div>

<div id="manage_frame" class="container" style="display: none">
    <h2>Please check the tickets</h2>
    <div class="row">
        <div class="col-md">
            <table class="table" id="tickets" align="center" valign="center">
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
                    <th scope="col">Buy</th>
                    <%--            <th scope="col" align="center" valign="center">Status</th>--%>
                </tr>
                </thead>
                <tbody>
                <c:forEach varStatus="s" items="${tickets}" var="item">
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
                        <td align="center" valign="center">
                            <input type="button" value="Buy" class="btn-blue" onclick="confirmBuy();
                            document.getElementById('confirmId').value = '${item.flightid}';
                            document.getElementById('userId').value = '${user.userid}';
                            document.getElementById('confirmFlight').value = '${item.flightNumber}';">
                        </td>
                            <%--                <td align="center" valign="center">${item.flightStatus}</td>--%>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <form id="buyConfirm" action="/buy/confirm" method="post" style="display: none">
                <input type="number" id="confirmId" name="confirmId" class="text_field" style="display: none" readonly required>
                <input type="number" id="userId" name="userId" class="text_field" style="display: none" readonly required><br>
                Confirm flight number:
                <br><input type="text" id="confirmFlight" name="confirmFlight" class="text_field" style="width: 90px" readonly required><br><br>
                <input type="submit" value="Confirm" class="btn-blue">
                <input type="button" value="Cancel" class="btn-blue" onclick="showTickets()">
            </form>

            <input type="button" value="Homepage" class="btn-blue" onclick="showHome()">
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
            document.getElementById("arrivalTime").innerText = 'Arrival at ${searchResult.arrivalTime}';
            document.getElementById("departureAirport").innerText = 'Departure airport: ${searchResult.departureAirport}';
            document.getElementById("arrivalAirport").innerText = 'Arrival airport: ${searchResult.arrivalAirport}';
            document.getElementById("flightStatus").innerText = 'Status : ${searchResult.flightStatus}';
        }
        else if ('${status}' == 2){
            alert("There are no tickets available");
        }
        else if ('${status}' == 3){
            document.getElementById("tracker").style.display = "none";
            document.getElementById("manage_frame").style.display = "";
        }
        else if ('${status}' == 4){
            alert("Purchase successfully");
        }
        else if ('${status}' == 5){
            alert("Purchase failed");
        }
    }

    function showHome() {
        document.getElementById("tracker").style.display = "";
        document.getElementById("manage_frame").style.display = "none";
    }

    function confirmBuy() {
        document.getElementById("buyConfirm").style.display = "";
    }

    function showTickets() {
        document.getElementById("buyConfirm").style.display = "none";
    }

    function retrack() {
        location.reload();
    }
</script>
</html>
