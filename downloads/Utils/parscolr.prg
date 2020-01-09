*==============================================================================
* Program:				PARSCOLR.PRG
* Purpose:				Parse color into red, green and blue
* From:				    Hacker's Guide to Visual FoxPro 7
* Copyright:			(c) 2002 Tamar E. Granor, Ted Roche, Doug Hennig and Della Martin
* Last revision:		02/26/02
*==============================================================================
#DEFINE CR CHR(13)

LOCAL nColor, aRGBColor[3], oRGB AS Colors

* Get a color
nColor = GETCOLOR()

oRGB=CREATEOBJECT("Colors")
aRGBColor = oRGB.RGBComp(nColor)

MESSAGEBOX("The color is " + TRANSFORM(nColor) + "." + CR + ;
           "Red: " + TRANSFORM(aRGBColor[1]) + CR + ;
           "Green: " + TRANSFORM(aRGBColor[2]) + CR + ;
           "Blue: " + TRANSFORM(aRGBColor[3]), ;
           "Show array return value", 64)

RETURN

DEFINE CLASS Colors AS Custom
* Color handling code
DIMENSION aRGB[3]

FUNCTION RGBComp(nColor) AS Array
* RGBComp
* Returns the Red, Green and Blue Components 
* of a color in an array

This.aRGB[1] = -1
This.aRGB[2] = -1
This.aRGB[3] = -1

IF VARTYPE(nColor)="N"
   This.aRGB[3] = INT(nColor/(256^2))
   nColor = MOD(nColor,(256^2))
   This.aRGB[2] = INT(nColor/256)
   This.aRGB[1] = MOD(nColor,256)
ENDIF

RETURN @This.aRGB

ENDDEFINE