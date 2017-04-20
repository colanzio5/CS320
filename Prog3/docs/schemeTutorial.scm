; this is the scheme tutorial for cs320
; To run this 'batch' file, you would type (from the '%' prompt):
; scheme --load schemetutorial.scm
; ...assuming schemetutorial.scm is in your current directory -- otherwise, you
; would have to provide a full pathname to the .scm file, e.g.,
; scheme --load /home/ma/cs320/schemetutorial.scm
;
; the semicolon is the comment character -- everything between the semicolon
; and the end of the line is ignored by the interpreter.
;
; The next 'load' defines many useful commands that are used in the U.C.Berkeley
; introductory programming course.  If you wish to run some of the samples at
; http://www.eecs.berkeley.edu/~bh/ss-toc2.html
; ...make sure you load their definitions first, i.e.:
(load "~cs320/Scheme/simply.scm")
; ...or else some of the commands they use will cause errors.
;
; Remember that every command is a list, with the first atom of the list
; denoting the command name, and the remaining items are the parameters to
; that command.  Each list MUST be enclosed in parentheses.

(display "Here we see that double-quotes can group things" )
; 'display' does not cause a newline to be printed; to start a new line, use:
(newline)
; simply.scm defines a 'show' command, which is 'display' followed by 'newline':
(show "Here is the contents of lst after (DEFINE lst (LIST 'a 'b 'c 'd 'e 'f))")
; LIST (see page 672) combines individual atoms into a list:
; 'LIST' and 'list' are equivalent reserved words (Scheme is NOT case-sensitive)
(DEFINE lst (LIST 'a 'b 'c 'd 'e 'f))
(show lst)
(show "Here is the CAR of lst:")
(show (CAR lst))
(show "Here is the CDR of lst:")
(show (CDR lst))
(show "Sebesta's Sections 15.2 and 15.5.4 (Pages 666/7) describe the sanctity")
(show "of defined constants and the fact that functional languages have no variables.")
(show "The next (re)DEFINE shows that rohan's Scheme does NOT adhere to this:")
(show "This should NOT work: (DEFINE lst (CONS 'm lst))")
(DEFINE lst (CONS 'm lst))
(show lst)
(show "...and yet it does; the 6-element list has become a 7-element list.")
(show "In your programming assignment, do NOT emulate this by using 'variables';")
(show "I want a pure 'functional programming' solution!")
(newline)
(show "If, as you develop your program, you get a 'Premature EOF' error,")
(show "this almost certainly means that you forgot a closing parenthesis.")
(show "If you see 'Unspecified return value', this simply means that the")
(show "function you have called has no standardized return value, so the")
(show "result may be different in different implementations of Scheme.")

