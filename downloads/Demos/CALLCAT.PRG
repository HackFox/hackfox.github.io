*==============================================================================
* Program:				CALLCAT.PRG
* Purpose:				Call the sample form for the CatMover 
* From:				    Hacker's Guide to Visual FoxPro 7
* Copyright:			(c) 2002 Tamar E. Granor, Ted Roche, Doug Hennig and Della Martin
* Last revision:		02/26/02
*==============================================================================

USE Category IN 0
USE Items IN 0
SET PATH TO ..\Utils
DO FORM testcat with "category","items","cat_name","cat_id","Item_Name","cat_id","item_id",.t.,.t.