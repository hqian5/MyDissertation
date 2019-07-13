<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 11/07/2019
  Time: 17:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Manage page</title>
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
    <div class="manage_frame">
        <h2>Please manage all flights</h2>
    </div>
</div>
<c:if test="${empty flights}">
    <div class="container">
        <div id="index_frame">
            <label class="label_input">There is no data</label>
        </div>
    </div>
</c:if>
<div class="container">
    <div id="login_frame">
        <table class="table" align="center" valign="center">
            <thead class="thead-dark">
            <tr>
                <th scope="col">ID</th>
                <th scope="col">Flight number</th>
                <th scope="col">Departure time</th>
                <th scope="col">Arrival time</th>
                <th scope="col">Departure airport</th>
                <th scope="col">Arrival airport</th>
                <th scope="col">Seat number</th>
                <th scope="col">Available seat number</th>
                <th scope="col">Price</th>
                <th scope="col">Status</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach varStatus="s" items="${flights}" var="item">
            <tr>
                <td id="id">${item.flightid}</td>
                <td id="flightNumber">${item.flightNumber}</td>
                <td id="deTime">${item.departureTime}</td>
                <td id="arTime">${item.arrivalTime}</td>
                <td id="deAirport">${item.departureAirport}</td>
                <td id="arAirport">${item.arrivalAirport}</td>
                <td id="seat">${item.seatNumber}</td>
                <td id="seatFree">${item.seatFree}</td>
                <td id="price">${item.price}</td>
                <td id="status">${item.flightStatus}</td>

                <td><input type="button" value="update" onclick="showId2();
                document.getElementById('flightId_up').value = '${item.flightid}'" class="btn-blue"></td>
                <td><input type="button" value="delete" onclick="showId();
                document.getElementById('flightId').value = '${item.flightid}'" class="btn-blue"></td>
            </tr>
            </tbody>
            </c:forEach>
        </table>

        <input type="button" value="Back" onclick="location.href='/back/adminhome'" class="btn-blue"><br><br>

        <form id="deleteId" action="/delete/flight" method="post" style="display: none">
            Confirm id: <input type="text" required id="flightId" name="flightId" style="width: 45px" class="text_field" readonly><br>
            <br><input type="submit" value="Confirm delete" class="btn-blue">
        </form>

        <form id="updateId" action="/update/confirm" method="post" style="display: none">
            Update id: <input type="text" required id="flightId_up" name="flightId_up" style="width: 45px" class="text_field" readonly><br>
            <br><input type="submit" value="Begin update" class="btn-blue">
        </form>

        <form id="updateWindow" action="/update/flight" method="post" style="display: none">
            <label class="label_input">Flight Id</label>
            <br><input type="text" required id="update_id" name="update_id" class="text_field" style="width: 45px;" readonly><br>
            <br><label class="label_input">Flight number</label>
            <br><input type="text" required id="flight_number" name="flight_number" class="text_field" readonly><br>
            <br><label class="label_input">Departure time</label>
            <br><input type="datetime-local" required id="departure_time" name="departure_time" class="text_field"><br>
            <label id="timeRemind1" style="color: blue;">Departure time, arrival time should be later than current time</label><br>
            <label class="label_input">Arrival time</label>
            <br><input type="datetime-local" required id="arrival_time" name="arrival_time" class="text_field"><br>
            <label id="timeRemind2" style="color: blue;">Arrival time should be later than departure time</label><br>

            <label class="label_input">Departure airport</label>
            <br><select required id="departure_airport" name="departure_airport" class="text_field">
            <option value="London">London</option>
            <option value="Paris">Paris</option>
            <option value="Berlin">Berlin</option>
            <option value="Amsterdam">Amsterdam</option>
            <option value="Helsinki">Helsinki</option>
            </select><br>
            <br><label class="label_input">Arrival airport</label>
            <br><select required id="arrival_airport" name="arrival_airport" class="text_field">
            <option value="London">London</option>
            <option value="Paris">Paris</option>
            <option value="Berlin">Berlin</option>
            <option value="Amsterdam">Amsterdam</option>
            <option value="Helsinki">Helsinki</option>
            </select><br>

            <label id="airportRemind" style="color: blue;">Departure airport and arrival airport should be different</label><br>
            <label class="label_input">Seat number</label>
            <br><input type="number" required id="seat_number" name="seat_number" class="text_field"><br>
            <br><label class="label_input">Seat available</label>
            <br><input type="number" required id="seat_free" name="seat_free" class="text_field"><br>
            <label id="seatRemind" style="color: blue;">Available seats should not be more than seats on the flight</label><br>
            <label class="label_input">Price</label>
            <br><input type="number" required id="price_up" name="price_up" class="text_field"><br>
            <label id="priceRemind" style="color: blue;">The number of seats, available seats or price should be more than 0</label><br>

            <label class="label_input">Flight status</label><br>
            <select id="flightStatus" name="flightStatus" class="text_field" required>
                <option>On time</option>
                <option>Delayed</option>
                <option>Cancelled</option>
            </select><br>

            <br><input type="submit" value="Confirm update" class="btn-blue">
        </form>
    </div>
</div>
</body>
<script>
    if ('${status}' != ''){
        if ('${status}' == 0) {
            alert("Delete successfully");
        }
        else if ('${status}' == 1){
            alert("Delete failed");
        }
        else if ('${status}' == 2){
            document.getElementById("update_id").value = '${id}';
            document.getElementById("flight_number").value = '${number}'
            document.getElementById("departure_time").value = '${deTime}';
            document.getElementById("arrival_time").value = '${arTime}';
            document.getElementById("departure_airport").value = '${deAirport}';
            document.getElementById("arrival_airport").value = '${arAirport}';
            document.getElementById("seat_number").value = '${seat}';
            document.getElementById("seat_free").value = '${seatFree}';
            document.getElementById("price_up").value = '${price}';
            document.getElementById("updateWindow").style.display = "";
        }
        else if ('${status}' == 3){
            alert("The flight does not exist");
        }
        else if ('${status}' == 4){
            alert("Update successfully");
        }
        else if ('${status}' == 5){
            alert("Update failed");
        }
        else if ('${status}' == 6){
            alert("Some information is wrong");
        }
    }

    function showId() {
        document.getElementById("deleteId").style.display = "";
    }

    function showId2() {
        document.getElementById("updateId").style.display = "";
    }
</script>
</html>