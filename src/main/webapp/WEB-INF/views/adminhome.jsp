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
    <title>Admin Home</title>
    <link href="https://fonts.googleapis.com/css?family=Cabin:400,600" rel="stylesheet">
    <link rel="stylesheet" href="/css/style.css">
</head>

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
                    <a href="javascript:void(0)" onclick="hideForm()">Input flights</a>
                </li>

                <li>
                    <a href="javascript:void(0)" onclick="showForm()">Generate flights</a>
                </li>

                <li>
                    <a href="/manage/flights">Manage flights</a>
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

<section class="page-banner page-banner--layout-1 parallax" style="background-image: url('/images/background4.jpg')">
    <div id="input" class="container">
        <div class="page-banner__container animated zoomIn">
            <div class="page-banner__textcontent t-center">
                <h2 class="page-banner__title c-primary">Input Flights</h2>
            </div><!-- .page-banner__textcontent -->

            <div id="inputFlights" class="main-search-container">
                <form id="flightInput" action="/input/flight" method="post" class="main-search main-search--layout-2 bg-mirage">
                    <div class="main-search__group">
                        <label for="flight_number" class="c-white">Flight number *</label>
                        <input
                                type="text"
                                required id="flight_number" name="flight_number"
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
                        <label for="price" class="c-white">Price *</label>
                        <input
                                type="number" required id="price" name="price"
                                class="form-input"
                                placeholder="The number of seats, available seats or price should be more than 0..."
                        >
                    </div><!-- .form-group -->

                    <div class="main-search__group">
                        <label for="flight_status" class="c-white">Status *</label>
                        <select
                                required id="flight_status" name="flight_status"
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
                            Input
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div id="generate" class="container" style="display: none">
        <div class="page-banner__container animated fadeInDown">
            <div class="page-banner__textcontent t-center">
                <h2 class="page-banner__title c-primary">Generate Flights</h2>
            </div><!-- .page-banner__textcontent -->

            <div class="main-search-container">
                <form id="generateFlights" action="/generate/flights" method="post" class="main-search main-search--layout-2 bg-mirage">
                    <div class="main-search__group">
                        <label for="generateDate" class="c-white">Choose the date to generate *</label>
                        <input
                                type="date" required id="generateDate" name="generateDate"
                                class="form-input"
                        >
                    </div><!-- .form-group -->

                    <div class="main-search__group">
                        <label for="generateNumber" class="c-white">Choose the number to generate *</label>
                        <input
                                type="number" required id="generateNumber" name="generateNumber"
                                class="form-input"
                        >
                    </div><!-- .form-group -->

                    <div class="main-search__group">
                        <button
                                class="button button--medium button--square button--primary"
                                type="submit"
                        >
                            Generate
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
        else if ('${status}' == 4){
            alert("Flights generate successfully");
        }
        else if ('${status}' == 5){
            alert("Wrong date or number");
        }
    }

    function showForm() {
        document.getElementById("input").style.display = "none";
        document.getElementById("generate").style.display = "";
    }

    function hideForm() {
        document.getElementById("input").style.display = "";
        document.getElementById("generate").style.display = "none";
    }

</script>
</html>
