*----------------------------------------------------------------------
* Programmer: Colin Casazza 
* Class Account: cssc0181
* Assignment or Title: Programming Assignment 4
* Filename: prog4.s
* Date completed: 5 May, 2017
*----------------------------------------------------------------------
* Problem statement: Reverse a String given by a user.
* Input:  A string with a maximum length of 79(+1 for '\0') characters.
* Output: The string printed out in reverse
* Error conditions tested: none
* Included files: 
* Method and/or pseudocode: reverse.s - reverse string and prints
* References: 
*----------------------------------------------------------------------

	ORG     $0
	DC.L    $3000           * Stack pointer value after a reset
	DC.L    start           * Program counter value after a reset
	ORG     $3000           * Start at location 3000 Hex

*----------------------------------------------------------------------
#minclude /home/cs/faculty/riggins/bsvc/macros/iomacs.s
#minclude /home/cs/faculty/riggins/bsvc/macros/evtmacs.s
*----------------------------------------------------------------------
*
* Register use
*
*----------------------------------------------------------------------
reverse:  	EQU	$6000

start:	initIO			*init I/O
	setEVT    		*init error handling
	*initF              	*init floating point

	lineout	info		*print user info
     	lineout	p1		*ask the user for input string
	linein	inbuff	
	move.l	D0,D1   	*move length of string to D1
	lineout	skpln	
	lineout	p2		*"Reversed String Is:"
	
	move.l	D1,-(SP) 	*move length onto stack
	pea	oubuff  	*move buff onto stack
	pea	inbuff		*move string onto stack
	jsr	reverse		*call reverse
	adda.l	#12,SP 		*add offset to stack pointer/revert
	
	lea	oubuff,A0	
	add.l	D1,A0		*add null terminate to buff
	clr.b	(A0)

	lineout	oubuff		*printout reverse string
	break          
*
*----------------------------------------------------------------------
*       Storage declarations

info:	dc.b	'Program #4, COLIN CASAZZA, CSSC0181',0
p1:   	dc.b 	'Enter a string:',0
p2:   	dc.b 	'Here is the string backwards:',0
skpln:	dc.b	0

inbuff:   	ds.b 	80
oubuff:   	ds.b 	80
        end
