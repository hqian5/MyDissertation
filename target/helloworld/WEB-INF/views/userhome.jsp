<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 08/07/2019
  Time: 00:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<html>--%>
<%--<head>--%>
<%--    <title>User homepage</title>--%>
<%--    <link rel='stylesheet' href='../../css/login.css' />--%>
<%--    <script src = 'https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js'></script>--%>
<%--    <script src='https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js'></script>--%>
<%--    <script src="http://code.jquery.com/jquery-1.11.1.js"></script>--%>
<%--    <link rel="stylesheet" href="../../bootstrap-4.3.1-dist/css/bootstrap.min.css">--%>
<%--    <script src="../../bootstrap-4.3.1-dist/js/bootstrap.min.js"></script>--%>
<%--    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />--%>
<%--</head>--%>

<%--<body>--%>
<%--<div id="tracker" class="container">--%>
<%--    <div id="login_frame">--%>

<%--        <div class="row">--%>
<%--            <div class="col-md">--%>
<%--                <form id="flightSearch" action="/search/flight" method="post">--%>
<%--                    Please track your flight by typing the flight number--%>
<%--                    <br><input type="text" required id="flight_no" name="flight_no" class="text_field"><br><br>--%>
<%--                    <input type="submit" value="Track" class="btn-blue">--%>
<%--                </form>--%>

<%--                <form id="buyTickets" action="/buy/tickets" method="post">--%>
<%--                    <h2>Please search tickets</h2>--%>
<%--                    Departure date:--%>
<%--                    <br><input type="date" id="ticketDate" name="ticketDate" class="text_field" required><br>--%>
<%--                    Departure from:--%>
<%--                    <br><select id="ticketFrom" name="ticketFrom" class="text_field">--%>
<%--                    <option value="London">London</option>--%>
<%--                    <option value="Paris">Paris</option>--%>
<%--                    <option value="Berlin">Berlin</option>--%>
<%--                    <option value="Amsterdam">Amsterdam</option>--%>
<%--                    <option value="Helsinki">Helsinki</option>--%>
<%--                    <option value="Frankfurt">Frankfurt</option>--%>
<%--                    <option value="Istanbul">Istanbul</option>--%>
<%--                    <option value="Munich">Munich</option>--%>
<%--                    <option value="Rome">Rome</option>--%>
<%--                    <option value="Moscow">Moscow</option>--%>
<%--                </select><br>--%>
<%--                    To:--%>
<%--                    <br><select id="ticketTo" name="ticketTo" class="text_field">--%>
<%--                    <option value="London">London</option>--%>
<%--                    <option value="Paris">Paris</option>--%>
<%--                    <option value="Berlin">Berlin</option>--%>
<%--                    <option value="Amsterdam">Amsterdam</option>--%>
<%--                    <option value="Helsinki">Helsinki</option>--%>
<%--                    <option value="Frankfurt">Frankfurt</option>--%>
<%--                    <option value="Istanbul">Istanbul</option>--%>
<%--                    <option value="Munich">Munich</option>--%>
<%--                    <option value="Rome">Rome</option>--%>
<%--                    <option value="Moscow">Moscow</option>--%>
<%--                </select><br><br>--%>
<%--                    <input type="submit" value="Search" class="btn-blue">--%>
<%--                </form>--%>

<%--                <h2>Manage your trips</h2>--%>
<%--                <form id="userManage" action="/user/manage" method="post">--%>
<%--                    <input type="number" id="manageId" name="manageId" value="${user.userid}" style="display: none">--%>
<%--                    <input type="submit" value="My trips" class="btn-blue"><br><br>--%>
<%--                    <input type="button" value="log out" onclick="location.href='/user/logout'" class="btn-blue">--%>
<%--                </form>--%>
<%--                <br><br>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>

<%--<div id="result" class="container" style="display: none">--%>
<%--    <h2>Please check the flight information</h2>--%>
<%--    <div class="row">--%>
<%--        <div class="col-md">--%>
<%--            <label id="flightNumber" class="label_input"></label><br>--%>
<%--            <label id="departureTime" class="label_input"></label><br>--%>
<%--            <label id="arrivalTime" class="label_input"></label><br>--%>
<%--            <label id="departureAirport" class="label_input"></label><br>--%>
<%--            <label id="arrivalAirport" class="label_input"></label><br>--%>
<%--            <label id="flightStatus" class="label_input"></label><br>--%>
<%--            <br><input type="button" value="refresh" class="btn-blue" onclick="retrack()">--%>
<%--            <input type="button" value="Back" class="btn-blue" onclick="location.href='/user/home'">--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>

<%--<div id="manage_frame" class="container" style="display: none">--%>
<%--    <h2>Please check the tickets</h2>--%>
<%--    <div class="row">--%>
<%--        <div class="col-md">--%>
<%--            <table class="table" id="tickets" align="center" valign="center">--%>
<%--                <thead class="thead-dark">--%>
<%--                <tr>--%>
<%--                    <th scope="col" style="display: none">ID</th>--%>
<%--                    <th scope="col">Flight number</th>--%>
<%--                    <th scope="col">Departure time</th>--%>
<%--                    <th scope="col">From</th>--%>
<%--                    <th scope="col">To</th>--%>
<%--                    <th scope="col">Arrival airport</th>--%>
<%--                    <th scope="col">Seat number</th>--%>
<%--                    <th scope="col">Available seat number</th>--%>
<%--                    <th scope="col">Price</th>--%>
<%--                    <th scope="col">Buy</th>--%>
<%--                    &lt;%&ndash;            <th scope="col" align="center" valign="center">Status</th>&ndash;%&gt;--%>
<%--                </tr>--%>
<%--                </thead>--%>
<%--                <tbody>--%>
<%--                <c:forEach varStatus="s" items="${tickets}" var="item">--%>
<%--                    <tr>--%>
<%--                        <td align="center" valign="center" style="display: none">${item.flightid}</td>--%>
<%--                        <td align="center" valign="center">${item.flightNumber}</td>--%>
<%--                        <td align="center" valign="center">${item.departureTime}</td>--%>
<%--                        <td align="center" valign="center">${item.arrivalTime}</td>--%>
<%--                        <td align="center" valign="center">${item.departureAirport}</td>--%>
<%--                        <td align="center" valign="center">${item.arrivalAirport}</td>--%>
<%--                        <td align="center" valign="center">${item.seatNumber}</td>--%>
<%--                        <td align="center" valign="center">${item.seatFree}</td>--%>
<%--                        <td align="center" valign="center">${item.price}</td>--%>
<%--                        <td align="center" valign="center">--%>
<%--                            <input type="button" value="Buy" class="btn-blue" onclick="confirmBuy();--%>
<%--                            document.getElementById('confirmId').value = '${item.flightid}';--%>
<%--                            document.getElementById('userId').value = '${user.userid}';--%>
<%--                            document.getElementById('confirmFlight').value = '${item.flightNumber}';">--%>
<%--                        </td>--%>
<%--                            &lt;%&ndash;                <td align="center" valign="center">${item.flightStatus}</td>&ndash;%&gt;--%>
<%--                    </tr>--%>
<%--                </c:forEach>--%>
<%--                </tbody>--%>
<%--            </table>--%>

<%--            <form id="buyConfirm" action="/buy/confirm" method="post" style="display: none">--%>
<%--                <input type="number" id="confirmId" name="confirmId" class="text_field" style="display: none" readonly required>--%>
<%--                <input type="number" id="userId" name="userId" class="text_field" style="display: none" readonly required><br>--%>
<%--                Confirm flight number:--%>
<%--                <br><input type="text" id="confirmFlight" name="confirmFlight" class="text_field" style="width: 90px" readonly required><br><br>--%>
<%--                <input type="submit" value="Confirm" class="btn-blue">--%>
<%--                <input type="button" value="Cancel" class="btn-blue" onclick="showTickets()">--%>
<%--            </form>--%>

<%--            <input type="button" value="Homepage" class="btn-blue" onclick="showHome()">--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>

<%--</body>--%>

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
                    <a href="javascript:void(0)" onclick="buyArea()">Buy tickets</a>
                </li>

                <li>
                    <a href="/user/manage">Manage trips</a>
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
        <div class="page-banner__container animated fadeInUp">
            <div class="page-banner__textcontent t-center">
                <c:if test="${not empty user}">
                    <h2 class="page-banner__title c-primary">${user.username}, welcome to Birds Tracker</h2>
                </c:if>
            </div><!-- .page-banner__textcontent -->
        </div>

        <div class="page-banner__container animated fadeInUp">


            <div id="tracker" class="main-search-container">
                <div class="page-banner__textcontent t-center">
                    <h2 class="page-banner__title c-primary">Track A Flight</h2>
                </div><!-- .page-banner__textcontent -->

                <form class="main-search main-search--layout-1 bg-mirage"
                      id="flightSearch" action="/user/search" method="post">
                    <div class="main-search__group main-search__group--primary">
                        <label for="flight_no" class="c-white">Flight number</label>
                        <input type="text" required id="flight_no" name="flight_no" class="form-input" placeholder="A valid flight number">
                    </div><!-- .main-search__group -->

                    <div class="main-search__group main-search__group--tertiary">
                        <button type="submit" class="button button--medium button--square button--primary">
                            <i class="fa"></i> Search
                        </button>
                    </div>
                </form>
            </div><!-- .main-search-container -->

            <div id="result" class="main-search-container main-search main-search--layout-1 bg-mirage" style="display: none">
                <div class="main-search__group main-search__group--primary">
                    <h3>Please check the flight</h3>
                    <label id="flightNumber" class="c-white"></label><br>
                    <label id="departureTime" class="c-white"></label><br>
                    <label id="arrivalTime" class="c-white"></label><br>
                    <label id="departureAirport" class="c-white"></label><br>
                    <label id="arrivalAirport" class="c-white"></label><br>
                    <label id="flightStatus" class="c-white"></label><br>
                </div>

                <div class="main-search__group main-search__group--tertiary">
                    <button type="button" class="button button--medium button--square button--primary" onclick="retrack()">
                        <i class="fa"></i> Refresh
                    </button>
                </div>
                <div class="main-search__group main-search__group--tertiary">
                    <button type="button" class="button button--medium button--square button--primary" onclick="backSearch()">
                        <i class="fa"></i> Back
                    </button>
                </div>
            </div>

            <div id="buyArea" class="page-banner__container animated fadeInUp" style="display: none">
                <div class="page-banner__textcontent t-center">
                    <h2 class="page-banner__title c-primary">Search Tickets</h2>
                </div><!-- .page-banner__textcontent -->

                <div id="buy" class="main-search-container">
                    <form class="main-search main-search--layout-1 bg-mirage"
                          id="buyTickets" action="/buy/tickets" method="post">
                        <div class="main-search__group main-search__group--primary">
                            <label for="ticketDate" class="c-white">Departure date</label>
                            <input type="date" required id="ticketDate" name="ticketDate" class="form-input">
                        </div><!-- .main-search__group -->

                        <div class="main-search__group main-search__group--primary">
                            <label for="ticketFrom" class="c-white">From</label>
                            <select required id="ticketFrom" name="ticketFrom" class="form-input">
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
                        </div><!-- .main-search__group -->

                        <div class="main-search__group main-search__group--primary">
                            <label for="ticketTo" class="c-white">To</label>
                            <select required id="ticketTo" name="ticketTo" class="form-input">
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
                        </div><!-- .main-search__group -->

                        <div class="main-search__group main-search__group--tertiary">
                            <button type="submit" class="button button--medium button--square button--primary">
                                <i class="fa"></i> Search
                            </button>
                        </div>

                        <div class="main-search__group main-search__group--tertiary">
                            <button type="button" class="button button--medium button--square button--primary" onclick="cancelBuy()">
                                <i class="fa"></i> Cancel
                            </button>
                        </div>
                    </form>
                </div><!-- .main-search-container -->
            </div>

            <div id="manage_frame" class="page-banner__container animated fadeInLeft" style="display: none">
                <div class="page-banner__textcontent t-center">
                    <h2 class="page-banner__title c-primary">Available Tickets</h2>
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
                            <th scope="col" class="c-white">Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach varStatus="s" items="${tickets}" var="item">
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
                                <div class="main-search__group">
                                    <input type="button" value="Cancel" onclick="cancelBuy2()"
                                           class="button button--medium button--square button--primary">
                                </div>
                            </td>
                        </tbody>
                        </c:forEach>
                    </table>
                </div>
            </div>
            <%--<div id="manage_frame" class="container" style="display: none">--%>
            <%--    <h2>Please check the tickets</h2>--%>
            <%--    <div class="row">--%>
            <%--        <div class="col-md">--%>
            <%--            <table class="table" id="tickets" align="center" valign="center">--%>
            <%--                <thead class="thead-dark">--%>
            <%--                <tr>--%>
            <%--                    <th scope="col" style="display: none">ID</th>--%>
            <%--                    <th scope="col">Flight number</th>--%>
            <%--                    <th scope="col">Departure time</th>--%>
            <%--                    <th scope="col">From</th>--%>
            <%--                    <th scope="col">To</th>--%>
            <%--                    <th scope="col">Arrival airport</th>--%>
            <%--                    <th scope="col">Seat number</th>--%>
            <%--                    <th scope="col">Available seat number</th>--%>
            <%--                    <th scope="col">Price</th>--%>
            <%--                    <th scope="col">Buy</th>--%>
            <%--                    &lt;%&ndash;            <th scope="col" align="center" valign="center">Status</th>&ndash;%&gt;--%>
            <%--                </tr>--%>
            <%--                </thead>--%>
            <%--                <tbody>--%>
            <%--                <c:forEach varStatus="s" items="${tickets}" var="item">--%>
            <%--                    <tr>--%>
            <%--                        <td align="center" valign="center" style="display: none">${item.flightid}</td>--%>
            <%--                        <td align="center" valign="center">${item.flightNumber}</td>--%>
            <%--                        <td align="center" valign="center">${item.departureTime}</td>--%>
            <%--                        <td align="center" valign="center">${item.arrivalTime}</td>--%>
            <%--                        <td align="center" valign="center">${item.departureAirport}</td>--%>
            <%--                        <td align="center" valign="center">${item.arrivalAirport}</td>--%>
            <%--                        <td align="center" valign="center">${item.seatNumber}</td>--%>
            <%--                        <td align="center" valign="center">${item.seatFree}</td>--%>
            <%--                        <td align="center" valign="center">${item.price}</td>--%>
            <%--                        <td align="center" valign="center">--%>
            <%--                            <input type="button" value="Buy" class="btn-blue" onclick="confirmBuy();--%>
<%--                                        document.getElementById('confirmId').value = '${item.flightid}';--%>
<%--                                        document.getElementById('userId').value = '${user.userid}';--%>
<%--                                        document.getElementById('confirmFlight').value = '${item.flightNumber}';">--%>
            <%--                        </td>--%>
<%--                                                        <td align="center" valign="center">${item.flightStatus}</td>--%>
            <%--                    </tr>--%>
            <%--                </c:forEach>--%>
            <%--                </tbody>--%>
            <%--            </table>--%>

        </div><!-- .page-banner__container -->
    </div><!-- .container -->
</section><!-- .page-banner -->

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

    function backSearch() {
        var result = document.getElementById("result");
        var tracker = document.getElementById("tracker");
        result.style.display = "none";
        tracker.style.display = "";
    }

    function buyArea() {
        document.getElementById("buyArea").style.display = "";
    }

    function cancelBuy() {
        document.getElementById("buyArea").style.display = "none";
    }

    function cancelBuy2() {
        document.getElementById("manage_frame").style.display = "none";
        document.getElementById("tracker").style.display = "";
        document.getElementById("buyArea").style.display = "";
    }
</script>
</html>
