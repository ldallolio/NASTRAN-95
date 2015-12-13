      SUBROUTINE SUBI (DA,DZB,DYB,DAR,DETA,DZETA,DCGAM,DSGAM,DEE,DXI,TL,
     1                 DETAI,DZETAI,DCGAMI,DSGAMI,DEEI,DTLAMI,DMUY,DMUZ,
     2                 INFL,IOUTFL)
C
C     COMPUTES THE IMAGE POINT COORDINATES INSIDE ASSOCIATED BODIES AND
C     THE  MU-Z  MU-Y  ELEMENTS USED IN SUBROUTINE FWMW
C
      EPS   = 0.1*DEE
      DMUY  = 0.0
      DMUZ  = 0.0
      IGO   = 1
      PSQR  = SQRT(((DETA-DYB)*DAR)**2 + (DZETA-DZB)**2)
      COSTH = (DETA -DYB)*DAR/PSQR
      SINTH = (DZETA-DZB)/PSQR
      CT2   = COSTH*COSTH
      ST2   = SINTH*SINTH
      CT3   = COSTH*CT2
      ST3   = SINTH*ST2
      YCBAR = DA*(1.0-DAR*DAR)*CT3 + DYB
      ZCBAR = DA*(DAR*DAR-1.0)*ST3/DAR + DZB
      PAREN = ST2 + DAR*DAR*CT2
      PAR3  = PAREN*PAREN**2
      ABAR  = DA*SQRT(PAR3)/DAR
      ABAR2 = ABAR*ABAR
      IF (INFL .NE. 0)  GO TO  300
      ETA1  = DETA  - DEE*DCGAM
      ETA2  = DETA  + DEE*DCGAM
      ZETA1 = DZETA - DEE*DSGAM
      ZETA2 = DZETA + DEE*DSGAM
      RHO12 = (ETA1 - YCBAR)**2 + (ZETA1-ZCBAR)**2
      RHO22 = (ETA2 - YCBAR)**2 + (ZETA2-ZCBAR)**2
      ETAI1 = YCBAR + (ETA1-YCBAR)*ABAR2/RHO12
      ETAI2 = YCBAR + (ETA2-YCBAR)*ABAR2/RHO22
      ZETI1 = ZCBAR + (ZETA1-ZCBAR)*ABAR2/RHO12
      ZETI2 = ZCBAR + (ZETA2-ZCBAR)*ABAR2/RHO22
      DEEI  = SQRT((ETAI2-ETAI1)**2 + (ZETI2-ZETI1)**2)/2.0
      DETAI = (ETAI1 + ETAI2)/2.0
      DZETAI= (ZETI1 + ZETI2)/2.0
      DCGAMI=-(ETAI2 - ETAI1)/(2.0*DEEI)
      DSGAMI=-(ZETI2 - ZETI1)/(2.0*DEEI)
      DXI1  = DXI  - DEE*TL
      DXI2  = DXI  + DEE*TL
      DELXI = DXI1 - DXI2
      DTLAMI= DELXI/(2.0*DEEI)
      IF (ABS(DAR-1.0) .LE. 0.0001)  GO TO  420
      GO TO 301
  300 CONTINUE
      RHO2  = (DETA-YCBAR)**2 + (DZETA-ZCBAR)**2
      RHO4  = RHO2*RHO2
      DETAI = YCBAR + (DETA -YCBAR)*ABAR2/RHO2
      DZETAI= ZCBAR + (DZETA-ZCBAR)*ABAR2/RHO2
  301 CONTINUE
      GO TO (302,303,304), IGO
  302 CONTINUE
      XETAI = DETAI
      XZETAI= DZETAI
      GO TO 307
  303 CONTINUE
      XETAI = ETAI1
      XZETAI= ZETI1
      GO TO  307
  304 CONTINUE
      XETAI = ETAI2
      XZETAI= ZETI2
  307 CONTINUE
      IF (DAR .LT. 1.0) GO TO  310
      DYBM  = DYB - EPS
      DYBP  = DYB + EPS
      IF (DETA .GE.DYB .AND. XETAI .LT.DYBM) GO TO  325
      IF (DETA .LE.DYB .AND. XETAI .GT.DYBP) GO TO  325
      GO TO  320
  310 CONTINUE
      DZBM  = DZB - EPS
      DZBP  = DZB + EPS
      IF (DZETA.GE.DZB .AND. XZETAI.LT.DZBM) GO TO  325
      IF (DZETA.LE.DZB .AND. XZETAI.GT.DZBP) GO TO  325
  320 CONTINUE
      PART1 = ((XETAI  - DYB)/DA)**2
      PART2 = ((XZETAI - DZB)/(DA*DAR))**2
      TEDIF = PART1 + PART2 - 1.0
      IF (INFL  .EQ.   0) GO TO  400
      IF (TEDIF .LE. EPS) GO TO  330
  325 CONTINUE
      IOUTFL = 0
      GO TO  500
  330 CONTINUE
      IOUTFL = 1
      TRM1 = (DETA-YCBAR)**2 - (DZETA-ZCBAR)**2
      TRM2 = 2.0*(DETA-YCBAR)*(DZETA-ZCBAR)
      DMUY = -(-DSGAM*TRM1 + DCGAM*TRM2)*ABAR2/RHO4
      DMUZ = -(-DSGAM*TRM2 - DCGAM*TRM1)*ABAR2/RHO4
      GO TO 500
  400 CONTINUE
      IF (TEDIF .GT. EPS) GO TO 325
      IF (IGO   .EQ.   3) GO TO 420
      IGO  = IGO + 1
      GO TO 301
  420 CONTINUE
      IOUTFL = 1
  500 CONTINUE
      RETURN
      END
