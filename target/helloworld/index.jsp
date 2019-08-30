<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge, chrome=1">
    <title>BirdsTracker</title>
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
                    <a href="/index/login">User login</a>
                </li>

                <li>
                    <a href="/index/admin">Admin login</a>
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
<section class="page-banner page-banner--layout-1 parallax" style="background-image: url('/images/background2.jpg')">
    <div class="container">
        <div class="page-banner__container animated fadeInUp">
            <div class="page-banner__textcontent t-center">
                <h2 class="page-banner__title c-primary">Birds tracker</h2>
                <p class="page-banner__subtitle c-primary">Track your flights by typing in a flight number~</p>
            </div><!-- .page-banner__textcontent -->

            <div id="tracker" class="main-search-container">
                <form class="main-search main-search--layout-1 bg-mirage"
                      id="flightSearch" action="/search/flight" method="post">
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

        </div><!-- .page-banner__container -->
    </div><!-- .container -->
</section><!-- .page-banner -->

<section class="instructions-container page-section bg-wild-sand instruction--layout-1">
    <div class="container">
        <h2 class="page-section__title t-center">We offer multiple services for you</h2>
        <div class="row">
            <div class="col-md-4 instruction-container">
                <div class="instruction t-center">
                    <span class="instruction__step c-dove-gray">01.</span>
                    <h3 class="instruction__title">Flights Track</h3>
                    <p class="instruction__detail c-boulder">
                        You can track the status of every flight.
                    </p>
                </div><!-- .instruction -->
            </div><!-- .col -->

            <div class="col-md-4 instruction-container">
                <div class="instruction t-center">
                    <span class="instruction__step c-dove-gray">02.</span>
                    <h3 class="instruction__title">Get Updates</h3>
                    <p class="instruction__detail c-boulder">
                        When your flights are delayed or cancelled, you will be informed by email immediately.
                    </p>
                </div><!-- .instruction -->
            </div><!-- .col -->

            <div class="col-md-4 instruction-container">
                <div class="instruction t-center">
                    <span class="instruction__step c-dove-gray">03.</span>
                    <h3 class="instruction__title">For Administrators</h3>
                    <p class="instruction__detail c-boulder">
                        You can make flights schedules, simulate flights flying process, and update flights.
                    </p>
                </div><!-- .instruction -->
            </div><!-- .col -->
        </div><!-- .row -->
    </div><!-- .container -->
</section><!-- .instruction-container -->

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
</script>
</html>
