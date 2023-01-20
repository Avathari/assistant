<?php
header("Access-Control-Allow-Credentials: true");

include_once 'conexion.php';

$json = array();
// . ............................ . . . .....
$query = $_POST['query'];
$elements = json_decode($_POST['elements']);
$id = $_POST['id'];

$gsent = $pdo->prepare($query);

if($gsent->execute($elements)){
    echo json_encode("SUCCESS");
} else{
    echo "Oops! Something went wrong. Please try again later.";
}