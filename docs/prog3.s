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
						
	clr.l		iin
	clr.l		bin
	clr.l		bou
	clr.l		bin
	
	clr.l		D1
	clr.l		D2
	clr.l		D3
	clr.l		D4
	clr.l		D5
	clr.l		D6
	bra		getin			

getin:	lineout		prompt1	*Ask the user to enter the base of input
	linein		bin	*Places the base in memory as ASCII
	cvta2		bin,D0	*Converts ASCII number to hex
	move.l		D0,D2	*Move input base to D2
	cmpi.l		#$00000010,D2
	bgt		error
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
	
idloop:	clr.l		D3			
	move.b		(A1),D3
	
	cmpi.b		#$30,D3	*checks for invalid inputs in ascii codes
	blt		error	*less than 30?
	cmpi.b		#$66,D3	
	bgt		error	*greater than 66?
	
	suba.l		#$1,A1
	bra		filter
	
filter:	cmpi.b		#$39,D3	*This section changes a-f and A-F to their respective hexadecimal values
	bgt		isChar	
	bra		noChar
	
isChar:	cmpi.b		#$60,D3
	bgt		smChar
	bra		lgChar
	
smChar:	cmpi.b		#$67,D3	*checks to see if ascii code is larger than f
	bgt		error
	cmpi.b		#$61,D3
	blt		error
	subi.b		#$57,D3
	bra		isHex
	
LgChar:	cmpi.b		#$41,D3	*checks to see if ascii code is larger than f
	blt		error
	cmpi.b		#$47,D3
	bgt		error
	subi.b		#$32,D3
	bra		isHex

noChar:	cmpi.b		#$30,D3
	blt		error
	subi.b		#$30,D3
	bra		isHex
			
isHex:	cmp.l		D2,D3
	bgt		error
	cmpi.b		#$1,D4	*At this point the ascii char in D4 is now hex
	beq		beqo	
	bra		bgto

beqo:	add.l		D3,D5
	mulu		D2,D4
	bra		isdone
	
bgto:	mulu.w		D4,D3
	add.l		D3,D5
	mulu.w		D2,D4
	bra		isdone
	
isdone:	cmp.l		A0,A1	*checks to see if we've iderated through the input integer
	blt		end	*if so, branch to end
	bra		idloop	*if not, back to start
	

end:	bra		outdec

outdec:	move.l		D5,D2	*Move raw number to D2 for next step
	lineout 		prompt3	*Ask for output base
	linein	 	bou	*take in output base and convert from ascii to 2c
	clr.l		D1
	cvta2		bou,D0
	move.l		D0,D1
	move.l		D0,D3	*move base to D1 and D3
	
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

getsig:	cmp.l		D3,D2	*Finds most significant bit+1
	blt		loop		
	mulu.w		D1,D3
	bra		getsig
	
loop:	move.l		D3,D7	*reduce significant bit's base by a power of one
	divu.w		D1,D7
	move.l		D7,D3
	clr.l		D7
	
	cmp.w		D3,D2
	blt		isdone2
	bra		ascii
	
	
isdone2:	cmp.l		#$0,D2	*The next few lines determine when to we're done reducing the raw number
	beq		c1	*We're done when the base is at one and the declining raw number is 0
	bra		zero		
	
c1:	cmp.l		#$1,D3	*is the base one?
	beq		c2
	bra 		zero
	
c2:	move.l		D2,D4	*put the ones place into the outint
	bra		ascii
	
	
zero:	clr.l		D4	*D4 is a zero
	add.l		#$30,D4		
	move.b		D4,(A3)+	put zero into outint
	bra		loop	


ascii:	clr.l		D5	*see how many times the base can fit into declining raw number
	move.l		D2,D5		
	divu.w		D3,D5
	
	clr.l		D7
	move.w		D5,D7
	move.l		D7,D5
	move.l		D5,D4
	clr.l		D7
	
	mulu.w		D3,D5	*multiply result of divide into base
	
	bra		toascii	*convert result to ascii
	

toascii:	cmpi.b		#$39,D4	*converts results from div into ascii
	bgt		notNum	*can receive digits in D4 from baseone when 								*no div occurs
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
	cmpi.l		#$1,D3	*check to see if we were at the last number
	beq		done
	sub.l		D7,D4	*subtract the base times the raw number divided by the base from the raw number
	sub.l		D5,D2
	clr.l		D4
	bra		loop	
	
done:	lineout		prompt4	
	lineout		iou		
	lineout		prompt5	*asks the user if they would like to start over
	clr.l		iou	
	linein		cho
	cmpi.b		#$79,cho	*check for answer = yes
	beq		start
	cmpi.b		#$6e,cho	*check for answer = no
	beq		endd
	bra		error	*bad input
	
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
