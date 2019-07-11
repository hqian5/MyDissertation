<html>
<link rel='stylesheet' href='./css/login.css' />
<script src = 'https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js'></script>
<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js'></script>
<script src="http://code.jquery.com/jquery-1.11.1.js"></script>
<link rel="stylesheet" href="./bootstrap-4.3.1-dist/css/bootstrap.min.css">
<script src="./bootstrap-4.3.1-dist/js/bootstrap.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<style>
    body{
        background-image: url("./images/background2.jpg");
        background-size: 100%;
        background-repeat: repeat;
        font-family: Verdana, Genevs, Arial, sans-serif;
        text-align: center;
    }
</style>
<body>
<div class="container">
    <div id="index_frame">
        <h2>Welcome to Birds Tracker</h2>
        <div class="row">
            <div class="col-md">
                <input type="button" value="User login" onclick="location.href='/index/login'" class="btn-blue">
                <input type="button" value="Administrator login" onclick="location.href='/index/admin'" class="btn-blue">
            </div>
        </div>
    </div>
</div>
</body>
</html>
