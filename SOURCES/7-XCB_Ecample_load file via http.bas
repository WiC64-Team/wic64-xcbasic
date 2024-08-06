'***************************************************************************
'Load PRG File Example Start with sys49152
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
'If parameter 7 is zero then file load is activated. WIC_COM command then
'reads the first two bytes of file and interprets them as start address of
'the prg file
'Please start this example with sys49152'

OPTION NOBASICLOADER
OPTION STARTADDRESS = $C000
include "wic64X.bas"

dim url$ as string * 90
dim recbytes as word

url$="http://x.wic64.net/files/straight-up.prg"
print "loading"
recbytes = wic_com(1,CWORD(@url$),len(url$),0,0,0)


'Small ASM program to unnew the basic program'
dim mem as word
mem = 52224
poke mem,$A0
poke mem+1,$01
poke mem+2,$98
poke mem+3,$91
poke mem+4,$2B
poke mem+5,$20
poke mem+6,$33
poke mem+7,$A5
poke mem+8,$A5
poke mem+9,$22
poke mem+10,$18
poke mem+11,$69
poke mem+12,$02
poke mem+13,$85
poke mem+14,$2D
poke mem+15,$A5
poke mem+16,$23
poke mem+17,$69
poke mem+18,$00
poke mem+19,$85
poke mem+20,$2E
poke mem+21,$4C
poke mem+22,$60
poke mem+23,$A6
poke mem+24,$60

poke 1,55   'reactivate basic rom'
poke 55,0   'set Basic Memory end'
poke 56,160 'set Basic Memory end'
sys 52224   'Call Unnew ASM to reset XC-Basic pointers for Basic V2'























