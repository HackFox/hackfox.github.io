*==============================================================================
* Program:				MAKEMARR.PRG
* Purpose:				Make an array out of the system menu pad and bar names
* From:				    Hacker's Guide to Visual FoxPro 7
* Copyright:			(c) 2002 Tamar E. Granor, Ted Roche, Doug Hennig and Della Martin
* Last revision:		02/26/02
* Returns:				the number of items found
* 						If there's a parameter problem, returns -1.
*==============================================================================
LPARAMETERS aMenuArr
* Have to pass array in so it exists in calling program.

LOCAL cMenuString,nCnt,nNextPos
* cMenuString holds SYS(2013) return
* nCnt is a counter
* nNextPos = position of next blank in string

* Make sure we've got an array
IF TYPE("aMenuArr[1]")="U"
	* bail out
   RETURN -1
ENDIF

cMenuString=SYS(2013)

* Now parse the string and create an array item for each item there
nCnt=0
DO WHILE NOT EMPTY(cMenuString)
   nNextPos=AT(" ",cMenuString)
   IF nNextPos<>0
      nCnt=nCnt+1
      DIMENSION aMenuArr[nCnt]
      aMenuArr[nCnt]=LEFT(cMenuString,nNextPos-1)
      IF nNextPos<LEN(cMenuString)
         cMenuString=SUBSTR(cMenuString,nNextPos+1)
      ELSE
         cMenuString=""
      ENDIF
   ENDIF
ENDDO

RETURN nCnt
