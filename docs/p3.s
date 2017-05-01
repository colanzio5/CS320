*----------------------------------------------------------------------
* Programmer: Colin Casazza 
* Class Account: cssc0181
* Assignment or Title: Programming Assignment 3
* Filename: prog3.s
* Date completed: 
*----------------------------------------------------------------------
* Problem statement: Convert integers between bases.
* Input:  Source Base, Number in Source Base, Base to Convert to
* Output: New Integer in New Base
* Error conditions tested: 
* Included files: 
* Method and/or pseudocode: 
* References: 
*----------------------------------------------------------------------
*
        ORG     $0
        DC.L    $3000           * Stack pointer value after a reset
        DC.L    start           * Program counter value after a reset
        ORG     $3000           * Start at location 3000 Hex
*
*----------------------------------------------------------------------
*
#minclude /home/cs/faculty/riggins/bsvc/macros/iomacs.s
#minclude /home/cs/faculty/riggins/bsvc/macros/evtmacs.s
*
*----------------------------------------------------------------------
*
* Register use
*
*----------------------------------------------------------------------
*
start:  	initIO                  		Initialize (required for I/O)
	setEVT			* Error handling routines
	initF			* For floating point macros only
	
		
*------------------------------------------------
*				
*	*USE OF REGESTERS		
*					
*	*D0 - 					
*	*D1 - (static)	length of input		
*	*D2 - (static)	base of input		
*	*D3 - (temp) 	character holder	
*	*D4 - (temp)	base holder		
*	*D5 - (temp)	running sum		
*	*D6 -
*	*D7 - 					
*	*A0 - (pointer) begining of input
*	*A1 - (pointer) tail of input	
*						
*------------------------------------------------
	
	bra		getin			

getin:	lineout		prompt1								*Ask the user to enter the base of input
	linein		bin	*Places the base in memory as ASCII
	cvta2		bin,D0	*Converts ASCII number to hex
	move.l		D0,D2	*Move input base to D2
	clr.l		D0

	
	lineout		prompt2	*Ask the user to enter and integer
	linein		iin	*Places the integer in memory as ASCII
	move.l		#iin,A0	*Load the begining address of input into A0
	
	move.l		D0,D1	*Put the length of the input integer into D1
	subi.b		#$1,D0	*Subtract one from length of input
	clr.l		D7			
	move.l		A0,D7
	add.l		D0,D7
	move.l		D7,A1	*Load address of last char in number 
	
	clr.l		D3	*Load 00000001 into D3
	addi.l		#$1,D4
	
	clr.l		D7	*Collect garbage
	clr.l		D0	
	bra		idloop	*Start iderator
	
idloop:	break
	clr.l		D3			
	move.b		(A1),D3
	
	cmpi.l		#$30,D3	*checks for invalid inputs in ascii codes
	blt		error	*less than 30?
	cmpi.l		#$66,D3	
	bgt		error	*greater than 66?
	
	suba.l		#$1,A1
	bra		filter
	
filter:	cmpi.b		#$39,D3	*This section changes a-f and A-F to their respective hexadecimal values
	bgt		isChar	
	bra		noChar
	
isChar:	cmpi.b		#$60,D3
	bgt		smChar
	bra		lgChar
	
smChar:	cmpi.l		#$61,D3	*checks to see if ascii code is larger than f
	blt		error
	subi.b		#$57,D3
	bra		ishex
	
LgChar:	cmpi.l		#$41,D3	*checks to see if ascii code is larger than f
	blt		error
	subi.b		#$32,D3
	bra		isHex

noChar:	subi.b		#$30,D3
	bra		isHex
			
isHex:	cmpi.b		#$1,D4	*At this point the ascii char in D4 is now hex
	beq		beqo	
	bra		bgto

beqo:	add.l		D3,D5
	mulu		D2,D4
	bra		isdone
	
bgto:	mulu.w		D4,D3
	add.l		D3,D5
	mulu.w		D2,D4
	bra		isdone
	
isdone:	cmp.l		A0,A1
	blt		end
	bra		idloop
	

end:	break
	bra		outdec

outdec:	move.l		D5,D2	
	lineout 		prompt3
	linein	 	bou
	cvta2		bou,D0
	move.l		D0,D1
	move.l		D0,D3
	move.l		#iou,A3
	move.l		#iou,A4
	clr.b		D6
	move.l		#$1,D3
	bra		getsig
	
*REG USE
*D1 - Base TO CONVERT TO
*D2 - HexaDECIMAL NUMBER
*D3 - TMP BYTE EXPONENT
*D4 - TMP ASCII NUMBER

getsig:	break
	cmp.l		D3,D2	*Finds most significant bit
	blt		redloop		
	mulu.w		D1,D3
	bra		getsig
	
redloop:	cmpi.l		#$00000001,D3	*check to see if base one
	beq		baseone		
	move.l		D3,D7		
	divu.w		D1,D7	*reduce power by one
	move.l		D7,D3
	clr.l		D7
	
	cmp.l		D3,D2
	blt		putzero
	cmpi.w		#$00000001,D3
	beq		baseone
	bra		div
	
putzero:	clr.l		D4	*adds place holder zeros to outputbuffer
	add.l		#$30,D4		
	move.b		D4,(A3)+
	clr.l		D4	
	bra		redloop	
	

baseone:	move.l		D2,D4		
	bra		toascii
	
	
div:	clr.l		D5	*See how many times the current base can fit into hexnumber
	move.l		D2,D5		
	divu.w		D3,D5
	
	clr.l		D7
	move.w		D5,D7
	move.l		D7,D5
	move.l		D5,D4
	clr.l		D7
	
	mulu.w		D3,D5
	bra		toascii
	

toascii:	cmpi.b		#$39,D4	*converts results from div into ascii
	bgt		notNum	*can receive digits in D4 from baseone when no div occurs
	bra		isNum
	
notNum:	cmpi.b		#$60,D4
	bgt		lgLet
	bra		smLet
	
lgLet:	addi.b		#$57,D4
	bra		isascii
	
smLet:	addi.b		#$32,D4
	bra		isascii

isNum:	addi.b		#$30,D4
	bra		isascii
	
isascii:	move.l		D4,D7	*at this point, the number in D4 is in ascii
	sub.l		D5,D7
	move.b		D4,(A3)+	*add ascii code to buffer
	sub.l		D7,D4
	sub.l		D5,D2
	clr.l		D4
	cmpi.l		#$00000001,D3	
	beq		done	
	bra		redloop
	
done:	lineout		prompt4
	lineout		iou		
	lineout		prompt5	*asks the user if they would like to start over
	clr.l		iou	
	linein		cho
	cmpi.b		#$79,cho	
	beq		start
	cmpi.b		#$6e,cho
	beq		endd
	bra		error
	
error:	lineout		prompt6
	bra		start
	
endd:
	
	
	break           
*
*----------------------------------------------------------------------
*       Storage declarations

prompt1: 	dc.b	'Please Enter A Source Base.                  ',0
prompt2:	dc.b	'Please enter a source integers.              ',0
prompt3:	dc.b	'Please enter a base to convert to.           ',0
prompt4:	dc.b	'New Integer:                                 ',0
prompt5:	dc.b	'Do you want to convert another number? (y/n) ',0
prompt6:	dc.b	'Invalid Entry, please try again.             ',0

iin		ds.b	80
bin		ds.b	80
bou		ds.b	80
iou		ds.b	80
cho		ds.b	80


        end
