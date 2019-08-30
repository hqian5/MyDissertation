<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 06/07/2019
  Time: 12:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge, chrome=1">
    <title>User register</title>
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

<section class="page-banner page-banner--layout-1 parallax" style="background-image: url('/images/background4.jpg')">
    <div class="container">
        <div class="page-banner__container animated zoomIn">
            <div class="page-banner__textcontent t-center">
                <h2 class="page-banner__title c-primary">Sign Up</h2>
            </div><!-- .page-banner__textcontent -->

            <div id="register" class="main-search-container">
                <form id="userRegister" action="/user/register" method="post" class="main-search main-search--layout-2 bg-mirage">
                    <div class="main-search__group">
                        <label for="uname" class="c-white">Name *</label>
                        <input
                                type="text"
                                required id="uname" name="uname"
                                class="form-input"
                        >
                    </div><!-- .form-group -->

                    <div class="main-search__group">
                        <label for="upassword" class="c-white">Password *</label>
                        <input
                                type="password"
                                required id="upassword" name="upassword"
                                class="form-input"
                        >
                    </div><!-- .form-group -->

                    <div class="main-search__group">
                        <label for="realname" class="c-white">Personal name *</label>
                        <input
                                type="text"
                                required id="realname" name="realname"
                                class="form-input"
                        >
                    </div><!-- .form-group -->

                    <div class="main-search__group">
                        <label for="passport" class="c-white">Passport number *</label>
                        <input
                                type="text"
                                required id="passport" name="passport"
                                class="form-input"
                        >
                    </div><!-- .form-group -->

                    <div class="main-search__group">
                        <label for="email" class="c-white">Email address *</label>
                        <input
                                type="text"
                                required id="email" name="email"
                                class="form-input"
                        >
                    </div><!-- .form-group -->

                    <div class="main-search__group">
                        <label for="phone" class="c-white">Phone number *</label>
                        <input
                                type="text"
                                required id="phone" name="phone"
                                class="form-input"
                        >
                    </div><!-- .form-group -->

                    <div class="main-search__group">
                        <label for="preference" class="c-white">Preference *</label>
                        <select
                                required id="preference" name="preference"
                                class="form-input"
                        >
                            <option value="cheap">cheap</option>
                            <option value="fast">fast</option>
                            <option value="less changes">less changes</option>
                        </select>
                    </div><!-- .form-group -->
                    <div class="main-search__group">
                        <button
                                class="button button--medium button--square button--primary"
                                type="submit"
                        >
                            Register
                        </button>
                    </div>

                    <div class="form-group--footer">
                        <span class="c-gray">
                        Already have an account? <a href="/index/login" class="c-secondary t-underline js-block-trigger">Login</a>
                        </span>
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
            alert("Register successfully");
            location.href = '/register_ok/login'
        }
        else if ('${status}' == 1){
            alert("Username already exists");
        }
        else if ('${status}' == 2){
            alert("Registration failed");
        }
    }
</script>
</html>
