<?php
 
// Create connection
$con=mysqli_connect("localhost","root","root","neighborninja");
 
// Check connection
if (mysqli_connect_errno())
{
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

	$type = $_POST['a'];
	$lat = $_POST['b'];
	$lng = $_POST['c'];
	$description = $_POST['d'];
	$rad = $_POST['e'];
    $userID = $_POST['f'];

$R = 6371;

    // first-cut bounding box (in degrees)
    $maxLat = $lat + rad2deg($rad/$R);
    $minLat = $lat - rad2deg($rad/$R);
    $maxLng = $lng + rad2deg(asin($rad/$R) / cos(deg2rad($lat)));
    $minLng = $lng - rad2deg(asin($rad/$R) / cos(deg2rad($lat)));

$query = "INSERT INTO `crimereport` (type, lat, lng, description, userID) VALUES ('$type','$lat','$lng','$description', '$userID');";
$query .= "SELECT ID from `users` WHERE (lat BETWEEN '$minLat' AND '$maxLat') AND (lng BETWEEN '$minLng' AND '$maxLng')";


if (mysqli_multi_query($con, $query)) {
    do {
        /* store first result set */
        if ($result = mysqli_store_result($con)) {
            while ($row = mysqli_fetch_row($result)) {
                printf("%s\n", $row[0]);
            }
            mysqli_free_result($result);
        }
        /* print divider */
        if (mysqli_more_results($con)) {
            printf("-----------------\n");
        }
    } while (mysqli_next_result($con));
}

/* close connection */
$mysqli->close();
?>
