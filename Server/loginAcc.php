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

	// echo (mysqli_num_rows($result));
	// $resultArray = array();
	// $tempArray = array();

	// Loop through each row in the result set
	// while($row = $result->fetch_object())
	// {
	// 	// Add each row into our results array
	// 	$tempArray = $row;
	//     array_push($resultArray, $tempArray);
	// }
 
	// // Finally, encode the array to JSON and output the results
	// echo json_encode($resultArray);
}

// echo $sql;
// Close connections
mysqli_close($con);
?>