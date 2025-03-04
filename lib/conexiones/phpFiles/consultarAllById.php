<?php
header("Access-Control-Allow-Credentials: true");
header("Content-Type: application/json");

include_once 'conexion.php';

$json = array();
// . ............................ . . . .....
$query = $_POST['query'];
$id = $_POST['id'];

$gsent = $pdo->prepare($query);
$gsent->execute(array($id)); //array($usu_usuario,$usu_password)

try {
    while ($resultado = $gsent->fetch(\PDO::FETCH_ASSOC))  {
        $i = 0;
        foreach ($resultado as $key => $value) {
            $columnMeta = $gsent->getColumnMeta($i);
            // var_dump($columnMeta["native_type"], $columnMeta['name'], $resultado[$columnMeta['name']]);
            switch ($columnMeta['native_type']) {
                case 'BLOB':
                    $result[$columnMeta['name']] = base64_encode($resultado[$columnMeta['name']]);
                    break;
                default:
                    $result[$columnMeta['name']] = $resultado[$columnMeta['name']];
                    break;
            }
            $i++;
        }
        $json[]=$result; 
    }
} catch (PDOException $e){
    die();
} finally {
    echo json_encode($json);
}

