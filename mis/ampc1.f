      SUBROUTINE AMPC1(INPUT,OUTPUT,NCOL,Z,MCB)
C
C     THE PURPOSE OF THIS ROUTINE IS TO COPY NCOL COLUMNS FROM INPUT
C      TO OUTPUT VIA UNPACK AND PACK.
C
C     THE PACK COMMON BLOCKS HAVE BEEN INITIALIZED OUTSIDE THE ROUTINE
C
      INTEGER OUTPUT,MCB(7),Z(1)
C
      COMMON /PACKX/IT1,IT2,II,NN,INCR
C
C-----------------------------------------------------------------------
C
      DO 10 I=1,NCOL
      CALL UNPACK(*20,INPUT,Z)
      CALL PACK(Z,OUTPUT,MCB)
      GO TO 10
C
C     NULL COLUMN
C
   20 CALL BLDPK(IT1,IT2,OUTPUT,0,0)
      CALL BLDPKN(OUTPUT,0,MCB)
   10 CONTINUE
      RETURN
      END
