*==============================================================================
* Program:				ARELNS.PRG
* Purpose:				Fill an array with all relations from a specified table.
* From:				    Hacker's Guide to Visual FoxPro 7
* Copyright:			(c) 2002 Tamar E. Granor, Ted Roche, Doug Hennig and Della Martin
* Last revision:		02/26/02
* Returns:				the number of relations
* 						If there's a problem with parameters, return -1
*==============================================================================
PARAMETERS aRelations,cAlias
* aRelations = array to hold relation info
* cAlias = alias of the parent. If omitted, current work area

LOCAL nParams, nRelCnt

nParams=PARAMETERS()

IF nParams=0 OR TYPE('aRelations[1]')="U"
   RETURN -1
ENDIF

IF nParams=1
   * use current work area
   IF EMPTY(ALIAS())
      * no table in use
      RETURN -1
   ENDIF
ELSE
   IF TYPE('cAlias')<>"C" OR NOT USED(cAlias)
      RETURN -1
   ENDIF
ENDIF

nOldArea = SELECT()
IF nParams>1
   SELECT (cAlias)
ENDIF

* now start processing relation information
nRelCnt=1
DO WHILE NOT EMPTY(RELATION(nRelCnt))
   DIMENSION aRelations[nRelCnt,2]
   aRelations[nRelCnt,1]=RELATION(nRelCnt)
   aRelations[nRelCnt,2]=TARGET(nRelCnt)
   nRelCnt=nRelCnt+1
ENDDO

RETURN nRelCnt-1
