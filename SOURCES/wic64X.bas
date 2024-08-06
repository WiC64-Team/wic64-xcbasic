sub setbyte (value as byte) static
	dim x as byte
	poke 56577,value	
	do 	
	loop until peek(56589) and 16 <> 0
end sub

function readbyte as byte() static
	do
	loop until peek(56589) and 16 <> 0
	return peek(56577)	
end function

function lowhighbyte as byte (lorh as byte, value as int) static shared
	dim high as byte
	dim low as byte
	
	high = CBYTE(SHR(value,8))
	low = CBYTE(value)
	
	if lorh = 1 then return low
	if lorh = 2 then return high	
end function

function wic_com as word (com as byte, parastart as word, paralenght as word, datastart as word, datalenght as word, target as word) static SHARED
	dim b as byte
	'initialisation Port
	asm 
	 LDA $dd02
	 ORA #$04
	 STA $dd02
	 LDA $dd00
	 ORA #$04 
	 STA $dd00
	 LDA #$ff 
	 STA $dd03

	 lda $dd0d
	end asm 
	
	'Send URL/Request'

	call setbyte(82)										'startbyte new protocoll type
	call setbyte(com)										'WiC64 command
	call setbyte(lowhighbyte(1,paralenght))	
	call setbyte(lowhighbyte(2,paralenght))

	parastart = parastart +1
	if paralenght > 0 then
		dim sign as byte
		do												'Set Data on bus
			sign = peek(parastart) 
			if sign >= 65 and sign <= 90 then sign = sign + 32 'PETCII to ASCII
			call setbyte(sign)
			paralenght = paralenght - 1
			parastart = parastart + 1
		loop while paralenght <> 0
	end if 


	'additional data send via HTTP Post only when necessary'
	if datalenght > 0 and com = 40 then
		
		'get answer of URL command.
		asm
			lda #$00 
			sta $dd03
			lda $dd00
			and #251 
			sta $dd00
			sei
		end asm

		b = readbyte()   'dummy read start communication
		b = readbyte()   'dummy read start communication
		b = readbyte()   'dummy read start communication
		
		'initialisation Port
		asm 
			LDA $dd02
			ORA #$04
			STA $dd02
			LDA $dd00
			ORA #$04 
			STA $dd00
			LDA #$ff 
			STA $dd03
			
			lda $dd0d
		end asm 

		call setbyte(82)										'startbyte new protocoll type
		call setbyte(43)										'WiC64 command Post DATA
		call setbyte(lowhighbyte(1,datalenght))
		call setbyte(lowhighbyte(2,datalenght))	
		do
			call setbyte(peek(datastart))
			datastart = datastart + 1
			datalenght = datalenght - 1
		loop while datalenght <> 0
	end if

	'Receive answer from WiC64 module
	
	'Target = 0     -> load File (to original startaddress)
	'Target = $FFFF -> load DMI Format (Direct memory incjection) 

	asm
	 lda #$00 
	 sta $dd03
	 lda $dd00
	 and #251 
	 sta $dd00
	 sei
	end asm
	
	
	dim low as byte
	dim high as byte
	dim sum as word
	dim sumDMI as word
	dim lop1 as word

    'When command 40 (HTTP Post) is used, an lda DD0D is needed here'
	if com = 40 then
		asm
		  lda $dd0d
		end asm
	end if

	b = readbyte()   'dummy read start communication
	b = readbyte()	 'dummy read start communication
	low  = readbyte()	'low  byte of data to load
	high = readbyte()   'high byte of data to load
	sum = (high*256)+low 'sum of receiving byte
	
	lop1 = 0

	'Get first two bytes as start address of program if target = 0'
	if target = 0 then 'when typ = file then set first bytes of file as start address
		poke 43,readbyte()
		poke 44,readbyte()
		target = deek(43)		
		lop1 = 2
	end if

	'read loop normal Target load
	if target < $FFFF then
		
		do while lop1 <> sum
			do
			loop until peek(56589) and 16 <> 0			

			poke target,peek(56577)
			target = target + 1
			lop1 = lop1 + 1

		loop
	else 'DMI Load (Direkt Memory Injection (Target $FFFF)
		do while sum > 0
			'Read Startaddress
			poke 829,readbyte()
			poke 828,readbyte()
			target = deek(828)

			'Read number of bytes for this address
			poke 829,readbyte()	
			poke 828,readbyte()
			sumDMI = deek(828)
			sum = sum - 4
			'readloop
			for lop1 = 1 to sumDMI
				poke target,readbyte()
				target = target + 1
			next lop1
			sum = sum - sumDMI
		loop
		sum = 1
	end if	
	
	'Basic settings here
	asm
	 cli
	end asm
	
	return sum

end function







