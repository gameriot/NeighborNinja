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

$R = 6371;

    // first-cut bounding box (in degrees)
    $maxLat = $lat + rad2deg($rad/$R);
    $minLat = $lat - rad2deg($rad/$R);
    $maxLng = $lng + rad2deg(asin($rad/$R) / cos(deg2rad($lat)));
    $minLng = $lng - rad2deg(asin($rad/$R) / cos(deg2rad($lat)));

echo $maxLat;
echo $minLat;
echo $maxLng;
echo $minLng;
echo "...";

$sql = "INSERT INTO `crimereporttest` (type, lat, lng, description) VALUES ('$type','$lat','$lng','$description')";
$sql = "SELECT ID from `users` WHERE (lat BETWEEN '$minLat' AND '$maxLat') AND (lng BETWEEN '$minLng' AND '$maxLng')";

// if (mysqli_multi_query($con, $sql))
// {
//   do
//     {
//     // Store first result set
//     if ($result=mysqli_store_result($con)) {
//       // Fetch one and one row
//       while ($row=mysqli_fetch_row($result))
//         {
//         printf("%s\n",$row[0]);
//         }
//       // Free result set
//       mysqli_free_result($result);
//       }
//     }
//   while (mysqli_next_result($con));
// }
// else{
//   echo ("Error description: " . mysqli_error($con));
// }

if (mysqli_multi_query($con, $sql)) {
    do {
        /* store first result set */
        if ($result = mysqli_store_result($con)) {
            while ($row = mysqli_fetch_row($result)) {
                echo "The user within range is ";
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

// // Check if there are results
// if ($result = mysqli_query($con, $sql))
// {
//     // If so, then create a results array and a temporary one
//     // to hold the data
//     echo json_encode(mysqli_num_rows($result));
// }

// Close connections
mysqli_close($con);
?>
