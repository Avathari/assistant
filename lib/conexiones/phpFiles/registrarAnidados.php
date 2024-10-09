<?php
header("Access-Control-Allow-Credentials: true");

include_once 'conexion.php';

$json = array();
// . ............................ . . . .....
$query = $_POST['query'];
$elements = json_decode($_POST['elements']);

try {
 // $pdo->beginTransaction(); // Iniciar la Transcripción
 $gsent = $pdo->prepare($query);
 // Recorrer cada lista e insertar los elements
 foreach ($elements as $fila) {
  $gsent->execute($fila); // Ejecutar la consulta con los valores de cada fila
 }

 $gsent->commit(); // Confirmar la transacción
 echo json_encode("SUCCESS");
} catch (PDOException $e) {
 // En caso de error, revertir la transacción
 $gsent->rollBack();
 echo "Error al insertar datos: " . $e->getMessage();
}
// echo json_encode($elements);
// if($gsent->execute($elements)){
//     echo json_encode("SUCCESS");
// } else{
//     echo "Oops! Something went wrong. Please try again later.";
// }