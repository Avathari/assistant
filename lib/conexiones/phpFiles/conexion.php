<?php

// $db_name = "bd_regusua"; //"dbqbfrmbo2sohg"; //"bd_regusua";
// $db_server = 'Localhost'; //'35.209.114.34'; //"192.168.0.15";//"127.0.0.1";
// $db_user = "root"; //"ux1ge4kaeg7w7"; // "root";
// $db_pass = ""; //"746)o4H)c]b2";

// $db_name = "dbqbfrmbo2sohg"; //"bd_regusua";
// $db_server = '35.209.114.34'; //"192.168.0.15";//"127.0.0.1";
// $db_user = "ux1ge4kaeg7w7"; // "root";
// $db_pass = "746)o4H)c]b2";

$db_name = $_POST['database'];
$db_server = $_POST['host'];
$db_user = $_POST['username'];
$db_pass = $_POST['password'];
// $link = "mysql:host={$db_server};dbname={$db_name};charset=utf8";

try {
    $pdo = new PDO("mysql:host={$db_server}; dbname={$db_name};charset=utf8", 
        $db_user, $db_pass);
    $pdo->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // echo 'Conectado <br><br>';
} catch (PDOException $e){
    // print "¡Error!: " .$e->getMessage() - "<br/>";
    die();
}