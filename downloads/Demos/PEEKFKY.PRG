*==============================================================================
* Program:				PEEKFKY.PRG
* Purpose:				view a macro file's contents
* From:				    Hacker's Guide to Visual FoxPro 7
* Copyright:			(c) 2002 Tamar E. Granor, Ted Roche, Doug Hennig and Della Martin
* Last revision:		02/26/02
*==============================================================================
private all like l*

lcFile2Read = GETFILE("FKY","Specify file:", "View" ,0)
if not empty(lcFile2Read)
  lnReadHand = FOPEN(lcFile2Read, 0)
  if lnReadHand < 0
    WAIT WINDOW "Error opening file " + lcFile2Read
  else

    = LLRead(lnReadHand,1)  && Skip 1st byte
    ? "Skipped 1st byte"

    ? "Header: " + AscLLRead(lnReadHand) + ;
             " " + AscLLRead(lnReadHand) + ;
             " " + AscLLRead(lnReadHand)   && Read Header

    = LLRead(lnReadHand,12)  && Skip bytes 4 - 15

    * Read # macros
    lbMacroNum = LLRead(lnReadHand,2)
    
    * Low byte, High byte format or high/lo???
    
    lnNumMacros = ASC( LEFT(lbMacroNum,1)) + ;
                  ASC(RIGHT(lbMacroNum,1)) * 256
    ? "Number of macros: " + alltrim(str(lnNumMacros))
    
    for i = 1 to lnNumMacros  && loop through the macros

      lcMacroName = LLRead(lnReadHand,20)  && Read the macro name
      ?
      ? lcMacroName

      * Determine length of macro
      lbMacroLen = LLRead(lnReadHand,2)
      lnMacroLen = ASC( LEFT(lbMacroLen,1)) + ;
                   ASC(RIGHT(lbMacroLen,1)) * 256
      ? "Length: " + alltrim(str(lnMacroLen))

      * Display the keystroke
      ? "Keystroke: "
      ?? "[" + AscLLRead(lnReadHand) + ;
         "," + AscLLRead(lnReadHand) + "]"

      * Display the macro keystrokes
      ?
      for j= 1 to lnMacroLen
        ?? "{" + AscLLRead(lnReadHand) + ;
           "," + AscLLRead(lnReadHand) + "}"
      next
    next  
    =FCLOSE(lnReadHand)
  endif
endif

Procedure LLRead
Parameters tnFileHandle, tnBytes2Read

private lcRetString

lcRetString = FREAD(tnFileHandle, tnBytes2Read)
if len(lcRetString) <> tnBytes2Read or FERROR() <> 0
  do llerrhand
endif
return lcRetString

procedure llErrHand
wait window "Error "+ltrim(str(FERROR()))+ " press any key..."
close all
cancel

Procedure AscLLRead

Parameter tnFileHandle
return ltrim(str(asc(LLRead(tnFileHandle,1))))