<?php

include_once 'dbconnect.php';
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 

$name = $_POST['name'];
$email = $_POST['email'];
$pword = $_POST['password'];
$address = $_POST['address'];

$sql = "INSERT INTO users (name, email, password, address) VALUES ('$name', '$email','$pword', '$address')";

if ($conn->query($sql) === TRUE) {
	header("Location:login.html");
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

msyql_close();
?>