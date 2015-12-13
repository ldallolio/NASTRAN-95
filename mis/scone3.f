      SUBROUTINE SCONE3( AGAIN )
C
      REAL III
C
      INTEGER IFORCE(25), ISTRES(100), ELEMID, IBLOCK(9,14)
C
      LOGICAL AGAIN
C
      COMMON /SDR2X7/ DUM(5),III,ZOFF(2),DUM2(92),STRESS(100),FORCE(25)
C
      COMMON /SDR2X8/ VEC(8), SUM(8), SIG(3), SIG1, SIG2, SIG12, TEMP,
     1 DELTA, THETA, NPOINT, ZOVERI, IPT, BLOCK(9,14), ELHAR, ELEMID,
     2 HARM, N, SINPHI, CONPHI, NPHI, NANGLE
C
      EQUIVALENCE( ISTRES(1), STRESS(1) )
      EQUIVALENCE( IFORCE(1), FORCE (1) )
      EQUIVALENCE( IBLOCK(1,1),BLOCK(1,1) )
C
      IF( AGAIN ) GO TO 10
      AGAIN = .TRUE.
      NANGLE = 0
   10 NANGLE = NANGLE + 1
C*****
C     OUTPUT FORCES FOR THIS ANGLE
C*****
      IFORCE(1) = ELEMID
      FORCE(2) = BLOCK(1,NANGLE)
      FORCE(3) = BLOCK(5,NANGLE)
      FORCE(4) = BLOCK(6,NANGLE)
      FORCE(5) = BLOCK(7,NANGLE)
      FORCE(6) = BLOCK(8,NANGLE)
      FORCE(7) = BLOCK(9,NANGLE)
C*****
C COMPUTE AND OUTPUT STRESSES AND PRINCIPAL STRESSES
C*****
      ISTRES(1) = ELEMID
      STRESS(2) = BLOCK(1,NANGLE)
      DO 70 I = 1,2
      ZOVERI=0.0
      IF (III .NE. 0.0) ZOVERI=ZOFF(I)/III
      DO 40 J = 1,3
   40 SIG(J) = BLOCK(J+1,NANGLE) + BLOCK(J+4,NANGLE) * ZOVERI
      TEMP = SIG(1) - SIG(2)
      SIG12 = SQRT( (TEMP*0.50E0)**2 + SIG(3)**2 )
      DELTA = ( SIG(1) + SIG(2) ) * 0.50E0
      SIG1 = DELTA + SIG12
      SIG2 = DELTA - SIG12
      DELTA = 2.0E0 * SIG(3)
      IF( ABS(DELTA) .LT. 1.0E-15 .AND. ABS(TEMP) .LT. 1.0E-15 )GO TO 50
      THETA = ATAN2( DELTA, TEMP ) * 28.6478898E0
      GO TO 60
   50 THETA = 0.0E0
   60 IPT = 8*I-6
      STRESS(IPT+1) = ZOFF(I)
      STRESS(IPT+2) = SIG(1)
      STRESS(IPT+3) = SIG(2)
      STRESS(IPT+4) = SIG(3)
      STRESS(IPT+5) = THETA
      STRESS(IPT+6) = SIG1
      STRESS(IPT+7) = SIG2
      STRESS(IPT+8) = SIG12
   70 CONTINUE
C*****
C SET AGAIN .FALSE. IF SDR2E IS NOT TO CALL THIS ROUTINE AGAIN FOR THIS
C ELEMENT.. E.G. ALL THE ANGLES DESIRED HAVE BEEN PROCESSED...
C*****
      IF( NANGLE .EQ. 14 ) GO TO 100
      IF( IBLOCK(1,NANGLE+1) .EQ. 1 ) GO TO 100
      RETURN
  100 AGAIN = .FALSE.
      RETURN
      END
