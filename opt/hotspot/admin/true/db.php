<?php if ($_SERVER['REMOTE_ADDR']== '203.146.127.115' || 'www.tmtopup.com' && isset($_GET['request']))
{
$db['hostname'] = 'localhost';
$db['username'] = 'root';
$db['password'] = 'duydui1909';
$db['database'] = 'radius';
}
else {echo 'No direct script access allowed';}
?>
