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
        background-image: url("../../images/background5.jpg");
        background-size: 100%;
        background-repeat: repeat;
        font-family: Verdana, Genevs, Arial, sans-serif;
        text-align: center;
    }
</style>
<body>
<div class="container">
    <div id="login_frame">
        <h2>Flights Generator</h2>
        <div class="row">
            <div class="col-md">
                <form id="flightInput" action="/input/flight" method="post">
                    <label class="label_input">Flight number</label>
                    <br><input type="text" required id="flight_number" name="flight_number" class="text_field"><br>
                    <br><label class="label_input">Departure time</label>
                    <br><input type="datetime-local" required id="departure_time" name="departure_time" class="text_field"><br>
                    <label id="timeRemind1" style="visibility: hidden"></label><br>
                    <label class="label_input">Arrival time</label>
                    <br><input type="datetime-local" required id="arrival_time" name="arrival_time" class="text_field"><br>
                    <label id="timeRemind2" style="visibility: hidden"></label><br>
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
                    <label id="airportRemind" style="visibility: hidden"></label><br>
                    <label class="label_input">Seat number</label>
                    <br><input type="number" required id="seat_number" name="seat_number" class="text_field"><br>
                    <br><label class="label_input">Seat available</label>
                    <br><input type="number" required id="seat_free" name="seat_free" class="text_field"><br>
                    <label id="seatRemind" style="visibility: hidden"></label><br>
                    <label class="label_input">Price</label>
                    <br><input type="number" required id="price" name="price" class="text_field"><br>
                    <label id="priceRemind" style="visibility: hidden"></label><br>
                    <input type="submit" value="Input flight" class="btn-blue">
                    <input type="button" value="Log out" onclick="location.href='/admin/logout'" class="btn-blue">
                </form>
                <form id="manageFlights" action="/manage/flights" method="get">
                    <input type="submit" value="Manage flights" class="btn-blue"><br>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    var timeRemind1 = document.getElementById("timeRemind1");
    var timeRemind2 = document.getElementById("timeRemind2");
    var airportRemind = document.getElementById("airportRemind");
    var seatRemind = document.getElementById("seatRemind");
    var priceRemind = document.getElementById("priceRemind");

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
        else if ('${status}' == 3){
            alert("Some information is wrong");
        }
    }
    if ('${time1}' == 3){
        timeRemind1.style.visibility = "visible";
        timeRemind1.innerText = "Departure time or arrival time should be later than the current";
        timeRemind1.style.color = "blue";
    }
    if ('${time2}' == 4){
        timeRemind2.style.visibility = "visible";
        timeRemind2.innerText = "Arrival time should be later than departure time";
        timeRemind2.style.color = "blue";
    }
    if ('${airport}' == 5){
        airportRemind.style.visibility = "visible";
        airportRemind.innerText = "Departure airport and arrival airport should be different";
        airportRemind.style.color = "blue";
    }
    if ('${seat}' == 6){
        seatRemind.style.visibility = "visible";
        seatRemind.innerText = "Available seats should not be more than seats on the flight";
        seatRemind.style.visibility = "blue";
    }
    if ('${price}' == 7){
        priceRemind.style.visibility = "visible";
        priceRemind.innerText = "The number of seats, available seats or price should be more than 0";
        priceRemind.style.color = "blue";
    }
</script>
</html>
