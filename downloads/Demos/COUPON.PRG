*==============================================================================
* Program:				COUPON.PRG
* Purpose:				The Coupon Collector's test for random numbers
* From:				    Hacker's Guide to Visual FoxPro 7
* Copyright:			(c) 2002 Tamar E. Granor, Ted Roche, Doug Hennig and Della Martin
* Last revision:		02/26/02
*==============================================================================
* See how many random numbers it takes to get a complete set
* Run the test multiple times, and return the average.

LPARAMETERS nBoundary, nTests, nSeed
* nBoundary = upper boundary. Go from 0 to nBoundary
*			  Default = 10
* nTests = number of tests to run
*		   Default = 50
* nSeed = seed for RAND()
*		  Default = -1

IF EMPTY(nBoundary) OR TYPE('nBoundary')<>"N"
   nBoundary=10
ENDIF

IF EMPTY(nTests) OR TYPE('nTests')<>"N"
   nTests=50
ENDIF

IF EMPTY(nSeed) OR TYPE('nSeed')<>"N"
   nSeed=-1
ENDIF

LOCAL nTotal, lBins[nBoundary], nRand, lComplete, nPass, nBin

* Start Random numbers
nRand=RAND(nSeed)

nTotal=0

FOR nPass = 1 TO nTests
   lComplete=.F.
   * Set all bins to not seen
   lBins=.F.

   DO WHILE .NOT. lComplete
      nRand=RAND()
      nInt=INT(nBoundary*nRand)+1
      * correct for the very rare case of a 0
      IF nInt<1
         nInt=1
      ENDIF
      lBins[nInt]=.T.
      nTotal=nTotal+1

      * check if we're done
      lComplete=.T.
      FOR nBin=1 TO nBoundary
         lComplete=lComplete AND lBins[nBin]
      ENDFOR
   ENDDO

ENDFOR

* now compute overall average
RETURN nTotal/nTests
