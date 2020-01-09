*==============================================================================
* Program:				DIFFDATE.PRG
* Purpose:				Compute the difference in days between two dates
* From:				    Hacker's Guide to Visual FoxPro 7
* Copyright:			(c) 2002 Tamar E. Granor, Ted Roche, Doug Hennig and Della Martin
* Last revision:		02/26/02
* Returns:				the absolute difference in number of days between 2 dates,
* 						ignoring year, i.e., 9/8/43 vs. 9/9/94 returns 1 and 
* 						7/6/12 vs. 7/5/83 returns 1
*==============================================================================
LPARAMETERS tdDate1, tdDate2
LOCAL ldNewDate, lnDifference, lnYears
* Validate parameters, force to today's date if blank
tdDate1 = MakeItDate(tdDate1)
tdDate2 = MakeItDate(tdDate2)
* Use GOMONTH() function to bring dates into the same year, then
* subtract the difference
lnYears = YEAR(tdDate2) - YEAR(tdDate1)
ldNewDate = GOMONTH(tdDate1, lnYears * 12)
lnDifference = tdDate2 - ldNewDate
* If they're still too far apart, bump ldNewDate a year + / -
IF ABS(lnDifference) > 182
  lnYears = lnYears + 1*SIGN(lnDifference)
  ldNewDate = GOMONTH(tdDate1, lnYears * 12)
  lnDifference = tdDate2 - ldNewDate
ENDIF
RETURN ABS(lnDifference)

FUNCTION MakeItDate (tdDate2Test)
* Validate the parameter is a legitimate date or 
* default to today's date instead
RETURN IIF(EMPTY(tdDate2Test) OR ;
           NOT INLIST(TYPE("tdDate2Test"),"D","T"), ;
           DATE(), ;
           tdDate2Test)
