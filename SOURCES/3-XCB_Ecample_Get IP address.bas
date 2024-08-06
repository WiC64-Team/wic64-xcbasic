'***************************************************************************
'Get IP address example XC-Basic
'***************************************************************************
'wic_com Parameters: 
'1. Byte   Command (6=getIP address)
'3. Word   position of URL string in memory
'4. Int    lenght of URL string
'5. Word   Start address of data to send
'6. Word   lenght of data to send.
'7. Word   Target where received data should be stored 
'RETURN value = number of bytes received from WiC64 module
'***************************************************************************
include "wic64X.bas"

dim recbytes as word

recbytes = wic_com(6,0,0,0,0,$0658)

