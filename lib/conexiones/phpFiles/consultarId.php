<?php
header("Access-Control-Allow-Credentials: true");
header("Content-Type: application/json");

include_once 'conexion.php';

// . ............................ . . . .....
$query = $_POST['query'];
// "SELECT ID_Usuario, Us_Nome, Us_Ape_Pat, Us_Ape_Mat, Us_Usuario, from_base64(Us_Passe) as Us_Passe, Us_Permi, Us_EspeL, Us_Area, Us_Stat, Us_Fiat, Usu_ADAM_AGE FROM usuarios WHERE ID_Usuario = ?";
// $_POST['query'];
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
    }
} catch (PDOException $e){
    die();
} finally {
    echo json_encode($result);
}

