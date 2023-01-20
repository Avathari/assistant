<?php
header("Access-Control-Allow-Credentials: true");

include_once 'conexion.php';

$result = array();
// . ............................ . . . .....
$query = $_POST['query'];

$gsent = $pdo->prepare($query);
$gsent->execute(); 

try {
    $resultado = $gsent->fetch(\PDO::FETCH_ASSOC);
} catch (PDOException $e){
    die();
} finally {
    echo json_encode($resultado);
}

