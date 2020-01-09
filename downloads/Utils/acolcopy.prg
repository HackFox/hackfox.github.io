*==============================================================================
* Program:				ACOLCOPY.PRG
* Purpose:				Copy one or more columns from a source array to a 
*                       destination array.
* From:				    Hacker's Guide to Visual FoxPro 7
* Copyright:			(c) 2002 Tamar E. Granor, Ted Roche, Doug Hennig and Della Martin
*==============================================================================
nation array.

LPARAMETERS aSource, aDest, nStartCol, nColCount, nDestCol
  * aSource = array to be copied
  * aDest = destination array
  * nStartCol = first column to copy - required
  * nColCount = number of columns to copy - optional. 
  *             Go to end of aSource, if omitted
  * nDestCol = first column of destination to receive copied data - optional
  *            1 if omitted

LOCAL nRetVal,nOldRows,nOldCols,nOldCount,nItem
  * nRetVal = return value, number of columns copied.
  *      = -1, if can't copy
    
* Check source array
IF TYPE("aSource[1]")="U" OR ALEN(aSource,2)=0
  * not a 2-d array, can't do it
  RETURN -1
ENDIF

* Check for starting column
IF TYPE("nStartCol")<>"N"
  RETURN -1
ENDIF

* Check number of columns. Compute if necessary
IF TYPE("nColCount")<>"N" OR nStartCol+nColCount>ALEN(aSource,2)
  nColCount=ALEN(aSource,2)-nStartCol+1
ENDIF

* Check destination column.
IF TYPE("nDestCol")<>"N"
  nDestCol=1
ENDIF
  
* Check destination array for size. It must exist to be passed in.
* First, make sure it's an array.
* Then, see if it's shaped right for all the data.
* Two cases - if enough cols, but not enough rows, can just add
* If not enough cols, have to move data around.
IF TYPE("aDest[1]")="U"
  DIMENSION aDest[ALEN(aSource,1),nColCount+nDestCol-1]
ELSE
  IF ALEN(aDest,2)>=nColCount+nDestCol-1  && enough columns
    IF ALEN(aDest,1)<ALEN(aSource,1)	&& not enough rows
      DIMENSION aDest[ALEN(aSource,1),ALEN(aDest,2)]  && add some
    ENDIF
  ELSE
    * now the hard one
    * not enough columns, so need to add more (and maybe rows, too)
    nOldRows=ALEN(aDest,1)
    nOldCols=ALEN(aDest,2)
    nOldCount=ALEN(aDest)
    DIMENSION aDest[MAX(nOldRows,ALEN(aSource,1)),nColCount+nDestCol-1]
    
    * DIMENSION doesn't preserve data location, so we need to adjust the data
    * We go backward from the end of the array toward the front, moving data 
    * down, so we don't overwrite any data by accident

    FOR nItem=nOldCount TO 2 STEP -1
      * Use new item number and old dimensions to determine
      * new item number for each element
      IF nOldCols<>0
        nRow=CEILING(nItem/nOldCols)
        nCol=MOD(nItem,nOldCols)
        IF nCol=0
          nCol=1
        ENDIF
      ELSE
        nRow=nItem
        nCol=1
      ENDIF
    
      aDest[nRow,nCol]=aDest[nItem]
    ENDFOR
  ENDIF
ENDIF

* finally ready to start copying
FOR nCol=1 TO nColCount
  FOR nRow=1 TO ALEN(aSource,1)
    aDest[nRow,nDestCol+nCol-1]=aSource[nRow,nStartCol+nCol-1]
  ENDFOR
ENDFOR

RETURN nColCount*ALEN(aSource,1)
