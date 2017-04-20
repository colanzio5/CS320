;p3.scm (cs320 Program 3, Spring 2017)
;GRADE_EARLY_FILE


;Colin Casazza
;cssc0112
;John Carroll
;CS3320

;apart from adding the above header comments, leave this file section UNCHANGED
;To run this file, you would type (from the '%' prompt):
; scheme --load p3.scm
;

(load "~cs320/Scheme/simply.scm")
;Here I define a few handy lists that we can manipulate:

(DEFINE list1 (LIST 'a 'b 'c 'd 'e 'f 'g))
(DEFINE list2 (LIST 's 't 'u 'v 'w 'x 'y 'z))
(DEFINE list3 '((a b) c (d e f) g (h i)) )
(DEFINE list4 (LIST 'n 'o 'p 'q 'q 'p 'o 'n))
(DEFINE list5 '((a b) c (d (e f)) g (h i)) )
(DEFINE list6 '((h i) (j k) l (m n o)))

;here is a typical function definition (from Page 681 of Sebesta):
(DEFINE (adder lis)
  (COND
    ((NULL? lis) 0)
    (ELSE (+ (CAR lis) (adder (CDR lis))))
))
;the above five lines are the sort of definition you would need to add to
;this file if you were asked to:
;"Create a function that accepts a single list as a parameter and returns
;the sum of the [numerical] atoms in the list.  To do this, uncomment the
;next DEFINE and modify it to conform to the specs."
; (DEFINE (adder ...complete this definition
; 
; 'adder' has already been defined for you (see above), but you must create
; the following four definitions [see ~cs320/program3 for full details]
; So, uncomment the next four DEFINEs, and modify them to conform to the
; specs given in the ~cs320/program3 writeup.

;-----------THIRDS------------------------------;
(DEFINE (thirds lis)
	(IF (NOT (NULL? lis))
	(CONS (CAR lis)
		(IF (NULL? (CDDR lis))
		()
		(thirds (cdddr lis))))
	()
	))

;----------EVENATOM-----------------------------;
(DEFINE (evenatom lis)				; returns the negation of an evaluation for odd elements
  (NOT (AND (NOT (NULL? lis))			; initial check to break recursion
       (OR (NOT (PAIR? lis))			; odd set of atoms will have one atom w/ no pair
           (NOT (EQ? (evenatom (CAR lis))	; returns #f if theres no pair
                     (evenatom (CDR lis)))))))) ; recursively extends across lst seing if pair exists

;------------RSWAP---------------------------;
(DEFINE (rswap lis)
	(IF (OR (NULL? lis) (NULL? (CDR lis)))
	lis
	(CONS (CADR lis)
		(CONS (CAR lis)
			(rswap (CDDR lis))))))
