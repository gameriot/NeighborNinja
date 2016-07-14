<?php
 
// Create connection
$con=mysqli_connect("localhost","root","root","neighborninja");
// Check connection
if (mysqli_connect_errno())
{
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

$email = $_POST['a'];
$password = $_POST['b'];

 
// This SQL statement selects ALL from the table 'Locations'
$sql = "SELECT * FROM users WHERE email ='$email' AND password ='$password'";
// $result = mysqli_query($con, $sql);

// Check if there are results
if ($result = mysqli_query($con, $sql))
{
	// If so, then create a results array and a temporary one
	// to hold the data
	echo json_encode(mysqli_num_rows($result));


}

// echo $sql;
// Close connections
mysqli_close($con);
?>