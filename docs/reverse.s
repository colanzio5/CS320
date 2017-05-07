*----------------------------------------------------------------------
* Programmer: Colin Casazza 
* Class Account: cssc0181
* Assignment or Title: Programming Assignment 4
* Filename: reverse.s
* Date completed: 7 May 2017
*----------------------------------------------------------------------
* Problem statement: subroutine that takes a string and prints in reverse
* Input: parameters are length of string and input buffer
* Output: returns addrtess of output buffer
* Error conditions tested: ~
* Included files: ~
* Method and/or pseudocode: 
* References: 
*----------------------------------------------------------------------

	ORG	$6000
	
reverse:	link	A6,#0
	movem.l	D1/A0-A2,-(SP)
	movea.l	8(A6),A1	*input buffer
	movea.l	12(A6),A0	*output buffer
	move.l	16(A6),D1	*lenght of string
	TST.l	D1	*see if string is empty
	BEQ	done	*if empty, branch to done
	
	move.l	A1,A2	
	addq.l	#1,A2	*move string pointer over one char
	subq.l	#1,D1	*subtract one from the length
	
	move.l	D1,-(SP)
	pea	(A0)	*move outbuff onto stack
	pea	(A2)	*move inbuff  onto stack
	jsr	reverse	*loopback
	adda.l	#12,SP	*push stack back
	
	add.l	D1,A0	
	move.b	(A1),(A0)

done:	movem.l	(SP)+,D1/A0-A2	*return values
	unlk	A6	*unlink
	
	rts
	end
*----------------------------------------------------------------------
