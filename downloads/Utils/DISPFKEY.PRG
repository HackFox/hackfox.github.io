*==============================================================================
* Program:				DISPFKEY.PRG
* Purpose:				* Display a list of all the valid function keys
* From:				    Hacker's Guide to Visual FoxPro 7
* Copyright:			(c) 2002 Tamar E. Granor, Ted Roche, Doug Hennig and Della Martin
* Last revision:		02/26/02
* Notes:				Pass "ON" or "OFF" to determine COMPATIBLE setting
*==============================================================================
LPARAMETER cSetCompat
   * cSetCompat determines setting for SET COMPATIBLE
   * Default to current setting

LOCAL cOldCompat, nCnt
cOldCompat = SET("COMPATIBLE")

IF TYPE('cSetCompat')="C" AND UPPER(cSetCompat)$"ON,OFF"
   SET COMPATIBLE &cSetCompat
ENDIF

FOR nCnt = 1 TO FKMAX()
   ?FKLABEL(nCnt-1)
ENDFOR

SET COMPATIBLE &cOldCompat
RETURN
