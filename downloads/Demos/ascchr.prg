*==============================================================================
* Program:				ASCCHR.PRG
* Purpose:				ASCII Table form
* From:				    Hacker's Guide to Visual FoxPro 7
* Copyright:			(c) 2002 Tamar E. Granor, Ted Roche, Doug Hennig and Della Martin
* Last revision:		02/26/02
*==============================================================================

DEFINE CLASS chartable AS form
	DIMENSION aChars[8,32]
	nChoice=0
	cFont=""
	Left=0
	Top=0

	ADD OBJECT cboFonts AS FontCombo
	ADD OBJECT txtEchoChar AS TextBox
	ADD OBJECT lblEchoChar AS Label
	ADD OBJECT txtEchoNum AS TextBox
	ADD OBJECT lblEchoNum AS Label
	ADD OBJECT cmdClose AS CloseButton

	PROCEDURE Init
	
	LOCAL nCnt,nRow,nCol,nMaxWidth,nMaxHeight,nSize
	
	THISFORM.FontName=WFONT(1)

	FOR nCnt=0 TO 255
		THIS.AddObject("THIS.aChars[nCnt+1]","CharButton",nCnt)
		THIS.aChars[nCnt+1].Visible=.T.
		nRow=INT(nCnt/32)+1
		nCol=nCnt-(nRow-1)*32+1
	
		THIS.aChars[nCnt+1].Left=(nCol-1)*THIS.aChars[nCnt+1].Width+12
		THIS.aChars[nCnt+1].Top=(nRow-1)*THIS.aChars[nCnt+1].Height+;
								THIS.cboFonts.Top+THIS.cboFonts.Height+24
					
	ENDFOR

	THIS.ResizeChars
	
	THIS.cboFonts.Top=16
	THIS.cboFonts.Left=12

	THIS.Caption="ASCII Character Table"
	
	THIS.Width=THIS.aChars[1,1].Width*ALEN(THIS.aChars,2)+24
	THIS.Height=THIS.aChars[1,1].Height*ALEN(THIS.aChars,1)+ ;
	             THIS.cboFonts.HEIGHT+64
	
	* set up echo textbox
	THIS.lblEchoChar.Caption="Current Choice"
	THIS.lblEchoChar.Width=96
	THIS.lblEchoChar.Height=24
	THIS.lblEchoChar.Top=16
	THIS.lblEchoChar.Left=THIS.cboFonts.Left+THIS.cboFonts.Width+30
	
	THIS.txtEchoChar.Value=CHR(THIS.nChoice)
	THIS.txtEchoChar.FontName=THIS.FontName
	THIS.txtEchoChar.Width=24
	THIS.txtEchoChar.Height=24
	THIS.txtEchoChar.Enabled=.F.
	THIS.txtEchoChar.Top=16
	THIS.txtEchoChar.Left=THIS.lblEchoChar.Left+THIS.lblEchoChar.Width+12
	
	THIS.lblEchoNum.Caption="Character Number"
	THIS.lblEchoNum.Width=120
	THIS.lblEchoNum.Height=24
	THIS.lblEchoNum.Top=16
	THIS.lblEchoNum.Left=THIS.txtEchoChar.Left+THIS.txtEchoChar.Width+30
	
	THIS.txtEchoNum.Value=THIS.nChoice
	THIS.txtEchoNum.FontName="Arial"
	THIS.txtEchoNum.Width=30
	THIS.txtEchoNum.Height=24
	THIS.txtEchoNum.Top=16
	THIS.txtEchoNum.Left=THIS.lblEchoNum.Left+THIS.lblEchoNum.Width+30
	
	THIS.cmdClose.Top=THIS.aChars[1].Top+ ;
	                  ALEN(THIS.aChars,1)*THIS.aChars[1].Height + 8
	THIS.cmdClose.Left=(THIS.Width-THIS.cmdClose.Width)/2    


	ENDPROC
	
	PROCEDURE Destroy
	
	THIS.Visible=.F.
	ENDPROC	
	
	PROCEDURE cboFonts.InteractiveChange

	LOCAL nCnt,nMaxWidth,nMaxHeight,nSize
	
	THISFORM.LockScreen = .T.
	THISFORM.FontName=THIS.Value
	FOR nCnt=1 TO ALEN(THISFORM.aChars)
		THISFORM.aChars[nCnt].FontName=THISFORM.FontName
	ENDFOR
	THISFORM.txtEchoChar.FontName=THISFORM.FontName
	
	THISFORM.ResizeChars
	THISFORM.LockScreen = .F.
	ENDPROC

	PROCEDURE ResizeChars
	* custom method to adjust size of characters 
	
	nMaxWidth=THIS.aChars[1].Width-6
	nMaxHeight=THIS.aChars[1].Height-4
	IF FONTMETRIC(7)>nMaxWidth
		* choose a smaller size
		FOR nSize=THIS.FontSize-1 TO 4 STEP -1
			IF FONTMETRIC(7,THIS.FontName,nSize)<=nMaxWidth 
				EXIT
			ENDIF
		ENDFOR
		IF nSize>3
			THIS.FontSize=nSize
		ENDIF
	ELSE
		* check for a larger size
		nSize=THIS.FontSize+1
		DO WHILE FONTMETRIC(7,THIS.FontName,nSize)<=nMaxWidth ;
		     AND FONTMETRIC(1,THIS.FontName,nSize)<=nMaxHeight
			nSize=nSize+1
		ENDDO
		THIS.FontSize=nSize-1
	ENDIF
	IF THIS.FontSize<>THIS.aChars[1].FontSize
		THIS.LockScreen = .T.
		FOR nCnt=1 TO 256
			THIS.aChars[nCnt].FontSize=THIS.FontSize
		ENDFOR
		THIS.LockScreen = .F.
	ENDIF
	
	ENDPROC

ENDDEFINE

DEFINE CLASS CharButton AS CommandButton

	Height=24
	Width=18
	Visible=.T.
	Enabled=.T.

	PROCEDURE Init
	
	PARAMETER nChar
	LOCAL nRow,nCol
	 
	THIS.Caption=CHR(nChar)
	THIS.Name = "CharButton"+LTRIM(STR(nChar))
	
	ENDPROC
	
	PROCEDURE Click
	PARAMETER dummy
	
	THISFORM.nChoice=ASC(THIS.Caption)
	THISFORM.txtEchoChar.Value=THIS.Caption
	THISFORM.txtEchoNum.Value=THISFORM.nChoice
*	WAIT WINDOW "Clicked "+THIS.Caption NOWAIT
	
	THISFORM.Refresh
	ENDPROC
ENDDEFINE

DEFINE CLASS FontCombo AS ComboBox

	DIMENSION aFonts[1]
	HEIGHT=24
	Width=185
	Style=2

	PROCEDURE Init
	
	=AFONT(THIS.aFonts)
	THIS.RowSourceType=5
	THIS.RowSource="THIS.aFonts"
	THIS.Value=THISFORM.FontName

	ENDPROC

	PROCEDURE InteractiveChange
	* User uses combo to change fonts
	
	THISFORM.FontName=THIS.Value
	ENDPROC
	
ENDDEFINE

DEFINE CLASS CloseButton AS CommandButton

	Caption="Close"
	Height=24
	Width=48
	
	PROCEDURE Click
	
	RELEASE THISFORM
	
	ENDPROC
ENDDEFINE