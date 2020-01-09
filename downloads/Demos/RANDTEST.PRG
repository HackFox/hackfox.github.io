*==============================================================================
* Program:				RANDTEST.PRG
* Purpose:				Test the randomness of FoxPro's random number generator.
* From:				    Hacker's Guide to Visual FoxPro 7
* Copyright:			(c) 2002 Tamar E. Granor, Ted Roche, Doug Hennig and Della Martin
* Last revision:		02/26/02
*==============================================================================
* Test the randomness of FoxPro's random number generator.
* We do this by generating a series of randon numbers and
* putting them in 10 bins, one for each .1 from 0 to 1.
* Then we perform the Chi-Squared test on the result to
* get a measure of how good the results are.
* Returns the result of the Chi-Squared test

LPARAMETERS nTestCount, nSeed
* nTestCount = the number of test values to generate
*			   default = 2000
* nSeed = initial seed value to use for testing
*		  if nSeed is omitted, we use -1 as the initial seed

IF EMPTY(nTestCount) OR TYPE('nTestCount')<>"N"
   nTestCount=2000
ENDIF

IF EMPTY(nSeed) OR TYPE('nSeed')<>"N"
   nSeed=-1
ENDIF

LOCAL aBins[10], nRand, nCnt, nBin, nExpected, nChi
aBins=0

* Start random numbers
nRand=RAND(nSeed)

* Loop through specified number
FOR nCnt=1 TO nTestCount
   nRand=RAND()
   nBin=INT(10*nRand)+1
   * correct in case we get exactly 1 back from RAND()
   IF nBin>10
      nBin=10
   ENDIF
   aBins[nBin]=aBins[nBin]+1
ENDFOR

* now do Chi-Squared test
nExpected = nTestCount/10
nChi=0

FOR nBin = 1 TO 10
   nChi=nChi+(aBins[nBin]-nExpected)^2/nExpected
ENDFOR

RETURN nChi
