*==============================================================================
* Program:				RESIZE.PRG
* Purpose:				Demonstrate one approach to resizing
* From:				    Hacker's Guide to Visual FoxPro 7
* Copyright:			(c) 2002 Tamar E. Granor, Ted Roche, Doug Hennig and Della Martin
* Last revision:		02/26/02
*==============================================================================


frmResizeDemo = CREATEOBJECT("ResizeForm")
frmResizeDemo.Show()
read events

DEFINE CLASS ResizeForm as Form
  Add Object edtNote as Speech
  Add Object btnQuit as QuitButton
  ScaleMode = 0
  MinHeight = 10
  
  * Custom Properties
  nQuitBtnMargin = 3
  nEdtBoxMargin = 5
  PROCEDURE Init
    THIS.ReSize()
  ENDPROC
  
  Procedure ReSize
    THISFORM.btnQuit.Top = THISFORM.Height - THIS.nQuitBtnMargin
    THISFORM.btnQuit.Left = (THISFORM.Width - ; 			                      
                             THISFORM.btnQuit.Width ) / 2
    THISFORM.edtNote.Height = THISFORM.Height - THISFORM.nEdtBoxMargin
    THISFORM.edtNote.Width  = THISFORM.Width - ;
	 	      		    2*THISFORM.edtNote.Left
  ENDPROC
  
  PROCEDURE Destroy
    CLEAR EVENTS
  ENDPROC
ENDDEFINE

DEFINE CLASS QuitButton AS CommandButton
  Caption="Quit"
  HEIGHT = 20
  PROCEDURE Click
    CLEAR EVENTS
  ENDPROC
ENDDEFINE

DEFINE CLASS Speech AS EditBox
  Left = 3
  Value = "Four score and seven years ago, " + ;
          "our forefathers brought forth upon " + ;
          "this continent a new nation, conceived " + ;
          "in liberty and dedicated to the proposition " + ;
          "that all men were created equal."
ENDDEFINE
