*==============================================================================
* Program:				AINDEXES.PRG
* Purpose:				Fills an array with index information for a table
* From:				    Hacker's Guide to Visual FoxPro 7
* Copyright:			(c) 2002 Tamar E. Granor, Ted Roche, Doug Hennig and Della Martin
* Last revision:		02/26/02
* Returns: 				the number of indexes found, if successful
*          				0 if the table has no indexes
*          				-1 if no parameters are passed
*          				-2 if the first parameter is not an array
*          				-3 if no alias is passed and there's no table open
*          				-4 if the passed alias doesn't exist
*==============================================================================

PARAMETERS aIndexInfo,cAlias
* aIndexInfo = array to place index information
*	If there are any indexes, the array returns 9 columns:
*		1 - index type: "I" or "C"
*		2 - index (tag) name
* 		3 - index file name
*		4 - index key
*		5 - index filter
*		6 - descending?
*		7 - unique in the Xbase sense?
*		8 - primary key?
*		9 - candidate key?

* cAlias = alias about which to return index information
*		   if omitted, report on current work area

LOCAL nParams,nOldArea,nIDXCount,nCDXCount,nTagCount,nTotalCount

nParams=PARAMETERS()

IF nParams=0
	* no array specified
	RETURN -1
ELSE
	IF TYPE("aIndexInfo[1]")="U"
		RETURN -2
	ENDIF
ENDIF

IF nParams=1
	* use current work area
	IF EMPTY(ALIAS())
	* no table in use
		RETURN -3
	ENDIF
ELSE
	IF TYPE('cAlias')<>"C" OR NOT USED(cAlias)
		RETURN -4
	ENDIF
ENDIF

nOldArea = SELECT()
IF nParams>1
	SELECT (cAlias)
ENDIF

* ready to start going through indexes
* do IDX files first
nTotalCount=0
nIDXCount=1

DO WHILE NOT EMPTY(NDX(nIDXCount))
	nTotalCount=nTotalCount+1
	DIMENSION aIndexInfo[nTotalCount,9]
	aIndexInfo[nTotalCount,1]="I"
	aIndexInfo[nTotalCount,2]=TAG(nIDXCount)
	aIndexInfo[nTotalCount,3]=NDX(nIDXCount)
	aIndexInfo[nTotalCount,4]=KEY(nIDXCount)
	aIndexInfo[nTotalCount,5]=FOR(nIDXCount)
	aIndexInfo[nTotalCount,6]=DESCENDING(nIDXCount)
	aIndexInfo[nTotalCount,7]=UNIQUE(nIDXCount)
	aIndexInfo[nTotalCount,8]=.F.
	aIndexInfo[nTotalCount,9]=.F.

	nIDXCount=nIDXCount+1
ENDDO

* now CDX's one by one
nCDXCount=1
DO WHILE NOT EMPTY(CDX(nCDXCount))
	nTagCount=1
	cCDXName=CDX(nCDXCount)
	DO WHILE NOT EMPTY(TAG(cCDXName,nTagCount))
		nTotalCount=nTotalCount+1
		DIMENSION aIndexInfo[nTotalCount,9]
		aIndexInfo[nTotalCount,1]="C"
		aIndexInfo[nTotalCount,2]=TAG(cCDXName,nTagCount)
		aIndexInfo[nTotalCount,3]=cCDXName
		aIndexInfo[nTotalCount,4]=KEY(cCDXNAME,nTagCount)
		aIndexInfo[nTotalCount,5]=FOR(nTotalCount)
		aIndexInfo[nTotalCount,6]=DESCENDING(cCDXName,nTagCount)
		aIndexInfo[nTotalCount,7]=UNIQUE(cCDXName,nTagCount)
		aIndexInfo[nTotalCount,8]=PRIMARY(nTotalCount)
		aIndexInfo[nTotalCount,9]=CANDIDATE(nTotalCount)

		nTagCount=nTagCount+1
	ENDDO

	nCDXCount=nCDXCount+1
ENDDO

* now clean up
SELECT (nOldArea)

RETURN nTotalCount
