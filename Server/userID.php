<?php

require_once('dbconnection.php');  

// Create connection
$con=mysqli_connect($server,$user,$pword,$database);
// Check connection
if (mysqli_connect_errno())
{
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

$email = $_POST['a'];

$sql = "SELECT ID FROM `users` WHERE email ='$email'";

$result = $con->query($sql);

if ($result->num_rows > 0) {
    // output data of each row
    while($row = $result->fetch_assoc()) {
        echo $row["ID"];
    }
} else {
    echo "0 results";
}

// echo $sql;
// Close connections
mysqli_close($con);
?>