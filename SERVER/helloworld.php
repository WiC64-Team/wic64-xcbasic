<?php 

 $message = "Hello C64 here a message from WiC64.net";
 
 // Translate the PC ASCII code to C64 screencode
 $length = strlen($message);
 for ($i = 0; $i < $length; $i++)
 {
	$zeichen = ord(substr($message,$i,1));
	if ($zeichen >= 97 and $zeichen <= 122)
		{
			$zeichen = $zeichen - 96;
		}
	echo chr($zeichen);
}
 ?>