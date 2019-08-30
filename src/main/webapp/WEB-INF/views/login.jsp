<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 30/06/2019
  Time: 17:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge, chrome=1">
    <title>User login</title>
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
                    <a href="/index/admin">Admin login</a>
                </li>

                <li>
                    <a href="/back/index">Homepage</a>
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
                <h2 class="page-banner__title c-primary">Sign In</h2>
            </div><!-- .page-banner__textcontent -->

            <div id="login" class="main-search-container">
                <form class="main-search main-search--layout-1 bg-mirage"
                      id="userLogin" action="/user/login" method="post">
                    <div class="main-search__group main-search__group--primary">
                        <label for="username" class="c-white">Username</label>
                        <input type="text" required id="username" name="username" class="form-input">
                    </div><!-- .main-search__group -->

                    <div class="main-search__group main-search__group--primary">
                        <label for="userpassword" class="c-white">Password</label>
                        <input type="password" required id="userpassword" name="userpassword" class="form-input">
                    </div><!-- .main-search__group -->

                    <div class="main-search__group main-search__group--tertiary">
                        <button type="submit" class="button button--medium button--square button--primary">
                            <i class="fa"></i> Login
                        </button>
                    </div>

                    <div class="form-group--footer">
                        <span class="c-gray">
                        Don't have an account? <a href="/login/register" class="c-secondary t-underline js-block-trigger">Register</a>
                        </span>
                    </div>
                </form>
            </div><!-- .main-search-container -->
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
        if ('${status}' == 0) {
            alert("User login successfully");
            location.href = '/user/home';
        }
        else if ('${status}' == 1){
            alert("Account does not exist");
        }
        else if ('${status}' == 2) {
            alert("Wrong password");
        }
    }
</script>
</html>
