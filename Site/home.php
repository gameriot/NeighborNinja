<?php
session_start();
if (empty($_SESSION['userid'])) {
    header("Location:login.html");
}
?>
<!DOCTYPE HTML>
<html>
	<head>
		<title>Neighbor Ninja</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel='shortcut icon' href='/images/logo.ico' type='image/x-icon'/ >
		<link rel="stylesheet" href="assets/css/main.css" />
	</head>

	<body>

		<!-- Header -->
			<header id="header">
				<h1><a href='index.html'>Neighbor Ninja</a></h1>
				<p>Keeping Your Neighborhood Secure<br />
				<?php echo  "Welcome, ", $_SESSION["name"], "."; ?>
				</p>
				<button><a href = "logout.php?logout">Sign Out</a></button>
			</header>

			
		<video autoplay loop id="bgvid">
		    <source src="/assets/images/wallpaper.mp4" type="video/mp4">
		</video>

		<!-- Footer -->
			<footer id="footer">
				<ul class="copyright">
					<li>&copy; Neighbor Ninja 2016</li>
				</ul>
			</footer>

		<!-- Scripts -->
<!-- 			[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]
 -->			<script src="assets/js/main.js"></script>
			<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
			<script type="text/javascript">

		    </script>

	</body>
</html>