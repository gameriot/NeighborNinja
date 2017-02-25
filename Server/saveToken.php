<?php
 
require_once('dbconnection.php');  
// Create connection
$con=mysqli_connect($server,$user,$pword,$database);
 
// Check connection
if (mysqli_connect_errno())
{
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

	$token = $_POST['a'];

echo $lat;
echo $lng;

$query = "INSERT INTO users (token) VALUES ('$token')";

if (!mysqli_query($con, $query)) 
{
	echo ("Error description: " . mysqli_error($con));
} 

// Close connections
mysqli_close($con);
?>