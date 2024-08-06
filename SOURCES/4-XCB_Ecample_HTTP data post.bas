'***************************************************************************************************
'Example screenend Data to a server first 200 ($C8) Bytes of screen with HTTP Post
'Server will answer with the same data and program will store it in an other area of the screen
'
'wic_com Parameters: 
'1. Byte   Command (40=httpload with Data appened)
'3. Word   position of URL string in memory
'4. Int    lenght of URL string
'5. Word   Start address of data to send
'6. Word   lenght of data to send.
'7. Word   Target where received data should be stored 
'***************************************************************************************************

include "wic64X.bas"

dim url$ as string * 90
dim recbytes as word

url$="http://x.wic64.net/dataecho.php"
recbytes = wic_com(40,CWORD(@url$),len(url$),$0400,$C8,$04F0)


 