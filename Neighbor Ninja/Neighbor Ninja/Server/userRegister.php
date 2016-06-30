<?php 


include_once("conn.php");
include_once("MySQLDao.php");

$name = ($_POST["name"])
$email = ($_POST["email"]);
$pword = ($_POST["password"]);
$address = ($_POST["address"]);

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
	echo("Success");
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

msyql_close();
?>

// $returnValue = array();

// if(empty($name) || empty($email) || empty($password) || empty($address))
// {
// $returnValue["status"] = "error";
// $returnValue["message"] = "Missing required field";
// echo json_encode($returnValue);
// return;
// }

// $dao = new MySQLDao();
// $dao->openConnection();
// $userDetails = $dao->getUserDetails($email);

// if(!empty($userDetails))
// {
// $returnValue["status"] = "error";
// $returnValue["message"] = "User already exists";
// echo json_encode($returnValue);
// return;
// }

// $secure_password = md5($password); // I do this, so that user password cannot be read even by me

// $result = $dao->registerUser($name,$email,$secure_password,$address);

// if($result)
// {
// $returnValue["status"] = "Success";
// $returnValue["message"] = "User is registered";
// echo json_encode($returnValue);
// return;
// }

// $dao->closeConnection();

// ?>