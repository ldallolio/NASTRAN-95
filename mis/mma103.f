      SUBROUTINE MMA103 ( ZI, ZC )
C
C     MMA103 PERFORMS THE MATRIX OPERATION USING METHOD 10 AND IN
C       COMPLEX SINGLE PRECISION
C
C       (+/-)A(T & NT) * B (+/-)C = D
C     
C     MMA10 USES METHOD 10 WHICH IS AS FOLLOWS:
C       1.  THIS IS FOR "A" NON-TRANSPOSED AND TRANSPOSED
C       2.  UNPACK AS MANY COLUMNS OF "A" INTO MEMORY AS POSSIBLE
C           LEAVING SPACE FOR ONE COLUMN OF "B" AND "D".
C       3.  INITIALIZE EACH COLUMN OF "D" WITH THE DATA FROM "C".
C       4.  USE UNPACK TO READ MATRICES "B" AND "C".
C
C     MEMORY FOR EACH COLUMN OF "A" IS AS FOLLOWS:
C         Z(1)   = FIRST NON-ZERO ROW NUMBER FOR COLUMN
C         Z(2)   = LAST NON-ZERO ROW NUMBER FOR COLUMN
C         Z(3-N) = VALUES OF NON-ZERO ROWS
C
      INTEGER           ZI(2)      ,T
      INTEGER           TYPEI      ,TYPEP    ,TYPEU ,SIGNAB, SIGNC
      INTEGER           RD         ,RDREW    ,WRT   ,WRTREW, CLSREW,CLS
      INTEGER           OFILE      ,FILEA    ,FILEB ,FILEC , FILED
      COMPLEX           ZC(2)
      INCLUDE           'MMACOM.COM'
      COMMON / NAMES  / RD         ,RDREW    ,WRT   ,WRTREW, CLSREW,CLS
      COMMON / TYPE   / IPRC(2)    ,NWORDS(4),IRC(4)
      COMMON / MPYADX / FILEA(7)   ,FILEB(7) ,FILEC(7)    
     1,                 FILED(7)   ,NZ       ,T     ,SIGNAB,SIGNC ,PREC1 
     2,                 SCRTCH     ,TIME
      COMMON / SYSTEM / KSYSTM(152)
      COMMON / UNPAKX / TYPEU      ,IUROW1   ,IUROWN, INCRU
      COMMON / PACKX  / TYPEI      ,TYPEP    ,IPROW1, IPROWN , INCRP
      EQUIVALENCE       (KSYSTM( 1),SYSBUF)  , (KSYSTM( 2),NOUT  ) 
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
C
C   OPEN CORE ALLOCATION AS FOLLOWS:
C     Z( 1        ) = ARRAY FOR ONE COLUMN OF "B" MATRIX
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
C PROCESS ALL OF THE COLUMNS OF "B", ADD "C" DATA ON FIRST PASS
      DO 60000 II = 1, NBC
      IUROW1 = -1
      TYPEU  = NDTYPE * SIGNAB 
      CALL UNPACK ( *930, FILEB, ZC( 1 ) )
      IROWB1 = IUROW1
      IROWBN = IUROWN
      GO TO 940
930   IROWB1 = 0
      IROWBN = 0
940   CONTINUE
      IF ( IFILE .EQ. 0 ) GO TO 950            
      IUROW1 = 1
      IUROWN = NDR
      TYPEU  = NDTYPE 
      IF ( IPASS .EQ. 1 ) TYPEU = NDTYPE * SIGNC
      CALL UNPACK (*950, IFILE, ZC( IDX2+1 ) )
      GO TO 980
950   CONTINUE
      DO 970 J = 1, NDR
      ZC( IDX2+J ) = (0.0,0.0)
970   CONTINUE
980   CONTINUE
      NWDDNAR = NWDD*NAR
C
C CHECK IF COLUMN OF "B" IS NULL
C
      IF ( IROWB1 .EQ. 0 ) GO TO 50000
      IF ( T .NE. 0 ) GO TO 5000
C      
C "A" NON-TRANSPOSE CASE    ( A * B  +  C )      
C
C COMPLEX SINGLE PRECISION
3000  CONTINUE
      DO 3500 I = 1, NCOLPP
      IBROWI = IBROW+I
      IF ( IBROWI .LT. IROWB1 .OR. IBROWI .GT. IROWBN ) GO TO 3500
      IBROWI = IBROWI - IROWB1 + 1
      IF ( ZC( IBROWI ) .EQ. (0.0,0.0) ) GO TO 3500
      INDXA  = IAX + 2*I + ( I-1 )*NWDDNAR 
      IROWA1 = ZI( INDXA-2 )
      IF ( IROWA1 .EQ. 0 ) GO TO 3500   
      IROWAN = ZI( INDXA-1 )
      INDXA  = ( ( INDXA+1 ) / 2 ) - IROWA1
      DO 3400 K = IROWA1, IROWAN
      ZC( IDX2+K ) = ZC( IDX2+K ) +  ZC( INDXA+K ) * ZC( IBROWI )
3400  CONTINUE
3500  CONTINUE
      GO TO 50000
C
C  TRANSPOSE CASE ( A(T) * B + C )
C
5000  CONTINUE      
      IDROW = IBROW
C COMPLEX SINGLE PRECISION
30000 CONTINUE
      DO 35000 I = 1, NCOLPP
      INDXA  = IAX + 2*I + ( I-1 )*NWDDNAR 
      IROWA1 = ZI( INDXA-2 )
      IF ( IROWA1 .EQ. 0 ) GO TO 35000
      IROWAN = ZI( INDXA-1 )
      IROW1  = MAX0( IROWA1, IROWB1 )
      IROWN  = MIN0( IROWAN, IROWBN )
      IF ( IROWN .LT. IROW1 ) GO TO 35000
      INDXA  = ( ( INDXA+1 ) / 2 ) - IROWA1
      IDX2X  = IDX2 + IDROW
      INDXB  = 1 - IROWB1
      DO 34000 K = IROW1, IROWN
      ZC( IDX2X+I ) = ZC( IDX2X+I ) +  ZC( INDXA+K ) * ZC( INDXB+K )
34000 CONTINUE
35000 CONTINUE
      GO TO 50000
C END OF PROCESSING THIS COLUMN FOR THIS PASS
50000 CONTINUE
C  NOW SAVE COLUMN 
      CALL PACK ( ZC( IDX2+1 ), OFILE, FILED )
60000 CONTINUE
      RETURN
      END

