<?php
 
require_once('dbconnection.php');  
// Create connection
$con=mysqli_connect($server,$user,$pword,$database);
 
// Check connection
if (mysqli_connect_errno())
{
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

	$name = $_POST['a'];
	$email = $_POST['b'];
	$pass = $_POST['c'];
	$address = $_POST['d'];
	$lat = $_POST['e'];
	$lng = $_POST['f'];

echo $lat;
echo $lng;

$query = "INSERT INTO users (name, email, password, address, lat, lng) VALUES ('$name','$email','$pass','$address', '$lat', '$lng')";

if (!mysqli_query($con, $query)) 
{
	echo ("Error description: " . mysqli_error($con));
} 

// Close connections
mysqli_close($con);
?>