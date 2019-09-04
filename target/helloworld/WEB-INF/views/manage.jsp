<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 11/07/2019
  Time: 17:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge, chrome=1">
    <title>Manage Flights</title>
    <link href="https://fonts.googleapis.com/css?family=Cabin:400,600" rel="stylesheet">
    <link rel="stylesheet" href="/css/style.css">
</head>

<style>
    body{
        background-image: url("../../images/background4.jpg");
        background-size: 100%;
        background-repeat: repeat;
    }
</style>

<body>
<header id="masthead" class="site-header site-header--layout-1 site-header--fluid site-header--absolute">
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
            <ul class="min-list main-navigation">
                <li>
                    <a href="javascript:void(0)" onclick="showAll5()">Manage flights</a>
                </li>

                <li>
                    <a href="javascript:void(0)" onclick="showSimulation()">Flights simulation</a>
                </li>

                <li>
                    <a href="/back/adminhome">Input flights</a>
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

<section class="page-banner page-banner--layout-1 parallax">
    <c:if test="${empty flights}">
        <div class="container" onplay="noData()">
            <div class="page-banner__container animated fadeInLeft">
                <div class="page-banner__textcontent t-center">
                    <h2 class="page-banner__title c-primary">There is no data</h2>
                </div><!-- .page-banner__textcontent -->
            </div>
        </div>
    </c:if>

    <div id="allFlights" class="container">
        <div class="page-banner__container animated fadeInLeft">
            <div class="page-banner__textcontent t-center">
                <h2 class="page-banner__title c-primary">Manage Flights</h2>
            </div><!-- .page-banner__textcontent -->

            <div id="manageFlights" class="main-search-container">
                <table class="listing-table">
                    <thead>
                    <tr class="listing-row c-white bg-primary">
                        <th scope="col" class="c-white">ID</th>
                        <th scope="col" class="c-white">Flight number</th>
                        <th scope="col" class="c-white">Departure time</th>
                        <th scope="col" class="c-white">Arrival time</th>
                        <th scope="col" class="c-white">Departure airport</th>
                        <th scope="col" class="c-white">Arrival airport</th>
                        <th scope="col" class="c-white">Seat number</th>
                        <th scope="col" class="c-white">Available seat number</th>
                        <th scope="col" class="c-white">Price</th>
                        <th scope="col" class="c-white">Status</th>
                        <th scope="col" class="c-white">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach varStatus="s" items="${flights}" var="item">
                    <tr class="main-search main-search--layout-2 bg-mirage">
                        <td class="c-white" align="center">${item.flightid}</td>
                        <td class="c-white">${item.flightNumber}</td>
                        <td class="c-white">${item.departureTime}</td>
                        <td class="c-white">${item.arrivalTime}</td>
                        <td class="c-white">${item.departureAirport}</td>
                        <td class="c-white">${item.arrivalAirport}</td>
                        <td class="c-white">${item.seatNumber}</td>
                        <td class="c-white">${item.seatFree}</td>
                        <td class="c-white" align="center">${item.price}</td>
                        <td class="c-white" align="center">${item.flightStatus}</td>
                        <td>
                            <div class="main-search__group">
                                <input type="button" value="update" onclick="showId2();
                                        document.getElementById('flightId_up').value = '${item.flightid}'"
                                       class="button button--medium button--square button--primary">
                            </div>
                            <div class="main-search__group">
                                <input type="button" value="delete" onclick="showId();
                                        document.getElementById('flightId').value = '${item.flightid}'"
                                       class="button button--medium button--square button--primary">
                            </div>
                            <div class="main-search__group">
                                <input type="button" value="multi-delete"
                                       onclick="document.getElementById('middle').value = '${item.flightid}';showId3()"
                                       class="button button--medium button--square button--primary">
                            </div>
                        </td>
                    </tr>
                    </tbody>
                    </c:forEach>
                </table>
            </div>
        </div>
    </div>

    <div id="deleteId" class="container"  style="display: none">
        <div class="page-banner__container animated fadeInRight">
            <div class="page-banner__textcontent t-center">
                <h2 class="page-banner__title c-primary">Deletion Confirm</h2>
            </div><!-- .page-banner__textcontent -->

            <div id="deleteFlight" class="main-search-container">
                <form action="/delete/flight" method="post" class="main-search main-search--layout-1 bg-mirage">
                    <div class="main-search__group main-search__group--primary">
                        <label for="flightId" class="c-white">Confirm deletion id</label>
                        <input
                                type="text"
                                required readonly id="flightId" name="flightId" style="width: 100px"
                                class="form-input"
                        >
                    </div><!-- .form-group -->

                    <div class="main-search__group main-search__group--tertiary">
                        <button
                                class="button button--medium button--square button--primary"
                                type="submit"
                        >
                            Confirm
                        </button>
                    </div>

                    <div class="main-search__group main-search__group--tertiary">
                        <button
                                class="button button--medium button--square button--primary"
                                type="button"
                                onclick="showAll1()"
                        >
                            Cancel
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div id="updateId" class="container"  style="display: none">
        <div class="page-banner__container animated fadeInRight">
            <div class="page-banner__textcontent t-center">
                <h2 class="page-banner__title c-primary">Update Confirm</h2>
            </div><!-- .page-banner__textcontent -->

            <div id="updateFlight" class="main-search-container">
                <form action="/update/confirm" method="post" class="main-search main-search--layout-1 bg-mirage">
                    <div class="main-search__group main-search__group--primary">
                        <label for="flightId_up" class="c-white">Confirm update id</label>
                        <input
                                type="text"
                                required readonly id="flightId_up" name="flightId_up" style="width: 100px"
                                class="form-input"
                        >
                    </div><!-- .form-group -->

                    <div class="main-search__group main-search__group--tertiary">
                        <button
                                class="button button--medium button--square button--primary"
                                type="submit"
                        >
                            Begin update
                        </button>
                    </div>

                    <div class="main-search__group main-search__group--tertiary">
                        <button
                                class="button button--medium button--square button--primary"
                                type="button"
                                onclick="showAll2()"
                        >
                            Cancel
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div id="updateWindow" class="container" style="display: none">
        <div class="page-banner__container animated fadeInLeft">
            <div class="page-banner__textcontent t-center">
                <h2 class="page-banner__title c-primary">Update A Flight</h2>
            </div><!-- .page-banner__textcontent -->

            <div id="inputFlights" class="main-search-container">
                <form id="flightUpdate" action="/update/flight" method="post" class="main-search main-search--layout-2 bg-mirage">
                    <div class="main-search__group">
                        <label for="update_id" class="c-white">Flight id *</label>
                        <input
                                type="text"
                                required readonly id="update_id" name="update_id"
                                class="form-input" style="width: 100px;"
                        >
                    </div><!-- .form-group -->

                    <div class="main-search__group">
                        <label for="flight_number" class="c-white">Flight number *</label>
                        <input
                                type="text"
                                required readonly id="flight_number" name="flight_number"
                                class="form-input"
                        >
                    </div><!-- .form-group -->

                    <div class="main-search__group">
                        <label for="departure_time" class="c-white">Departure time *</label>
                        <input
                                type="datetime-local" required id="departure_time" name="departure_time"
                                class="form-input"
                                placeholder="Departure time and arrival time should be later than current time..."
                        >
                    </div><!-- .form-group -->

                    <div class="main-search__group">
                        <label for="arrival_time" class="c-white">Arrival time *</label>
                        <input
                                type="datetime-local" required id="arrival_time" name="arrival_time"
                                class="form-input"
                                placeholder="Arrival time should be later than departure time..."
                        >
                    </div><!-- .form-group -->

                    <div class="main-search__group">
                        <label for="departure_airport" class="c-white">Departure airport *</label>
                        <select
                                required id="departure_airport" name="departure_airport"
                                class="form-input"
                        >
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
                        </select>
                    </div><!-- .form-group -->

                    <div class="main-search__group">
                        <label for="arrival_airport" class="c-white">Arrival airport *</label>
                        <select
                                required id="arrival_airport" name="arrival_airport"
                                class="form-input"
                        >
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
                        </select>
                    </div><!-- .form-group -->

                    <div class="main-search__group">
                        <label for="seat_number" class="c-white">Seat number *</label>
                        <input
                                type="number" required id="seat_number" name="seat_number"
                                class="form-input"
                        >
                    </div><!-- .form-group -->

                    <div class="main-search__group">
                        <label for="seat_free" class="c-white">Available seat number *</label>
                        <input
                                type="number" required id="seat_free" name="seat_free"
                                class="form-input"
                                placeholder="Available seats should not be more than seats on the flight..."
                        >
                    </div><!-- .form-group -->

                    <div class="main-search__group">
                        <label for="price_up" class="c-white">Price *</label>
                        <input
                                type="number" required id="price_up" name="price_up"
                                class="form-input"
                                placeholder="The number of seats, available seats or price should be more than 0..."
                        >
                    </div><!-- .form-group -->

                    <div class="main-search__group">
                        <label for="flightStatus" class="c-white">Status *</label>
                        <select
                                required id="flightStatus" name="flightStatus"
                                class="form-input"
                        >
                            <option>On time</option>
                            <option>Delayed</option>
                            <option>Cancelled</option>
                        </select>
                    </div><!-- .form-group -->

                    <div class="main-search__group">
                        <button
                                class="button button--medium button--square button--primary"
                                type="submit"
                        >
                            Confirm update
                        </button>
                    </div>

                    <div class="main-search__group main-search__group--tertiary">
                        <button
                                class="button button--medium button--square button--primary"
                                type="button"
                                onclick="showAll()"
                        >
                            Cancel
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div id="multipleDelete" class="container"  style="display: none">
        <div class="page-banner__container animated fadeInRight">
            <div class="page-banner__textcontent t-center">
                <h2 class="page-banner__title c-primary">Multi-deletion Confirm</h2>
            </div><!-- .page-banner__textcontent -->

            <div id="multiDeleteFlight" class="main-search-container">
                <form action="/multiple/delete" method="post" class="main-search main-search--layout-1 bg-mirage">
                    <div class="main-search__group main-search__group--primary" style="display: none">
                        <input
                                type="text"
                                required readonly id="middle" name="middle" style="width: 100px"
                                class="form-input"
                        >
                    </div><!-- .form-group -->

                    <div class="main-search__group main-search__group--primary">
                        <label for="multipleId1" class="c-white">Delete data from:</label>
                        <input
                                type="text"
                                required readonly id="multipleId1" name="multipleId1" style="width: 100px"
                                class="form-input"
                        >
                    </div><!-- .form-group -->

                    <div class="main-search__group main-search__group--primary">
                        <label for="multipleId2" class="c-white">to:</label>
                        <input
                                type="text"
                                required readonly id="multipleId2" name="multipleId2" style="width: 100px"
                                class="form-input"
                        >
                    </div><!-- .form-group -->

                    <div class="main-search__group main-search__group--tertiary">
                        <button
                                class="button button--medium button--square button--primary"
                                type="submit"
                        >
                            Confirm
                        </button>
                    </div>

                    <div class="main-search__group main-search__group--tertiary">
                        <button
                                class="button button--medium button--square button--primary"
                                type="button"
                                onclick="showAll3()"
                        >
                            Cancel
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>


    <div id="selectSimulationAirport" class="container"  style="display: none">
        <div class="page-banner__container animated fadeInRight">
            <div class="page-banner__textcontent t-center">
                <h2 class="page-banner__title c-primary">Select Simulation Airport</h2>
            </div><!-- .page-banner__textcontent -->

            <div id="simulateFlight" class="main-search-container">
                <form action="/select/airport" method="post" class="main-search main-search--layout-1 bg-mirage">
                    <div class="main-search__group main-search__group--primary">
                        <label for="flightId" class="c-white">Select an airport</label>
                        <select
                                type="text"
                                required id="select_departure" name="select_departure"
                                class="form-input"
                        >
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
                        </select>
                    </div><!-- .form-group -->

                    <div class="main-search__group main-search__group--tertiary">
                        <button
                                class="button button--medium button--square button--primary"
                                type="submit"
                        >
                            Confirm
                        </button>
                    </div>

                    <div class="main-search__group main-search__group--tertiary">
                        <button
                                class="button button--medium button--square button--primary"
                                type="button"
                                onclick="showAll4()"
                        >
                            Cancel
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>

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
            document.getElementById("allFlights").style.display = "none";
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
        else if ('${status}' == 7){
            alert("Multiple delete successfully");
        }
        else if ('${status}' == 8){
            alert("Two ids are required");
        }
        else if ('${status}' == 9){
            alert("Simulation is over");
        }
        else if('${status}' == 10){
            alert("Simulation stopped");
        }
    }

    function showId() {
        document.getElementById("deleteId").style.display = "";
        document.getElementById("allFlights").style.display = "none";
    }

    function showId2() {
        document.getElementById("updateId").style.display = "";
        document.getElementById("allFlights").style.display = "none";
    }

    function showId3() {
        document.getElementById("multipleDelete").style.display = "";
        var middle = document.getElementById("middle").value;
        var multiple1 = document.getElementById("multipleId1").value;
        if (multiple1 == '' || multiple1 == null || multiple1 == undefined){
            document.getElementById("multipleId1").value = middle;
        }
        else {
            document.getElementById("multipleId2").value = middle;
            if (parseFloat(document.getElementById("multipleId1").value) >= parseFloat(document.getElementById("multipleId2").value)){
                alert("The second id should be more than the first one");
                document.getElementById("multipleId2").value = "";
            }
            else {
                document.getElementById("allFlights").style.display = "none";
            }
        }
    }

    function showAll() {
        document.getElementById("updateWindow").style.display = "none";
        document.getElementById("allFlights").style.display = "";
    }

    function showAll1() {
        document.getElementById("deleteId").style.display = "none";
        document.getElementById("allFlights").style.display = "";
    }

    function showAll2() {
        document.getElementById("updateId").style.display = "none";
        document.getElementById("allFlights").style.display = "";
    }

    function showAll3() {
        document.getElementById("multipleDelete").style.display = "none";
        document.getElementById("multipleId1").value = "";
        document.getElementById("multipleId2").value = "";
        document.getElementById("allFlights").style.display = "";
    }

    function showAll4() {
        document.getElementById("allFlights").style.display = "";
        document.getElementById("selectSimulationAirport").style.display = "none";
    }

    function showAll5() {
        document.getElementById("allFlights").style.display = "";
    }

    function showSimulation() {
        document.getElementById("allFlights").style.display = "none";
        document.getElementById("selectSimulationAirport").style.display = "";
    }

    function noData() {
        document.getElementById("allFlights").style.display = "none";
    }
</script>
</html>
