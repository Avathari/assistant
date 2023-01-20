<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
<?php
    // $path = $_POST['url'];
    // ################################3
    $json = array();
    $path = "carpeta/";
    // Se agrega barra invertida en caso de poseerla.
    // if (substr($path, -1) != "/") $path .= "/";
    $total_imagenes = count(glob($path.'{*.jpg,*.png,*git}', GLOB_BRACE));
    // ################################
    // echo 'Total de imagenes = '.$total_imagenes;

    $dir = opendir($path);
    while ($archivo = readdir($dir)) { 
        if( $archivo != "." && $archivo != "..") {
            if(is_dir($path.$archivo)) {
                
            }
            else {
                $json[] = $path.'/'.$archivo;
            }
        }
    }

    closedir($dir);
    echo json_encode($json);  
?>
</body>
</html>