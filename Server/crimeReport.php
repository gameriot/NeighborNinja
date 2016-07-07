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

echo $type;
echo $lat;
echo $lng;
echo $description;

$query = "INSERT INTO crimereporttest (type, lat, lng, description) VALUES ('$type','$lat','$lng','$description')";

if (!mysqli_query($con, $query)) 
{
	echo ("Error description: " . mysqli_error($con));
} 

// Close connections
mysqli_close($con);
?>