<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 24/07/2019
  Time: 15:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge, chrome=1">
    <title>User Home</title>
    <link href="https://fonts.googleapis.com/css?family=Cabin:400,600" rel="stylesheet">
    <link rel="stylesheet" href="/css/style.css">
</head>

<style>
    body{
        background-image: url("../../images/background3.jpg");
        background-size: 100%;
        background-repeat: repeat;
    }
</style>

<body onload="checkOptions()">
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
                    <a href="/user/home">User Home</a>
                </li>

                <li>
                    <a href="/user/logout">Log out</a>
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
    <div class="container">
        <div class="page-banner__container animated fadeInRight">
            <div class="page-banner__textcontent t-center">
                <c:if test="${not empty user}">
                    <h2 class="page-banner__title c-primary">${user.username}, welcome to Birds Tracker</h2>
                    <p class="page-banner__subtitle c-primary">We are your flights manager~</p>
                </c:if>
            </div><!-- .page-banner__textcontent -->
        </div>

        <div id="trips" class="page-banner__container animated fadeInLeft">
            <div class="page-banner__textcontent t-center">
                <h2 class="page-banner__title c-primary">Your trips</h2>
            </div><!-- .page-banner__textcontent -->

            <div id="userTrips" class="main-search-container">
                <table class="listing-table">
                    <thead>
                    <tr class="listing-row c-white bg-primary">
                        <th scope="col" class="c-white" style="display: none">ID</th>
                        <th scope="col" class="c-white">Flight number</th>
                        <th scope="col" class="c-white">Departure time</th>
                        <th scope="col" class="c-white">Arrival time</th>
                        <th scope="col" class="c-white">From</th>
                        <th scope="col" class="c-white">To</th>
                        <th scope="col" class="c-white">Status</th>
                        <th scope="col" class="c-white">New Arrival time</th>
                        <th scope="col" class="c-white">Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach varStatus="s" items="${trips}" var="item">
                    <tr class="main-search main-search--layout-2 bg-mirage">
                        <td class="c-white" style="display: none">${item.flightid}</td>
                        <td class="c-white">${item.flightNumber}</td>
                        <td class="c-white">${item.departureTime}</td>
                        <td class="c-white">${item.arrivalTime}</td>
                        <td class="c-white">${item.departureAirport}</td>
                        <td class="c-white">${item.arrivalAirport}</td>
                        <td class="c-white">${item.flightStatus}</td>
                        <td class="c-white">${item.newArrivalTime}</td>
                        <c:choose>
                        <c:when test="${item.flightStatus != 'On time'}">
                        <td>
                            <div class="main-search__group">
                                <input type="button" value="Optional flights"
                                       onclick="document.getElementById('date').value = '${item.departureTime}';
                                               document.getElementById('flightId').value = '${item.flightid}';
                                               document.getElementById('departure').value = '${item.departureAirport}';
                                               document.getElementById('arrival').value = '${item.arrivalAirport}';
                                               optionalFlights();"
                                       class="button button--medium button--square button--primary">
                            </div>
                        </td>
                        </c:when>
                        <c:otherwise>
                        <td>
                            <div class="main-search__group">
                            </div>
                        </td>
                        </c:otherwise>
                        </c:choose>
                    </tbody>
                    </c:forEach>
                </table>

                <form id="optionalConfirm" name="optionalConfirm" action="/optional/confirm" method="post" style="display: none">
                    <input type="number" id="flightId" name="flightId" readonly required>
                    <input type="text" id="date" name="date" readonly required>
                    <input type="text" id="departure" name="departure" readonly required>
                    <input type="text" id="arrival" name="arrival" readonly required>
                </form>
            </div>
        </div>

        <div id="option" class="page-banner__container animated fadeInRight">
            <div class="page-banner__textcontent t-center">
                <h2 class="page-banner__title c-primary">Optional Tickets</h2>
            </div><!-- .page-banner__textcontent -->

            <div id="manageFlights" class="main-search-container">
                <table class="listing-table">
                    <thead>
                    <tr class="listing-row c-white bg-primary">
                        <th scope="col" class="c-white" style="display: none">ID</th>
                        <th scope="col" class="c-white">Flight number</th>
                        <th scope="col" class="c-white">Departure time</th>
                        <th scope="col" class="c-white">Arrival time</th>
                        <th scope="col" class="c-white">From</th>
                        <th scope="col" class="c-white">To</th>
                        <th scope="col" class="c-white">Seat number</th>
                        <th scope="col" class="c-white">Available seat number</th>
                        <th scope="col" class="c-white">Price</th>
                        <th scope="col" class="c-white">Status</th>
                        <th scope="col" class="c-white">New Arrival time</th>
                        <th scope="col" class="c-white">Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach varStatus="s" items="${options}" var="item">
                    <tr class="main-search main-search--layout-2 bg-mirage">
                        <td class="c-white" style="display: none">${item.flightid}</td>
                        <td class="c-white">${item.flightNumber}</td>
                        <td class="c-white">${item.departureTime}</td>
                        <td class="c-white">${item.arrivalTime}</td>
                        <td class="c-white">${item.departureAirport}</td>
                        <td class="c-white">${item.arrivalAirport}</td>
                        <td class="c-white">${item.seatNumber}</td>
                        <td class="c-white">${item.seatFree}</td>
                        <td class="c-white" align="center">${item.price}</td>
                        <td class="c-white">${item.flightStatus}</td>
                        <td class="c-white">${item.newArrivalTime}</td>
                        <td>
                            <div class="main-search__group">
                                <input type="button" value="Buy" onclick="confirmBuy();
                                        document.getElementById('confirmId').value = '${item.flightid}';
                                        document.getElementById('userId').value = '${user.userid}';
                                        document.getElementById('confirmFlight').value = '${item.flightNumber}';"
                                       class="button button--medium button--square button--primary">
                            </div>
                        </td>
                    </tbody>
                    </c:forEach>
                </table>
                <div class="main-search__group" style="margin-left: 45%">
                    <input type="button" value="Cancel" onclick="showTrips()"
                           class="button button--medium button--square button--primary">
                </div>
            </div>
        </div>

        <div id="buyConfirm" class="container"  style="display: none">
            <div class="page-banner__container animated fadeInLeft">
                <div class="page-banner__textcontent t-center">
                    <h2 class="page-banner__title c-primary">Purchase Confirm</h2>
                </div><!-- .page-banner__textcontent -->

                <div id="confirm" class="main-search-container">
                    <form action="/buy/options" method="post" class="main-search main-search--layout-1 bg-mirage">
                        <div class="main-search__group main-search__group--primary" style="display: none">
                            <input
                                    type="number" id="confirmId" name="confirmId"
                                    required readonly style="width: 100px"
                                    class="form-input"
                            >
                        </div><!-- .form-group -->

                        <div class="main-search__group main-search__group--primary" style="display: none">
                            <input
                                    type="number" id="userId" name="userId"
                                    required readonly style="width: 100px"
                                    class="form-input"
                            >
                        </div><!-- .form-group -->

                        <div class="main-search__group main-search__group--primary">
                            <label for="confirmFlight" class="c-white">Confirm the flight number:</label>
                            <input
                                    type="text" id="confirmFlight" name="confirmFlight"
                                    required readonly style="width: 100px"
                                    class="form-input"
                            >
                        </div><!-- .form-group -->

                        <div class="main-search__group main-search__group--tertiary">
                            <button
                                    class="button button--medium button--square button--primary"
                                    type="submit"
                            >
                                Buy
                            </button>
                        </div>

                        <div class="main-search__group main-search__group--tertiary">
                            <button
                                    class="button button--medium button--square button--primary"
                                    type="button"
                                    onclick="showTickets()"
                            >
                                Cancel
                            </button>
                        </div>
                    </form>
                </div>
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
