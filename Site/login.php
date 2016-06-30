<?php
$value=1;
session_start();
include_once 'dbconnect.php';
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 
$email = $_POST['email'];
$pword = $_POST['password'];
$address = $_POST['address'];

$sql = "SELECT * FROM users WHERE email='$email'";
$result = $conn->query($sql);
$num = $result->num_rows;
if ($num > 0) { 
	$row = $result->fetch_assoc();
    }

$accpw=$row["password"];

if ($pword==$accpw) {
	$_SESSION['userid']=$row["ID"];
	$_SESSION['emailaddress']=$row["email"];
	$_SESSION['name']=$row["name"];

	header("Location:home.php");
}
else{
	header("Location:loginfail.html");
}
   ?>

        