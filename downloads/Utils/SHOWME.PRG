*==============================================================================
* Program:				SHOWME.PRG
* Purpose:				Multi-line wait window to display any type of value
* From:				    Hacker's Guide to Visual FoxPro 7
* Copyright:			(c) 2002 Tamar E. Granor, Ted Roche, Doug Hennig and Della Martin
* Last revision:		02/26/02
*==============================================================================

LPARAMETER txWhat2Show
LOCAL lcMessage, lnNumLines
NOTE that "S" is not in the list below - it is not possible to pass ;
     it as a parameter. Error 9, "Data type mismatch' occurs.

DO CASE
  *************
  * Character *
  *************
  CASE TYPE('txWhat2Show') = "C" or ;
       TYPE('txWhat2Show') = "M"
    * Multi-line / word-wrapped text gets special handling
    IF MEMLINES(txWhat2Show) > 1
      lcMessage =  iif(TYPE('txWhat2Show') = "C","Character: " ,"Memo: ") + ;
         CHR(13)
      _MLINE = 0
      FOR lnNumLines = 1 TO MEMLINES(txWhat2Show)
        lcMessage = lcMessage + MLINE(txWhat2Show,1,_MLINE) + CHR(13)
      NEXT
      * Truncate W.W. argument to 254 characters - more explodes
      WAIT WINDOW NOWAIT LEFT(lcMessage,MIN(254,len(lcMessage)-1))
    ELSE
      WAIT WINDOW NOWAIT  "Character: " + txWhat2Show
    endif
  ********
  * Date *
  ********
  CASE TYPE('txWhat2Show') = "D"
    WAIT WINDOW NOWAIT "Date: " + DTOC(txWhat2Show)
  ***********
  * General *
  ***********
  CASE TYPE('txWhat2Show') = "G"
    WAIT WINDOW NOWAIT "Parameter passed is a general field" + CHR(13) + ;
                       " and cannot be displayed."
  ***********
  * Logical *
  ***********
  CASE TYPE('txWhat2Show') = "L"
    WAIT WINDOW NOWAIT  "Logical: " + ;
    IIF(ISNULL(txWhat2Show),".NULL.", ;
        IIF(txWhat2Show,"True","False"))
  ***********
  * Numeric *
  ***********
  CASE TYPE('txWhat2Show') = "N"
    WAIT WINDOW NOWAIT  "Numeric: " + ;
       ALLTRIM(transform(txWhat2Show, "@^"))
  **********
  * Object *
  **********
  CASE TYPE('txWhat2Show') = "O"
      WAIT WINDOW NOWAIT "Object" + ;
         iif(type('txWhat2Show.Name')="C"," named " + txWhat2Show.Name, "")
  ************
  * DateTime *
  ************
  CASE TYPE('txWhat2Show') = "T"
    WAIT WINDOW NOWAIT "DateTime: " + TTOC(txWhat2Show)
  ************
  * Currency *
  ************
  CASE TYPE('txWhat2Show') = "Y"
    WAIT WINDOW NOWAIT "Currency: " + ALLTRIM(TRANSFORM(txWhat2Show,"@$"))
  ****************
  * Unknown Type *
  ****************
  OTHERWISE
    WAIT WINDOW "Parameter is of unknown type " + TYPE('txWhat2Show')
ENDCASE
RETURN
