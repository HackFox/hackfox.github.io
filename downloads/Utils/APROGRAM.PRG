*==============================================================================
* Program:				APROGRAM.PRG
* Purpose:				* Fill an array with the programs in use.
* From:				    Hacker's Guide to Visual FoxPro 7
* Copyright:			(c) 2002 Tamar E. Granor, Ted Roche, Doug Hennig and Della Martin
* Last revision:		02/26/02
* Returns:				The size of the array.
*						If parameter isn't an array, return -1.
*						Column 1 contains the program name returned by PROGRAM().
* 						Column 2 contains the detailed information returned by SYS(16).
*==============================================================================
LPARAMETERS aProgs
EXTERNAL ARRAY aProgs

* Check parameter
IF TYPE("aProgs[1]")="U"
	RETURN -1
ENDIF

* Trace the calling chain
LOCAL nLevel
nLevel = 1
DO WHILE NOT EMPTY(PROGRAM(nLevel))
	DIMENSION aProgs[nLevel,2]
	aProgs[nLevel,1]=PROGRAM(nLevel)
	aProgs[nLevel,2]=SYS(16,nLevel)
	nLevel=nLevel+1
ENDDO

* now remove last rows which represents this program
* Test just in case called from Command Window
IF nLevel>2
	DIMENSION aProgs[nLevel-2,2]
	nLevel=nLevel-2
ELSE
	* Called from Command Window. 
	nLevel=1
ENDIF

RETURN nLevel

