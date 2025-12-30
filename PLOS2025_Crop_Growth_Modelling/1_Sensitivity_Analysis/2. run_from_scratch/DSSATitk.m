function [] = DSSATitk(SW, i) % 12208

fileID = fopen( 'CRDA1201.WHX' , 'w');  %    ITKTEST.WHX
fprintf(fileID,'%1s\n','*EXP.DETAILS: CRDA1201RI ESSAI VARIETE DAROU PAKA 2012');
fprintf(fileID,'%1s\n',"");
fprintf(fileID,'%1s\n',"*GENERAL");
fprintf(fileID,'%1s\n',"@PEOPLE");
fprintf(fileID,'%1s\n',"PAUL MARTIAL KOUAKOU");
fprintf(fileID,'%1s\n',"@ADDRESS");
fprintf(fileID,'%1s\n',"CERAAS BP 3320 THIES ESCALE");
fprintf(fileID,'%1s\n',"@SITE");
fprintf(fileID,'%1s\n',"DAROU PAKATHIAR");
fprintf(fileID,'%1s\n',"@ PAREA  PRNO  PLEN  PLDR  PLSP  PLAY HAREA  HRNO  HLEN  HARM.........");
fprintf(fileID,'%1s\n',"    -99     6     3   -99    20   -99   -99     6   -99 ANUEL");
fprintf(fileID,'%1s\n',"");
fprintf(fileID,'%1s\n',"*TREATMENTS                        -------------FACTOR LEVELS------------");
fprintf(fileID,'%1s\n',"@N R O C TNAME.................... CU FL SA IC MP MI MF MR MC MT ME MH SM");
fprintf(fileID,'%1s\n'," 1 1 1 0 F1 NE 4                    1  1  0  1  1  0  1  0  1  1  0  1  1");
fprintf(fileID,'%1s\n',"");
fprintf(fileID,'%1s\n',"");
fprintf(fileID,'%1s\n',"");
fprintf(fileID,'%1s\n',"*CULTIVARS");
fprintf(fileID,'%1s\n',"@C CR INGENO CNAME");
fprintf(fileID,'%1s\n'," 1 RI AR0002 NERICA 4");  %990001 IRRI ORIGINALS");     %329.7 133.5 364.6  12.1 247.1 .063   1.20  83.0  25.3  15.0  15.0
fprintf(fileID,'%1s\n',"");
fprintf(fileID,'%1s\n',"");
fprintf(fileID,'%1s\n',"*FIELDS");
fprintf(fileID,'%1s\n',"@L ID_FIELD WSTA....  FLSA  FLOB  FLDT  FLDD  FLDS  FLST SLTX  SLDP  ID_SOIL    FLNAME");
fprintf(fileID,'%1s\n'," 1 DARO0003 DARO1201   -99   -99 DR000   -99   -99   -99 S      100  CR06002014 EXPERIMENTATION2012");
fprintf(fileID,'%1s\n',"@L ...........XCRD ...........YCRD .....ELEV .............AREA .SLEN .FLWR .SLAS FLHST FHDUR");
fprintf(fileID,'%1s\n'," 1          -15.84           13.96        27              1200    60     3   -99 FH101   -99");
fprintf(fileID,'%1s\n',"");
fprintf(fileID,'%1s\n',"*SOIL ANALYSIS");
fprintf(fileID,'%1s\n',"@A SADAT  SMHB  SMPX  SMKE  SANAME");
fprintf(fileID,'%1s\n'," 1 12153 SA011   -99   -99  ANALYSE SOL");
fprintf(fileID,'%1s\n',"@A  SABL  SADM  SAOC  SANI SAPHW SAPHB  SAPX  SAKE  SASC");
fprintf(fileID,'%1s\n'," 1    15   -99   -99   -99   -99   -99   -99   -99   -99");
fprintf(fileID,'%1s\n',"");
fprintf(fileID,'%1s\n',"*INITIAL CONDITIONS");
fprintf(fileID,'%1s\n',"@C   PCR ICDAT  ICRT  ICND  ICRN  ICRE  ICWD ICRES ICREN ICREP ICRIP ICRID ICNAME");
fprintf(fileID,'%1s\n'," 1    PN 12153   200    10     1     1   -99   -99   -99   -99   -99   -99 INITIAL 1");  % ICWD = -99 ,initial wather table deep
%%
fprintf(fileID,'%1s\n',"@C  ICBL  SH2O  SNH4  SNO3");
% 
% if (i == 1)||(i == 2)   % DARO
% fprintf(fileID,'%1s\n',"  1    10  0.1087    .3   2.9");  % *1.25
% fprintf(fileID,'%1s\n',"  1    20  0.1112    .3   2.9");
% fprintf(fileID,'%1s\n',"  1   100  0.1063    .3   2.9");
% end
% if (i == 3)||(i == 4) ||(i == 5) ||(i == 6) % KOLDA
% fprintf(fileID,'%1s\n',"  1    10  0.1225    .3     3");
% fprintf(fileID,'%1s\n',"  1    20  0.1463    .3     3");
% fprintf(fileID,'%1s\n',"  1   100  0.1100    .3     3");
% end
% if (i == 7)||(i == 8) ||(i == 9)  % SEFA
% fprintf(fileID,'%1s\n',"  1    10  0.1537    .3   2.9");
% fprintf(fileID,'%1s\n',"  1    20  0.2138    .3   2.9");
% fprintf(fileID,'%1s\n',"  1   100  0.1100    .3   2.9");
% end
% if (i == 10)||(i == 11) || (i == 12)||(i == 13) ||(i == 14) ||(i == 15)   % SINTM
% fprintf(fileID,'%1s\n',"  1    10  0.1225    .3     3");
% fprintf(fileID,'%1s\n',"  1    20  0.1313    .3     3");
% fprintf(fileID,'%1s\n',"  1   100  0.0887   .3     3");
% end

fprintf(fileID,'%1s\n'," 1    10   -99   -99   -99");

%%
fprintf(fileID,'%1s\n',"");
fprintf(fileID,'%1s\n',"*PLANTING DETAILS");
fprintf(fileID,'%1s\n',"@P PDATE EDATE  PPOP  PPOE  PLME  PLDS  PLRS  PLRD  PLDP  PLWT  PAGE  PENV  PLPH  SPRL                        PLNAME");
fprintf(fileID,'%1s',  " 1 ");
fprintf(fileID,'%1d', SW  );  
fprintf(fileID,'%1s', " ");
fprintf(fileID,'%1d', SW+4);  
fprintf(fileID,'%1s\n',"    60    60     S     H    25   -99     2   -99   -99   -99   -99   -99                        PLANTING TREATMENT 1");
fprintf(fileID,'%1s\n',"");
fprintf(fileID,'%1s\n',"*IRRIGATION AND WATER MANAGEMENT");
fprintf(fileID,'%1s\n',"@I  EFIR  IDEP  ITHR  IEPT  IOFF  IAME  IAMT IRNAME");
fprintf(fileID,'%1s\n'," 1     1    30    50   100 GS000 IR001    10 -99"); 
fprintf(fileID,'%1s\n',"@I IDATE  IROP IRVAL");
fprintf(fileID,'%1s\n'," 1 12182   -99   -99");
fprintf(fileID,'%1s\n',"");
fprintf(fileID,'%1s\n',"*FERTILIZERS (INORGANIC)");
fprintf(fileID,'%1s\n',"@F FDATE  FMCD  FACD  FDEP  FAMN  FAMP  FAMK  FAMC  FAMO  FOCD FERNAME");
fprintf(fileID,'%1s\n'," 1 12202 FE003 AP002     5    30    30    30   -99   -99   -99 FUMURE F1");
fprintf(fileID,'%1s\n'," 1 12222 FE005 AP002     5    46     0     0   -99   -99   -99 FUMURE F1");
fprintf(fileID,'%1s\n'," 1 12252 FE005 AP002     5    23     0     0   -99   -99   -99 FUMURE F1");
fprintf(fileID,'%1s\n',"");
fprintf(fileID,'%1s\n',"");
fprintf(fileID,'%1s\n',"*RESIDUES AND ORGANIC FERTILIZER");
fprintf(fileID,'%1s\n',"@R RDATE  RCOD  RAMT  RESN  RESP  RESK  RINP  RDEP  RMET RENAME");
fprintf(fileID,'%1s\n'," 1 12153   -99   -99   -99   -99   -99   -99   -99   -99 -99");
fprintf(fileID,'%1s\n',"");
fprintf(fileID,'%1s\n',"*CHEMICAL APPLICATIONS");
fprintf(fileID,'%1s\n',"@C CDATE CHCOD CHAMT  CHME CHDEP   CHT..CHNAME");
fprintf(fileID,'%1s\n'," 1 12202 CH044    10 AP002     2   -99  FURADAN");
fprintf(fileID,'%1s\n'," 1 12222 CH044    10 AP002     2   -99  FURADAN");
fprintf(fileID,'%1s\n'," 1 12252 CH044    10 AP002     2   -99  FURADAN");
fprintf(fileID,'%1s\n',"");
fprintf(fileID,'%1s\n',"*TILLAGE AND ROTATIONS");
fprintf(fileID,'%1s\n',"@T TDATE TIMPL  TDEP TNAME");
fprintf(fileID,'%1s\n'," 1 12184 TI007    25 labour");
fprintf(fileID,'%1s\n',"");
fprintf(fileID,'%1s\n',"*ENVIRONMENT MODIFICATIONS");
fprintf(fileID,'%1s\n',"@E ODATE EDAY  ERAD  EMAX  EMIN  ERAIN ECO2  EDEW  EWIND ENVNAME  ");
fprintf(fileID,'%1s\n'," 1 12152 A   0 A   0 A   0 A   0 A 0,0 A   0 A   0 A   0 ");
fprintf(fileID,'%1s\n',"");
fprintf(fileID,'%1s\n',"*HARVEST DETAILS");
fprintf(fileID,'%1s\n',"@H HDATE  HSTG  HCOM HSIZE   HPC  HBPC HNAME");
fprintf(fileID,'%1s\n'," 1 12334 GS014     H   -99   -99   -99 RECOLTE CYCLE COURT");
fprintf(fileID,'%1s\n'," 1 12334 GS014     H   -99   -99   -99 RECOLTE CYCLE COURT");
fprintf(fileID,'%1s\n'," 2 12334 GS014     H   -99   -99   -99 RECOLTE CYCLE LONG");
fprintf(fileID,'%1s\n'," 2 12334 GS014     H   -99   -99   -99 RECOLTE CYCLE LONG");
fprintf(fileID,'%1s\n',"");
fprintf(fileID,'%1s\n',"*SIMULATION CONTROLS");
fprintf(fileID,'%1s\n',"@N GENERAL     NYERS NREPS START SDATE RSEED SNAME.................... SMODEL");
fprintf(fileID,'%1s\n'," 1 GE              1     1     S 12153  2150 DEFAULT SIMULATION CONTR  RICER");
fprintf(fileID,'%1s\n',"@N OPTIONS     WATER NITRO SYMBI PHOSP POTAS DISES  CHEM  TILL   CO2"); % CROP --> Y ******************************************************
fprintf(fileID,'%1s\n'," 1 OP              Y     N     N     N     N     N     N     Y     M");
fprintf(fileID,'%1s\n',"@N METHODS     WTHER INCON LIGHT EVAPO INFIL PHOTO HYDRO NSWIT MESOM MESEV MESOL");
fprintf(fileID,'%1s\n'," 1 ME              M     M     E     R     S     C     R     1     P     S     2");  %MESOL-->2     3
fprintf(fileID,'%1s\n',"@N MANAGEMENT  PLANT IRRIG FERTI RESID HARVS");
fprintf(fileID,'%1s\n'," 1 MA              R     N     R     N     A"); %R
fprintf(fileID,'%1s\n',"@N OUTPUTS     FNAME OVVEW SUMRY FROPT GROUT CAOUT WAOUT NIOUT MIOUT DIOUT VBOSE CHOUT OPOUT FMOPT");
fprintf(fileID,'%1s\n'," 1 OU              N     Y     Y     1     Y     Y     Y     Y     Y     N     Y     N     Y     A");
fprintf(fileID,'%1s\n',"");
fprintf(fileID,'%1s\n',"@  AUTOMATIC MANAGEMENT");
fprintf(fileID,'%1s\n',"@N PLANTING    PFRST PLAST PH2OL PH2OU PH2OD PSTMX PSTMN");
fprintf(fileID,'%1s\n'," 1 PL          12001 12001    40   100    30    40    10");
fprintf(fileID,'%1s\n',"@N IRRIGATION  IMDEP ITHRL ITHRU IROFF IMETH IRAMT IREFF");
fprintf(fileID,'%1s\n'," 1 IR             30    50   100 GS000 IR001    10     1");
fprintf(fileID,'%1s\n',"@N NITROGEN    NMDEP NMTHR NAMNT NCODE NAOFF");
fprintf(fileID,'%1s\n'," 1 NI             30    50    25 FE001 GS000");
fprintf(fileID,'%1s\n',"@N RESIDUES    RIPCN RTIME RIDEP");
fprintf(fileID,'%1s\n'," 1 RE            100     1    20");
fprintf(fileID,'%1s\n',"@N HARVEST     HFRST HLAST HPCNP HPCNR");
fprintf(fileID,'%1s\n'," 1 HA              0 01001   100     0");
fprintf(fileID,'%1s\n',"");
fprintf(fileID,'%1s\n',"");
fprintf(fileID,'%1s\n',"");
fclose(fileID);

end