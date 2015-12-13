      SUBROUTINE MMA314 ( ZI, ZD, ZDC )
C
C     MMA314 PERFORMS THE MATRIX OPERATION IN COMPLEX DOUBLE PRECISION
C       (+/-)A(T & NT) * B (+/-)C = D
C     
C     MMA314 USES METHOD 31 WHICH IS AS FOLLOWS:
C       1.  THIS IS FOR "A" NON-TRANSPOSED AND TRANSPOSED
C       2.  CALL MMARM1 TO PACK AS MANY COLUMNS OF "A" INTO MEMORY 
C           AS POSSIBLE LEAVING SPACE FOR ONE COLUMN OF "B" AND "D".
C       3.  INITIALIZE EACH COLUMN OF "D" WITH THE DATA FROM "C".
C       4.  UNPACK COLUMNS OF "C" MATRIX BUT USE GETSTR (MMARC1,2,3,4)
C           TO READ COLUMNS OF "B".
C
      INTEGER           ZI(2)      ,T
      INTEGER           TYPEI      ,TYPEP    ,TYPEU ,SIGNAB, SIGNC
      INTEGER           RD         ,RDREW    ,WRT   ,WRTREW, CLSREW,CLS
      INTEGER           OFILE      ,FILEA    ,FILEB ,FILEC , FILED
      DOUBLE PRECISION  ZD(2)
      DOUBLE COMPLEX    ZDC(2)
      INCLUDE           'MMACOM.COM'     
      COMMON / NAMES  / RD         ,RDREW    ,WRT   ,WRTREW, CLSREW,CLS
      COMMON / TYPE   / IPRC(2)    ,NWORDS(4),IRC(4)
      COMMON / MPYADX / FILEA(7)   ,FILEB(7) ,FILEC(7)    
     1,                 FILED(7)   ,NZ       ,T     ,SIGNAB,SIGNC ,PREC1 
     2,                 SCRTCH     ,TIME
      COMMON / SYSTEM / KSYSTM(152)
      COMMON / UNPAKX / TYPEU      ,IUROW1   ,IUROWN, INCRU
      COMMON / PACKX  / TYPEI      ,TYPEP    ,IPROW1, IPROWN , INCRP
      EQUIVALENCE       (KSYSTM( 1),SYSBUF)  , (KSYSTM( 2),IWR   ) 
      EQUIVALENCE       (FILEA(2)  ,NAC   )  , (FILEA(3)  ,NAR   )
     1,                 (FILEA(4)  ,NAFORM)  , (FILEA(5)  ,NATYPE)
     2,                 (FILEA(6)  ,NANZWD)  , (FILEA(7)  ,NADENS)
      EQUIVALENCE       (FILEB(2)  ,NBC   )  , (FILEB(3)  ,NBR   )
     1,                 (FILEB(4)  ,NBFORM)  , (FILEB(5)  ,NBTYPE)
     2,                 (FILEB(6)  ,NBNZWD)  , (FILEB(7)  ,NBDENS)
      EQUIVALENCE       (FILEC(2)  ,NCC   )  , (FILEC(3)  ,NCR   )
     1,                 (FILEC(4)  ,NCFORM)  , (FILEC(5)  ,NCTYPE)
     2,                 (FILEC(6)  ,NCNZWD)  , (FILEC(7)  ,NCDENS)
      EQUIVALENCE       (FILED(2)  ,NDC   )  , (FILED(3)  ,NDR   )
     1,                 (FILED(4)  ,NDFORM)  , (FILED(5)  ,NDTYPE)
     2,                 (FILED(6)  ,NDNZWD)  , (FILED(7)  ,NDDENS)
C
C   OPEN CORE ALLOCATION AS FOLLOWS:
C     Z( 1        ) = ARRAY FOR ONE COLUMN OF "B" MATRIX IN COMPACT FORM
C     Z( IDX      ) = ARRAY FOR ONE COLUMN OF "D" MATRIX
C     Z( IAX      ) = ARRAY FOR MULTIPLE COLUMNS OF "A" MATRIX
C        THROUGH
C     Z( LASMEM   )
C     Z( IBUF4    ) = BUFFER FOR "D" FILE
C     Z( IBUF3    ) = BUFFER FOR "C" FILE
C     Z( IBUF2    ) = BUFFER FOR "B" FILE 
C     Z( IBUF1    ) = BUFFER FOR "A" FILE
C     Z( NZ       ) = END OF OPEN CORE THAT IS AVAILABLE
C
      IRFILE = FILEB( 1 )
      DO 60000 II = 1, NBC
C      PRINT *,' PROCESSING COLUMN=',II
C      
C READ A COLUMN FROM THE "B" MATRIX
C
      CALL MMARC4 ( ZI, ZD )
C
C NOW READ "C", OR SCRATCH FILE WITH INTERMEDIATE RESULTS.
C IF NO "C" FILE AND THIS IS THE FIRST PASS, INITIALIZE "D" COLUMN TO ZERO.
C
      IF ( IFILE .EQ. 0 ) GO TO 950            
      IUROW1 = 1
      IUROWN = NDR
      TYPEU  = NDTYPE 
      IF ( IPASS .EQ. 1 ) TYPEU = NDTYPE * SIGNC
      CALL UNPACK (*950, IFILE, ZDC( IDX4+1 ) )
      GO TO 980
950   CONTINUE
      DO 970 J = 1, NDR
      ZDC( IDX4+J ) = 0
970   CONTINUE
980   CONTINUE
C
C CHECK IF COLUMN OF "B" IS NULL
C
      IROWB1 = ZI( 1 )
      IROWS  = ZI( 2 ) 
      IROWBN = IROWB1 + IROWS - 1
      INDXB  = 1
      INDXA  = IAX
C      
C CHECK FOR NULL COLUMN FROM "B" MATRIX
C
      IF ( IROWB1 .EQ. 0 ) GO TO 50000
      IF ( T .NE. 0 ) GO TO 5000
C      
C "A" NON-TRANSPOSE CASE    ( A * B  +  C )      
C
C DOUBLE PRECISION
1000  CONTINUE
      DO 1500 I = 1, NCOLPP
      INDXAL = ZI( INDXA + 1 ) + IAX - 1
      ICOLA  = IBROW+I
      IF ( ICOLA .NE. IABS( ZI( INDXA ) ) ) GO TO 70001
      INDXA  = INDXA + 2
1100  CONTINUE
      IF ( ICOLA .LT. IROWB1 ) GO TO 1450
      IF ( ICOLA .LE. IROWBN ) GO TO 1200
      INDXB  = INDXB + 2 + IROWS*NWDD
      IF ( INDXB .GT. LASIND ) GO TO 50000
      IROWB1 = ZI( INDXB )
      IROWS  = ZI( INDXB+1 )
      IROWBN = IROWB1 + IROWS - 1
      GO TO 1100
1200  CONTINUE
      INDXBV = 2 * ( ICOLA - IROWB1 ) + ( INDXB + 3 ) / 2
      IF ( ZD( INDXBV ) .EQ. 0. ) GO TO 1450
1300  CONTINUE
      IF ( INDXA .GE. INDXAL ) GO TO 1450
      IROWA1 = ZI( INDXA )
      NTMS   = ZI( INDXA+1 )
      IROWAN = IROWA1 + NTMS - 1
      INDXAV = ( (INDXA+3 ) / 2 ) 
      DO 1400 K = IROWA1, IROWAN
      ZDC( IDX4+K ) = ZDC( IDX4+K ) +
     &                DCMPLX( ZD(INDXAV), ZD(INDXAV+1) ) * 
     &                DCMPLX( ZD(INDXBV), ZD(INDXBV+1) )
      INDXAV = INDXAV + 2
1400  CONTINUE
      INDXA  = INDXA + 2 + NTMS*NWDD
      GO TO 1300
1450  INDXA  = INDXAL
1500  CONTINUE
      GO TO 50000
C
C  TRANSPOSE CASE ( A(T) * B + C )
C
5000  CONTINUE      
      IDROW = IBROW
      IDXX  = IDX4 + IDROW      
C DOUBLE PRECISION
10000 CONTINUE
      DO 15000 I = 1, NCOLPP
      ICOLA  = IBROW + I
      IF ( ICOLA .NE. IABS( ZI( INDXA ) ) ) GO TO 70001
      INDXAL = ZI( INDXA+1 ) + IAX - 1
      INDXA  = INDXA + 2
      INDXB  = 1
11000 IF ( INDXB .GE. LASIND ) GO TO 14500
      IROWB1 = ZI( INDXB )
      IROWS  = ZI( INDXB+1 )
      IROWBN = IROWB1 + IROWS - 1
      INDXBS = INDXB
      INDXB  = INDXB + 2 + IROWS*NWDD
12000 CONTINUE
      IF ( INDXA .GE. INDXAL ) GO TO 14500
      IROWA1 = ZI( INDXA )
      NTMS   = ZI( INDXA+1 )
      IROWAN = IROWA1 + NTMS - 1
      IF ( IROWBN .LT. IROWA1 ) GO TO 11000
      IF ( IROWAN .LT. IROWB1 ) GO TO 14200
      IROW1  = MAX0( IROWA1, IROWB1 )
      IROWN  = MIN0( IROWAN, IROWBN )
      INDXAV = ( ( INDXA +3 ) / 2 ) + 2*( IROW1 - IROWA1 ) - 1
      INDXBV = ( ( INDXBS+3 ) / 2 ) + 2*( IROW1 - IROWB1 ) - 1       
      KCNT   = ( IROWN - IROW1 ) * 2 + 1
      DO 14000 K = 1, KCNT, 2
      ZDC( IDXX+I ) = ZDC( IDXX+I ) +  
     &               DCMPLX(  ZD( INDXAV+K ), ZD( INDXAV+K+1 ) ) * 
     &               DCMPLX(  ZD( INDXBV+K ), ZD( INDXBV+K+1 ) )
14000 CONTINUE                                                
      IF ( IROWAN .GT. IROWBN ) GO TO 11000
14200 CONTINUE
      INDXA  = INDXA + 2 + NTMS*NWDD
      GO TO 12000
14500 INDXA  = INDXAL
15000 CONTINUE
      GO TO 50000
C END OF PROCESSING THIS COLUMN FOR THIS PASS
50000 CONTINUE
C  NOW SAVE COLUMN 
      CALL PACK ( ZDC( IDX4+1 ), OFILE, FILED )
60000 CONTINUE
      GO TO 70000
70001 CONTINUE
      WRITE ( IWR, 90001 ) ICOLA, ZI( INDXA ), IAX, INDXA
90001 FORMAT(' UNEXPECTED COLUMN FOUND IN PROCESSING MATRIX A'
     &,/,' COLUMN EXPECTED:',I6
     &,/,' COLUND FOUND   :',I6
     &,/,' IAX =',I7,' INDXA=',I7 )
      CALL MESAGE ( -61, 0, 0 )
70000 RETURN
      END
