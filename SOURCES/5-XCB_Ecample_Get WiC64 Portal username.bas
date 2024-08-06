'***************************************************************************
'determine WiC64 Portal Username example XC-Basic
'***************************************************************************
'wic_com Parameters: 
'1. Byte   Command (1=httpload)
'3. Word   position of URL string in memory
'4. Int    lenght of URL string
'5. Word   Start address of data to send
'6. Word   lenght of data to send.
'7. Word   Target where received data should be stored 
'RETURN value = number of bytes received from WiC64 module
'***************************************************************************
include "wic64X.bas"

poke 53272,22 'activate lower case

dim url$ as string * 90
dim recbytes as word


'Username as screencode: (GUS.PHP)
url$="http://x.wic64.net/gus.php?mac=%mac"
recbytes = wic_com(1,CWORD(@url$),len(url$),0,0,$0658)

'Username as ACII Code (GUN.PHP)
url$="http://x.wic64.net/gun.php?mac=%mac"
recbytes = wic_com(1,CWORD(@url$),len(url$),0,0,$0680)


 