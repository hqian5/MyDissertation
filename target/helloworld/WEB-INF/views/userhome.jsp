<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 08/07/2019
  Time: 00:18
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
                    <a href="javascript:void(0)" onclick="manageSubmit()">Manage trips</a>
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
                    <p class="page-banner__subtitle c-primary">We are your flights manager~</p>
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

            <div id="buyConfirm" class="container"  style="display: none">
                <div class="page-banner__container animated fadeInRight">
                    <div class="page-banner__textcontent t-center">
                        <h2 class="page-banner__title c-primary">Purchase Confirm</h2>
                    </div><!-- .page-banner__textcontent -->

                    <div id="confirm" class="main-search-container">
                        <form action="/buy/confirm" method="post" class="main-search main-search--layout-1 bg-mirage">
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

            <form id="userManage" name="userManage" action="/user/manage" method="post" style="display: none">
                <input type="number" id="manageId" name="manageId" value="${user.userid}">
                <input type="submit" value="My trips" class="btn-blue"><br><br>
            </form>

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

    function manageSubmit() {
        document.forms["userManage"].submit();
    }
</script>
</html>
