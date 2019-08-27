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
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAmLG_UuFMteDLB4pVVO7yR7CCAb6pTGjc"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
<body onload="initialize()">
<div class="container">
    <div id="login_frame">

        <h2>Simulating flights</h2><br>
        <input type="button" value="Flights Home" onclick="location.href='/manage/flights'" class="btn-blue">
        <input type="button" value="Stop simulation" onclick="location.href='/stop/simulation'" class="btn-blue"><br><br>
        <form id="simulating" name="simulating" action="/simulating/flights" method="post">
            Simulating current time: <input type="datetime-local" id="simulationTime" name="simulationTime"
                                            class="text_field" value="${time}" ><br><br>
            Simulating airport: <input type="text" id="simulationAirport" name="simulationAirport"
                                       value="${airport}" class="text_field" readonly><br><br>
        </form>

        <div id="map" style="width: auto; height: 400px" align="center"></div><br>

        <table class="table" id="nowFlights" align="center" valign="center">
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
                <th scope="col">New arrival time</th>
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
                    <td align="center" valign="center">${item.newArrivalTime}</td>
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

    setTimeout("simulating.submit();", 5000);

    function initialize() {

        var mapOptions = {
            center: new google.maps.LatLng(52.5200, 13.4050),
            zoom: 4,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };

        var map = new google.maps.Map(document.getElementById("map"), mapOptions);

        var airports = [{lat: 51.5074, lng: 0.1278}, {lat: 48.8566, lng: 2.3522}, {lat: 52.5200, lng: 13.4050}, {lat: 52.3667, lng: 4.8945},
                        {lat: 60.1699, lng: 24.9384}, {lat: 50.1109, lng: 8.6821}, {lat: 41.0082, lng: 28.9784}, {lat: 48.1351, lng: 11.5820},
                        {lat: 41.9028, lng: 12.4964}, {lat: 55.7558, lng: 37.6173}];

        var names = ["London", "Paris", "Berlin", "Amsterdam", "Helsinki", "Frankfurt", "Istanbul", "Munich", "Rome", "Moscow"];

        for (var i = 0; i < airports.length; i++){
            var marker1 = new google.maps.Marker({
                position: airports[i],

                map: map,

                label: names[i]
            });

        }

        var airplanes = [<c:forEach items="${simulationFlights}" var="planes">
            {
               lat: "${planes.lat}",
               lng: "${planes.lng}",
               number: "${planes.flightNumber}"
            },
            </c:forEach> ];

        var positions = [];
        var numbers = [];
        for (var j = 0; j < airplanes.length; j++){
            var latLng = new google.maps.LatLng(airplanes[j].lat, airplanes[j].lng);
            positions.push(latLng);
            numbers.push(airplanes[j].number);
        }

        var markers = [];
        var infowindows = [];
        for (var k = 0; k < positions.length; k++){
            var marker2 = new google.maps.Marker({
                position: positions[k],

                map: map,

                icon: "../../images/airplane.png",
            });

            var infowindow = new google.maps.InfoWindow({
                content: "flight: " + numbers[k]
            });

            markers.push(marker2);
            infowindows.push(infowindow);

        }

        for (var l = 0; l < markers.length; l++){
            google.maps.event.addListener(markers[l], 'click', function (innerkey) {
                return function(){
                    infowindows[innerkey].open(map, markers[innerkey]);
                }
            }(l));
        }


    }
</script>
</html>
