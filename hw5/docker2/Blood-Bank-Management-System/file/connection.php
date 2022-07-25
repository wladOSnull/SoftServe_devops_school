<?php
#$servername = "localhost:3306";
$username = "root";
$password = "blood_pass";
$dbname = "bloodbank";
$host = 'db';
$conn = new mysqli($host, $username, $password, $dbname);
if(!$conn){
 die('Could not Connect MySql:' .mysql_error());
}
?>
