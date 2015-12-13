      BLOCK DATA IFX7BD
CIFX7BD
C     EACH ENTRY CONTAINS THE ADMISSIBLE SEQUAENCE OF FORMAT CODES FOR
C     THAT CARD TYPE.  THE POINTER TO EACH ENTRY IS PROVIDED FROM THE
C     FIRST WORD OF /IFPX5/
C
C     INPUT BULK DATA CARD FORMAT CODE STRINGS
C           0 = BLANK        3 = BCD
C           1 = INTEGER      4 = DOUBLE PRECISION
C           2 = REAL         5 = ANYTHING
C
C     IF THE DIMENSION OF /IFPX7/ IS INCREASED HERE, MAKE THE SAME
C     LABEL COMMON IN IFP ROUTINE THE SMAE SIZE TOO
C
C******
      COMMON /IFPX7/ J1(160),J2(160),J3(160), J4(160), J5(160), J6(160),
     1               J7(160),J8 (80),J9 (56),J10( 56),J11( 24),J12(  8),
     2               J13(16),J14(57),J15(52)
C
C*****
C    1       1              5              9             13
C    2      17             21             25             29
C    3      33             37             41             45
C    4      49             53             57             61
C    5      65             69             73             77
C    6      81             85             89             93
C    7      97            101            105            109
C    8     113            117            121            125
C    9     129            133            137            141
C    X     145            149            153            157
      DATA J1 /
     1     1, 1, 2, 2 ,   2, 1, 1, 1 ,   0, 0, 0, 0 ,   0, 1, 0, 0
     2 ,   0, 1, 1, 1 ,   0, 0, 0, 0 ,   0, 1, 0, 0 ,   5, 2, 2, 1
     3 ,   0, 0, 0, 0 ,   1, 1, 1, 1 ,   1, 1, 1, 1 ,   1, 1, 2, 2
     4 ,   2, 2, 2, 2 ,   2, 2, 2, 0 ,   0, 0, 0, 0 ,   1, 2, 1, 1
     5 ,   2, 2, 0, 0 ,   0, 0, 0, 0 ,   1, 1, 1, 1 ,   5, 2, 2, 1
     6 ,   1, 1, 2, 2 ,   2, 2, 2, 2 ,   0, 0, 0, 0 ,   1, 1, 0, 0
     7 ,   0, 0, 0, 0 ,   1, 1, 1, 2 ,   1, 1, 2, 0 ,   1, 1, 5, 2
     8 ,   2, 2, 2, 0 ,   0, 0, 0, 0 ,   1, 1, 2, 1 ,   1, 0, 0, 0
     9 ,   0, 0, 0, 0 ,   1, 1, 2, 1 ,   1, 1, 1, 0 ,   0, 0, 0, 0
     X ,   1, 2, 1, 1 ,   1, 1, 0, 0 ,   0, 0, 0, 0 ,   1, 1, 2, 1 /
C
C*****
C    1     161            165            169            173
C    2     177            181            185            189
C    3     193            197            201            205
C    4     209            213            217            221
C    5     225            229            233            237
C    6     241            245            249            253
C    7     257            261            265            269
C    8     273            277            281            285
C    9     289            293            297            301
C    X     305            309            313            317
      DATA J2 /
     1     2, 1, 2, 0 ,   1, 1, 2, 2 ,   2, 2, 1, 1 ,   1, 2, 2, 2
     2 ,   1, 1, 2, 2 ,   2, 0, 0, 0 ,   0, 0, 0, 0 ,   1, 2, 2, 0
     3 ,   1, 2, 2, 0 ,   1, 1, 2, 2 ,   2, 2, 2, 2 ,   2, 2, 2, 2
     4 ,   2, 2, 2, 2 ,   2, 2, 2, 2 ,   0, 0, 0, 0 ,   1, 1, 2, 1
     5 ,   2, 1, 2, 2 ,   2, 2, 0, 0 ,   0, 0, 0, 0 ,   1, 1, 2, 2
     6 ,   1, 1, 2, 2 ,   1, 0, 2, 2 ,   0, 0, 1, 0 ,   0, 0, 0, 0
     7 ,   1, 1, 2, 1 ,   2, 2, 2, 2 ,   0, 0, 0, 0 ,   1, 2, 1, 2
     8 ,   1, 2, 1, 2 ,   1, 1, 1, 1 ,   2, 2, 2, 2 ,   0, 0, 0, 0
     9 ,   1, 1, 1, 1 ,   2, 2, 2, 1 ,   1, 1, 2, 2 ,   2, 2, 2, 2
     X ,   2, 2, 2, 2 ,   0, 0, 0, 0 ,   1, 1, 1, 1 ,   1, 2, 0, 0 /
C
C*****
C    1     321            325            329            333
C    2     337            341            345            349
C    3     353            357            361            365
C    4     369            373            377            381
C    5     385            389            393            397
C    6     401            405            409            413
C    7     417            421            425            429
C    8     433            437            441            445
C    9     449            453            457            461
C    X     465            469            473            477
      DATA J3 /
     1     0, 0, 0, 0 ,   1, 1, 1, 1 ,   1, 1, 2, 0 ,   0, 0, 0, 0
     2 ,   1, 1, 1, 1 ,   1, 1, 0, 0 ,   0, 0, 0, 0 ,   1, 1, 1, 2
     3 ,   2, 2, 2, 2 ,   2, 2, 2, 2 ,   2, 2, 2, 2 ,   2, 2, 2, 2
     4 ,   2, 2, 2, 2 ,   0, 0, 0, 0 ,   1, 1, 1, 2 ,   2, 2, 2, 0
     5 ,   2, 2, 2, 2 ,   2, 2, 0, 0 ,   0, 0, 0, 0 ,   1, 2, 1, 1
     6 ,   1, 1, 0, 0 ,   0, 0, 0, 0 ,   1, 2, 1, 1 ,   1, 2, 1, 1
     7 ,   1, 2, 1, 1 ,   1, 1, 2, 2 ,   0, 0, 0, 0 ,   1, 2, 2, 2
     8 ,   2, 2, 2, 2 ,   2, 2, 2, 1 ,   0, 0, 0, 0 ,   1, 2, 2, 2
     9 ,   2, 2, 2, 2 ,   2, 2, 2, 2 ,   2, 2, 2, 2 ,   1, 0, 0, 0
     X ,   0, 0, 0, 0 ,   1, 3, 2, 2 ,   1, 1, 1, 2 ,   3, 1, 1, 0  /
C
C*****
C    1     481            485            489            493
C    2     497            501            505            509
C    3     513            517            521            525
C    4     529            533            537            541
C    5     545            549            553            557
C    6     561            565            569            573
C    7     577            581            585            589
C    8     593            597            601            605
C    9     609            613            617            621
C    X     625            629            633            637
      DATA J4 /
     1     0, 0, 0, 0 ,   1, 1, 1, 1 ,   2, 0, 0, 0 ,   0, 0, 0, 0
     2 ,   1, 2, 2, 2 ,   1, 2, 2, 2 ,   1, 1, 1, 0 ,   1, 1, 1, 0
     3 ,   0, 0, 0, 0 ,   1, 1, 2, 0 ,   0, 0, 0, 0 ,   1, 1, 1, 1
     4 ,   1, 1, 1, 1 ,   1, 1, 1, 1 ,   1, 1, 1, 1 ,   5, 0, 0, 0
     5 ,   1, 1, 1, 1 ,   1, 1, 1, 1 ,   1, 1, 1, 0 ,   0, 0, 0, 0
     6 ,   1, 2, 2, 1 ,   2, 2, 1, 0 ,   0, 0, 0, 0 ,   1, 1, 1, 2
     7 ,   1, 2, 1, 2 ,   0, 0, 0, 0 ,   1, 1, 1, 1 ,   1, 0, 0, 0
     8 ,   0, 0, 0, 0 ,   1, 1, 1, 2 ,   1, 1, 1, 0 ,   2, 2, 2, 2
     9 ,   2, 2, 0, 0 ,   2, 2, 2, 2 ,   2, 2, 0, 0 ,   1, 1, 2, 2
     X ,   2, 2, 2, 1 ,   2, 2, 2, 2 ,   2, 2, 2, 2 ,   2, 2, 2, 0 /
C
C*****
C    1     641            645            649            653
C    2     657            661            665            669
C    3     673            677            681            685
C    4     689            693            697            701
C    5     705            709            713            717
C    6     721            725            729            733
C    7     737            741            745            749
C    8     753            757            761            765
C    9     769            773            777            781
C    X     785            789            793            797
      DATA J5 /
     1     0, 0, 0, 0 ,   1, 1, 1, 1 ,   0, 0, 0, 0 ,   1, 1, 2, 1
     2 ,   2, 1, 2, 2 ,   2, 2, 2, 2 ,   2, 2, 2, 2 ,   2, 2, 2, 2
     3 ,   2, 2, 2, 2 ,   0, 0, 0, 0 ,   1, 1, 1, 1 ,   1, 1, 0, 0
     4 ,   1, 1, 1, 1 ,   2, 2, 2, 2 ,   2, 2, 0, 0 ,   0, 0, 0, 0
     5 ,   1, 2, 2, 1 ,   0, 0, 0, 0 ,   1, 1, 1, 2 ,   2, 0, 0, 0
     6 ,   0, 0, 0, 0 ,   1, 1, 1, 2 ,   1, 1, 5, 5 ,   0, 0, 0, 0
     7 ,   1, 1, 1, 1 ,   1, 2, 1, 0 ,   0, 0, 0, 0 ,   0, 1, 1, 1
     8 ,   1, 2, 2, 0 ,   0, 0, 0, 0 ,   0, 1, 1, 2 ,   2, 1, 0, 0
     9 ,   0, 0, 0, 0 ,   0, 1, 2, 1 ,   5, 1, 1, 1 ,   1, 1, 1, 1
     X ,   2, 2, 1, 0 ,   0, 0, 0, 0 ,   0, 1, 5, 1 ,   1, 1, 1, 1 /
C
C*****
C    1     801            805            809            813
C    2     817            821            825            829
C    3     833            837            841            845
C    4     849            853            857            861
C    5     865            869            873            877
C    6     881            885            889            893
C    7     897            901            905            909
C    8     913            917            921            925
C    9     929            933            937            941
C    X     945            949            953            957
      DATA J6 /
     1     1, 1, 1, 2 ,   2, 2, 2, 2 ,   2, 2, 2, 2 ,   2, 2, 2, 2
     2 ,   2, 2, 2, 2 ,   2, 2, 2, 2 ,   2, 1, 3, 3 ,   0, 0, 0, 0
     3 ,   0, 1, 0, 1 ,   2, 1, 2, 1 ,   2,-9,-9,-9 ,   1, 1, 1, 0
     4 ,   0, 2, 2, 0 ,   1, 1, 1, 1 ,   0, 2, 2, 0 ,   1, 1, 1, 1
     5 ,   1, 2, 2, 0 ,   2, 2, 1, 2 ,   1, 0, 0, 0 ,   1, 1, 1, 1
     6 ,   1, 2, 2, 1 ,   1, 2, 2, 0 ,   0, 0, 0, 0 ,   1, 2, 2, 2
     7 ,   1, 0, 0, 0 ,   1, 3, 2, 2 ,   1, 1, 1, 1 ,   1, 1, 3, 1
     8 ,   1, 1, 1, 1 ,   1, 1, 1, 1 ,   2, 2, 2, 0 ,   1, 1, 5, 5
     9 ,   5, 5, 5, 5 ,   5, 5, 5, 5 ,   5, 5, 5, 5 ,   5, 5, 5, 5
     X ,   5, 5, 5, 5 ,   1, 2, 1, 1 ,   1, 1, 1, 1 ,   1, 1, 1, 1 /
C
C*****
C    1      961            965            969            973
C    2      977            981            985            989
C    3      993            997           1001           1005
C    4     1009           1013           1017           1021
C    5     1025           1029           1033           1037
C    6     1041           1045           1049           1053
C    7     1057           1061           1065           1069
C    8     1073           1077           1081           1085
C    9     1089           1093           1097           1101
C    X     1105           1109           1113           1117
      DATA J7 /
     1     1, 1, 1, 1 ,   1, 1, 1, 1 ,   1, 1, 1, 1 ,   1, 1, 1, 1
     2 ,   1, 1, 1, 1 ,   1, 1, 1, 1 ,   5, 5, 5, 0 ,   0, 0,-9,-9
     3 ,   1, 1, 3, 3 ,   2, 2, 2, 2 ,   0, 0, 0, 0 ,   1, 3, 1, 1
     4 ,   1, 3, 1, 2 ,   0, 0, 0, 0 ,   1, 2, 2, 1 ,   3, 0, 0, 0
     5 ,   1, 1, 1, 1 ,   1, 2, 2, 1 ,   2, 2, 0, 0 ,   1, 2, 2, 1
     6 ,   1, 1, 0, 0 ,   1, 1, 1, 1 ,   1, 1, 1, 1 ,   1, 1, 1, 1
     7 ,   1, 1, 2, 0 ,   0, 0, 0, 0 ,   3, 1, 1, 1 ,   1, 1, 1, 0
     8 ,   1, 3, 1, 1 ,   1, 1, 1, 1 ,   3, 1, 1, 2 ,   1, 1, 2,-9
     9 ,   1, 1, 2, 2 ,   2, 1, 2, 2 ,   2, 2, 2, 2 ,   2, 2, 2, 2
     X ,   1, 1, 2, 2 ,   2, 1, 2, 2 ,   2, 1, 2, 2 ,   2, 2, 2, 2  /
C
C*****
C    1     1121           1125           1129           1133
C    2     1137           1141           1145           1149
C    3     1153           1157           1161           1165
C    4     1169-1200
      DATA J8 /
     1     2, 2, 2, 2 ,   5, 5, 5, 5 ,   1, 3, 2, 2 ,   1, 1, 1, 1
     2 ,   1, 1, 1, 1 ,   1, 1, 0, 0 ,   0, 0, 0, 0 ,   0, 0, 0, 0
     3 ,   1, 3, 1, 1 ,   2, 2, 0, 0 ,  -9,-9,-9,-9 ,  -9,-9,-9,-9
     4 ,   32*0 /
C
C*****
C    1     1201           1205-1252      1253
      DATA J9 /
     1     1, 2, 2, 2,    48*2,          0, 0, 0, 0                 /
C
C*****
C    1     1257           1261-1308      1309
      DATA J10/
     1     1, 1, 1, 1,    48*1,          0, 0, 0, 0                 /
C
C*****
C    1     1313           1317           1321           1325
C    2     1329           1333
      DATA J11/
     1     1, 2, 1, 2,    2, 2, 2, 2,    2, 2, 2, 2,    1, 0, 0, 0,
     2     1, 1, 2, 2,    2, 1, 5, 1                                /
C
C*****
C    1     1337           1341
      DATA J12/
     1     1, 1, 5, 1,    1, 1, 1, 1                                /
C
C*****
C    1     1345           1349           1353           1357
      DATA J13/
     1     1, 1, 2, 2,    2, 2, 2, 2,    2, 2, 5, 5,    5, 5, 5, 5  /
C
C*****
C    1     1361-1416      1417
      DATA J14/
     1     56*5,          5                                         /
C
C*****
C    1     1418           1422           1426           1430
C    2     1434           1438           1442           1446
C    3     1450           1454           1458           1462
C    4     1466
      DATA J15/
     1     1, 1, 1, 1,    1, 1, 5, 2,    0, 0, 2, 2,    2, 2, 0, 0,
     2     1, 2, 2, 2,    2, 2, 2, 2,    2, 2, 2, 2,    2, 2, 2, 2,
     3     2, 2, 0, 0,    1, 1, 1, 1,    1, 5, 2, 0,    0, 0, 2, 2,
     4     2, 0, 0, 0                                               /
C
      END
