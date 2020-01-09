*==============================================================================
* Program:				ACOLSCAN.PRG
* Purpose:				Search a specified column of an array for a particular 
*                       value. Return the row number of the first occurrence. 
*                       Return 0 if not found. Return -1 if any parameter is no good.
* From:				    Hacker's Guide to Visual FoxPro 7
* Copyright:			(c) 2002 Tamar E. Granor, Ted Roche, Doug Hennig and Della Martin
* Last revision:		02/26/02
*==============================================================================

LPARAMETERS aArray, eElement, nColumn
	* aArray = the array in which to search
	* eElement = the item to search for. It can be any scalar type
	* nColumn = the column in which to search
	
LOCAL lFoundIt,nStartPos,nFoundElem

* check parameters
IF TYPE("aArray[1]")="U"
	RETURN -1
ENDIF

IF TYPE("nColumn")<>"N" OR NOT BETWEEN(nColumn,1,ALEN(aArray,2))
	RETURN -1
ENDIF

* ready to go
lFoundIt=.F.
nStartPos=1
DO WHILE NOT lFoundIt AND nStartPos<=ALEN(aArray)
	nFoundElem=ASCAN(aArray,eElement,nStartPos)
	IF nFoundElem>0
		IF ASUBSCRIPT(aArray,nFoundElem,2)=nColumn
			lFoundIt=.T.
		ELSE
			nStartPos=nFoundElem+1
		ENDIF
	ELSE
		nStartPos=ALEN(aArray)+1
	ENDIF
ENDDO

IF nStartPos>ALEN(aArray)
	RETURN 0
ELSE
	RETURN ASUBSCRIPT(aArray,nFoundElem,1)
ENDIF

RETURN
		