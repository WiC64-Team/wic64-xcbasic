<?php
$data = @$_POST["data"];

for ($i = 0; $i < strlen($data); $i++) 
{
    $oneChar = substr($data, $i, 1);
    $val = ord($oneChar);
    $val = $val + 128;
    echo chr($val);
}

?>
