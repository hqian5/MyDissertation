<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 18/07/2019
  Time: 01:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge, chrome=1">
    <title>Flights Simulation</title>
    <link href="https://fonts.googleapis.com/css?family=Cabin:400,600" rel="stylesheet">
    <link rel="stylesheet" href="/css/style.css">
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAmLG_UuFMteDLB4pVVO7yR7CCAb6pTGjc"></script>
</head>

<style>
    body{
        background-image: url("../../images/background6.jpg");
        background-size: 100%;
        background-repeat: repeat;
    }
</style>

<body onload="initialize()">
<header id="masthead" class="site-header site-header--fluid bg-primary">
    <div class="d-lg-flex justify-content-lg-between align-items-lg-center site-header__container">
        <div class="d-lg-flex align-items-lg-center">
            <div class="site-header__logo">
                <a href="/back/index">
                    <h1 class="screen-reader-text">BirdsTracker</h1>
                    <img src="/images/headerlogo.png" alt="BirdsTracker">
                </a>
            </div><!-- .site-header__logo -->
        </div>

        <div class="d-lg-flex align-items-lg-center">
            <ul class="min-list main-navigation main-navigation--white">
                <li>
                    <a href="/manage/flights">Manage flights</a>
                </li>

                <li>
                    <a href="/input/flight">Input flights</a>
                </li>

                <li>
                    <a href="/admin/logout">Log out</a>
                </li>
            </ul><!-- .main-navigation -->
        </div>

        <div class="d-lg-none nav-mobile">
            <a href="#" class="nav-toggle js-nav-toggle nav-toggle--dove-gray">
                <span></span>
            </a><!-- .nav-toggle -->
        </div><!-- .nav-mobile -->
    </div><!-- .site-header__container -->
</header><!-- #masthead -->

<div class="d-xl-flex">
    <div class="order-xl-1 listing-column listing-column--xl-50 listing-column--map js-map-container">
        <div id="map" class="map"></div>
    </div>

    <div class="order-xl-0 listing-column listing-column--xl-50 listing-column--content">
        <div id="simulation" class="container">
            <div class="page-banner__container animated fadeInUp">
                <div class="page-banner__textcontent t-center">
                    <h2 class="page-banner__title c-primary">Simulating Flights</h2>
                </div><!-- .page-banner__textcontent -->

                <div id="simulatingFlight" class="main-search-container">
                    <form id="simulating" name="simulating" action="/simulating/flights" method="post"
                          class="main-search main-search--layout-1 bg-mirage">
                        <div class="main-search__group main-search__group--primary">
                            <label for="simulationTime" class="c-white">Simulating current time</label>
                            <input
                                    type="datetime-local" id="simulationTime" name="simulationTime"
                                    value="${time}"
                                    class="form-input"
                            >
                        </div><!-- .form-group -->

                        <div class="main-search__group main-search__group--primary">
                            <label for="simulationAirport" class="c-white">Simulated airport</label>
                            <input
                                    type="text" id="simulationAirport" name="simulationAirport"
                                    value="${airport}" readonly
                                    class="form-input"
                            >
                        </div><!-- .form-group -->

                        <div class="main-search__group main-search__group--tertiary">
                            <button
                                    class="button button--medium button--square button--primary"
                                    type="button" onclick="location.href='/stop/simulation'"
                            >
                                Stop
                            </button>
                        </div>
                    </form>
                </div>

                <div id="Flights"  class="main-search-container">
                    <table id="nowFlights" class="listing-table">
                        <thead>
                        <tr class="listing-row c-white bg-primary">
                            <th scope="col" class="c-white">ID</th>
                            <th scope="col" class="c-white">Flight number</th>
                            <th scope="col" class="c-white">Departure time</th>
                            <th scope="col" class="c-white">Arrival time</th>
                            <th scope="col" class="c-white">Departure airport</th>
                            <th scope="col" class="c-white">Arrival airport</th>
                            <th scope="col" class="c-white">Status</th>
                            <th scope="col" class="c-white">New arrival time</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach varStatus="s" items="${simulationFlights}" var="item">
                        <tr class="main-search main-search--layout-2 bg-mirage">
                            <td class="c-white" align="center">${item.flightid}</td>
                            <td class="c-white">${item.flightNumber}</td>
                            <td class="c-white">${item.departureTime}</td>
                            <td class="c-white">${item.arrivalTime}</td>
                            <td class="c-white">${item.departureAirport}</td>
                            <td class="c-white">${item.arrivalAirport}</td>
                            <td class="c-white" align="center">${item.flightStatus}</td>
                            <td class="c-white" align="center">${item.newArrivalTime}</td>
                        </tr>
                        </tbody>
                        </c:forEach>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<footer id="colophone" class="site-footer">
    <div class="t-center site-footer__primary">
        <div class="container">
            <div class="site-footer__logo">
                <a href="/back/index">
                    <h1 class="screen-reader-text">BirdsTracker</h1>
                    <img src="/images/headerlogo.png" alt="BirdsTracker">
                </a>
            </div>
            <p class="t-small">BirdsTracker is your flights manager</p>
        </div>
    </div>
    <!-- .site-footer__primary -->
</footer><!-- #colophone -->

<script src="https://cdn.rawgit.com/googlemaps/v3-utility-library/master/infobox/src/infobox.js"></script>
<script src="/js/app.js"></script>
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

    setTimeout("simulating.submit();", 10000);

    function initialize() {

        var mapOptions = {
            center: new google.maps.LatLng(48.2082, 16.3738),
            zoom: 4.5,
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
