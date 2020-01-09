*==============================================================================
* Program:				PARSFONT.PRG
* Purpose:				Call GETFONT() and parse the return value into its 
*						three components: name, size, style
* From:				    Hacker's Guide to Visual FoxPro 7
* Copyright:			(c) 2002 Tamar E. Granor, Ted Roche, Doug Hennig and Della Martin
* Last revision:		02/26/02
* Sample Call:
*     DO ParsFont WITH cFontName, nFontSize, cFontStyle, nCharSet
* or:
*     ParsFont(@cFontName, @nFontSize, @cFontStyle, @nCharSet)
*==============================================================================

LPARAMETERS cFontName, nFontSize, cFontStyle, nCharSet

LOCAL cFontInfo, nCommaPos1, nCommaPos2, nCommaPos3

* Call varies depending on parameters passed
DO CASE
CASE EMPTY(cFontName) OR TYPE("cFontName")<>"C"
   cFontInfo=GETFONT()
CASE TYPE("nFontSize")<>"N" OR nFontSize = 0
   cFontInfo = GETFONT(cFontName)
CASE EMPTY(cFontStyle) OR TYPE("cFontStyle")<>"C"
   cFontInfo = GETFONT(cFontName, nFontSize)
CASE TYPE("nCharSet") <> "N" OR nCharSet = 0
   cFontInfo = GETFONT(cFontName, nFontSize, cFontStyle)
OTHERWISE
   cFontInfo = GETFONT(cFontName, nFontSize, cFontStyle, nCharSet)
ENDCASE

IF NOT EMPTY(cFontInfo)
   nLines = ALINES( aFontInfo, cFontInfo, .T., ",")
   cFontName = aFontInfo[ 1 ]
   nFontSize = INT(VAL( aFontInfo[ 2 ] ))
   cFontStyle = aFontInfo[ 3 ] 
   IF nLines = 4
      nCharSet = INT(VAL( aFontInfo [ 4 ] ))
   ENDIF
ENDIF

RETURN
