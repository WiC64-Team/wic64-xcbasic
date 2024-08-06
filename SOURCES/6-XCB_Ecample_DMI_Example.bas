'***************************************************************************
'Direct memory insert example
'***************************************************************************
'wic_com Parameters: 
'1. Byte   Command (1=httpload)
'3. Word   position of URL string in memory
'4. Int    lenght of URL string
'5. Word   Start address of data to send
'6. Word   lenght of data to send.
'7. Word   Target where received data should be stored (FFFF activates the DMI Mode)
'RETURN value = number of bytes received from WiC64 module
'***************************************************************************
'
'Stream has to be created like this:
'2 Bytes target address
'2 Bytes lenth of now comming data
'X Bytes of data

'This stucture can be repead as often as desired in a stream.
'So it is possible to fill diferent areas in memory with one file/stream 


include "wic64X.bas"

dim url$ as string * 90
dim recbytes as word

url$="http://x.wic64.net/files/stream.bin"
recbytes = wic_com(1,CWORD(@url$),len(url$),0,0,$FFFF)

'When screen is build, wait for a key'
dim a as byte
'Wait for key
DO
	GET a
LOOP UNTIL a > 0






