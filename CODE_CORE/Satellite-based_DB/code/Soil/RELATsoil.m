function [SOILFET2] = RELATsoil(LON, LAT, SL1, SL2, SL21, SL22)


  for i = 1 : numel(LON) % 1019
            longitudT = round(LON(i),2);
            latitudT = round(LAT(i),2);
            
            if LON(i) < (-14)
                SL = SL1;
                DD = ( (-14) - (-17) ) / size(SL,1); 
                longitudV1 = [-17: DD : -14]; longitudV1 = round(longitudV1(1:end-1),2);

                DD2 = ( (12) - (15) ) / size(SL,2);
                latitudV2 = [15: DD2 : 12]; latitudV2 = round(latitudV2(1:end-1),2);
                
                [idx1] = [longitudT == longitudV1].*[1:1:numel(longitudV1)]; idx1 = idx1(idx1 > 0);
                [idx2] = [latitudT == latitudV2 ].*[1:1:numel(latitudV2 )];  idx2 = idx2(idx2 > 0);
                
                plot(LON(i), LAT(i), 'b*'), hold on
                if numel(idx1) && numel(idx2)
                    LONs = longitudV1(idx1(round(numel(idx1)/2)) );
                    LATs = latitudV2( idx2(round(numel(idx2)/2)) );
                    plot(LONs, LATs, 'c.'), hold on
    
    
                    SAND(i,1) = SL(idx1(round(numel(idx1)/2)),idx2(round(numel(idx2)/2)),3 ) / 1000  ;
                    SILT(i,1) = SL(idx1(round(numel(idx1)/2)),idx2(round(numel(idx2)/2)),9 ) / 1000  ;
                    CLAY(i,1) = SL(idx1(round(numel(idx1)/2)),idx2(round(numel(idx2)/2)),15 )/ 1000  ;
    
                    BULK(i,1) = SL(idx1(round(numel(idx1)/2)),idx2(round(numel(idx2)/2)),21 ) / 100 ;
                    

                    CORS(i,1) = SL21(idx1(round(numel(idx1)/2)),idx2(round(numel(idx2)/2)),3 ) / 100 ;
                    CARB(i,1) = SL21(idx1(round(numel(idx1)/2)),idx2(round(numel(idx2)/2)),9 )/ 100 ;
                    N(i,1) = SL21(idx1(round(numel(idx1)/2)),idx2(round(numel(idx2)/2)),15 )   / 100 ;
                    PH(i,1) = SL21(idx1(round(numel(idx1)/2)),idx2(round(numel(idx2)/2)),21)  / 10  ;
                end
                
                
            else 
                SL = SL2;
                DD = ( (-11) - (-14) ) / size(SL,1); 
                longitudV1 = [-14: DD : -11]; longitudV1 = round(longitudV1(1:end-1),2);

                DD2 = ( (12) - (15) ) / size(SL,2);
                latitudV2 = [15: DD2 : 12]; latitudV2 = round(latitudV2(1:end-1),2);

               [idx1] = [longitudT == longitudV1].*[1:1:numel(longitudV1)]; idx1 = idx1(idx1 > 0);
               [idx2] = [latitudT == latitudV2 ].*[1:1:numel(latitudV2 )];  idx2 = idx2(idx2 > 0);

               plot(LON(i), LAT(i), 'b*'), hold on
               if numel(idx1) && numel(idx2)
                   LONs = longitudV1(idx1(round(numel(idx1)/2)) );
                   LATs = latitudV2( idx2(round(numel(idx2)/2)) );
                   plot(LONs,LATs, 'c.'), hold on ; % plot(LONs,LATs, 'k.'), hold on 
    
                   SAND(i,1) = SL(idx1(round(numel(idx1)/2)),idx2(round(numel(idx2)/2)),3 ) / 1000 ;
                   SILT(i,1) = SL(idx1(round(numel(idx1)/2)),idx2(round(numel(idx2)/2)),9 ) / 1000 ;
                   CLAY(i,1) = SL(idx1(round(numel(idx1)/2)),idx2(round(numel(idx2)/2)),15 )/ 1000 ;
    
                   BULK(i,1) = SL(idx1(round(numel(idx1)/2)),idx2(round(numel(idx2)/2)),21 ) / 100;

                   
                   CORS(i,1) = SL22(idx1(round(numel(idx1)/2)),idx2(round(numel(idx2)/2)),3 ) / 100;
                   CARB(i,1) = SL22(idx1(round(numel(idx1)/2)),idx2(round(numel(idx2)/2)),9 )/ 100;
                   N(i,1) = SL22(idx1(round(numel(idx1)/2)),idx2(round(numel(idx2)/2)),15 )/ 100;
                   PH(i,1) = SL22(idx1(round(numel(idx1)/2)),idx2(round(numel(idx2)/2)),21)/ 10;
               end 
               
            end
  end

  SOILFET2 = [LON, LAT, SAND, SILT, CLAY, BULK, CORS, CARB, N, PH]; 
  % save('SOILFET2.mat','SOILFET2')   % SOILFET = [LON, LAT, SAND', SILT', CLAY', BULK', CORS', CARB', N', PH'];


% %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% m == 1 para mostrar las medias y desviacion estandar
% 
% SL1 = [ [SOL{12};SOL{1}], [SOL{11};SOL{2}] ];   
% SL2 = [ [SOL{11};SOL{2}], [SOL{10};SOL{3}], [SOL{9};SOL{4}] ];
% SL3 = [ [SOL{16};SOL{10};SOL{3}], [SOL{15};SOL{9};SOL{4}], [SOL{14};SOL{8};SOL{5}], [SOL{13};SOL{7};SOL{6}] ];
% 
%     SL1m = imresize( (SL1(:,:,1)),0.1 );
%     SL1cx = [-17:(-15-(-17))/size(SL1m,2):-15]; SL1cx=SL1cx(:,1:end-1);
%     SL1cx = repmat(SL1cx,size(SL1m,1),1);  %imtool(SL1cx, [])
%     SL1cy = [12:(14-12)/size(SL1m,1):14]; SL1cy=SL1cy(:,1:end-1)';
%     SL1cy = repmat(SL1cy,1,size(SL1m,2)); %imtool(SL1cy, [])
% 
%     SL2m = imresize( (SL2(:,:,1)),0.1 );
%     SL2cx = [-15:(-11-(-15))/size(SL2m,2):-11]; SL2cx=SL2cx(:,1:end-1);
%     SL2cx = repmat(SL2cx,size(SL2m,1),1);  imtool(SL2cx, [])
%     SL2cy = [12:(14-12)/size(SL2m,1):14]; SL2cy=SL2cy(:,1:end-1)';
%     SL2cy = repmat(SL2cy,1,size(SL2m,2)); imtool(SL2cy, [])
% 
% 
%     %% Delimitation - DB1 SATELLITE // DB2 SODAGRI-sample
%     Senegal = shaperead('SEN2.shp');  load('SenegalR.mat'); 
%     for i=1:5
%         polig = SenegalR(i);
%         polX=polig.X; polY=polig.Y;
%         plot( polig.X, polig.Y, 'k-', 'LineWidth', 1), hold on
%     end, xlabel("Longitude"), ylabel("Latitude"), grid on
%     SOLDB1 = readtable('DBSOILV2.xlsx'); %% SODAGRI
%     X = SOLDB1.LON;
%     Y = SOLDB1.LAT;
%     % plot(X,Y, 'k.')
% 
%         SAND2T = [];
%         SILT2T = [];
%         CLAY2T = [];
%         BULK2T = [];
%         CARB2T = [];
% 
%         SAND1T = [];
%         SILT1T = [];
%         CLAY1T = [];
%         BULK1T = [];
%         CARB1T = [];
% 
% 
%     for REGION=1:5
%         % POLIGONO REGION X
%         polig = SenegalR(REGION);
%         polX=polig.X; polY=polig.Y;     % plot(polX, polY, 'k-', 'LineWidth', 1), hold on, plot(X,Y, 'k.')
% 
%         in = inpolygon(X,Y,polX,polY);
%         SAND1 = SOLDB1.x_Sand(in); mean(SAND1), std(SAND1)
%         SILT1 = SOLDB1.x_Silt(in); mean(SILT1), std(SILT1)
%         CLAY1 = SOLDB1.x_Clay(in); mean(CLAY1), std(CLAY1)
%         CARB1 = SOLDB1.T_C(in); mean(CARB1), std(CARB1)
% 
%         LON1 = SOLDB1.LON(in);
%         LAT1 = SOLDB1.LAT(in);
% 
%         cap = 1; % deep
%         SAND2 = []; SILT2 = []; CLAY2 = []; BULK2 = []; CARB2 = [];
% 
%         for jj =1 : numel(LON1)
% 
%             longitudT = round(LON1(jj),2);
%             latitudT = round(LAT1(jj),2);
% 
%             if (REGION == 1) || (REGION == 2)
%                 SL = SL1;
%                 DD = ( (-15) - (-17) ) / size(SL,1); 
%                 longitudV1 = [-17: DD : -15]; longitudV1 = round(longitudV1(1:end-1),2);
%                 DD2 = ( (14) - (12) ) / size(SL,2);
%                 latitudV2 = [12: DD2 : 14]; latitudV2 = round(latitudV2(1:end-1),2);
% 
%                 [idx1] = [longitudT == longitudV1].*[1:1:numel(longitudV1)]; idx1 = idx1(idx1 > 0);
%                 [idx2] = [latitudT == latitudV2 ].*[1:1:numel(latitudV2 )];  idx2 = idx2(idx2 > 0);
%                 if (sum(idx1) > 0 ) &&  (sum(idx2) > 0 )                
%                     SAND2 = [SAND2; SL(idx1(round(numel(idx1)/2)),idx2(round(numel(idx2)/2)),3+cap )  / 10 ];
%                     SILT2 = [SILT2; SL(idx1(round(numel(idx1)/2)),idx2(round(numel(idx2)/2)),9+cap )  / 10 ];
%                     CLAY2 = [CLAY2; SL(idx1(round(numel(idx1)/2)),idx2(round(numel(idx2)/2)),15+cap ) / 10 ];
%                     BULK2 = [BULK2; SL(idx1(round(numel(idx1)/2)),idx2(round(numel(idx2)/2)),21+cap ) / 100];
%                     CARB2 = [CARB2; SL(idx1(round(numel(idx1)/2)),idx2(round(numel(idx2)/2)),33+cap ) / 100];
%                 end
%             end
% 
%             if (REGION == 3)
%                 SL = SL2;
%                 DD = ( (-13) - (-16) ) / size(SL,1); 
%                 longitudV1 = [-16: DD : -13]; longitudV1 = round(longitudV1(1:end-1),2);
%                 DD2 = ( (14) - (12) ) / size(SL,2);
%                 latitudV2 = [12: DD2 : 14]; latitudV2 = round(latitudV2(1:end-1),2);
% 
%                 [idx1] = [longitudT == longitudV1].*[1:1:numel(longitudV1)]; idx1 = idx1(idx1 > 0);
%                 [idx2] = [latitudT == latitudV2 ].*[1:1:numel(latitudV2 )];  idx2 = idx2(idx2 > 0);
%                 if (sum(idx1) > 0 ) &&  (sum(idx2) > 0 )                
%                     SAND2 = [SAND2; SL(idx1(round(numel(idx1)/2)),idx2(round(numel(idx2)/2)),3+cap )  / 10 ];
%                     SILT2 = [SILT2; SL(idx1(round(numel(idx1)/2)),idx2(round(numel(idx2)/2)),9+cap )  / 10 ];
%                     CLAY2 = [CLAY2; SL(idx1(round(numel(idx1)/2)),idx2(round(numel(idx2)/2)),15+cap ) / 10 ];
%                     BULK2 = [BULK2; SL(idx1(round(numel(idx1)/2)),idx2(round(numel(idx2)/2)),21+cap ) / 100];
%                     CARB2 = [CARB2; SL(idx1(round(numel(idx1)/2)),idx2(round(numel(idx2)/2)),33+cap ) / 100];
%                 end
%             end
% 
%             if (REGION == 4) || (REGION == 5)
%                 SL = SL3;
%                 DD = ( (-11) - (-15) ) / size(SL,1); 
%                 longitudV1 = [-15: DD : -11]; longitudV1 = round(longitudV1(1:end-1),2);
%                 DD2 = ( (15) - (12) ) / size(SL,2);
%                 latitudV2 = [12: DD2 : 15]; latitudV2 = round(latitudV2(1:end-1),2);
% 
%                 [idx1] = [longitudT == longitudV1].*[1:1:numel(longitudV1)]; idx1 = idx1(idx1 > 0);
%                 [idx2] = [latitudT == latitudV2 ].*[1:1:numel(latitudV2 )];  idx2 = idx2(idx2 > 0);
%                 if (sum(idx1) > 0 ) &&  (sum(idx2) > 0 )                
%                     SAND2 = [SAND2; SL(idx1(round(numel(idx1)/2)),idx2(round(numel(idx2)/2)),3+cap )  / 10 ];
%                     SILT2 = [SILT2; SL(idx1(round(numel(idx1)/2)),idx2(round(numel(idx2)/2)),9+cap )  / 10 ];
%                     CLAY2 = [CLAY2; SL(idx1(round(numel(idx1)/2)),idx2(round(numel(idx2)/2)),15+cap ) / 10 ];
%                     BULK2 = [BULK2; SL(idx1(round(numel(idx1)/2)),idx2(round(numel(idx2)/2)),21+cap ) / 100];
%                     CARB2 = [CARB2; SL(idx1(round(numel(idx1)/2)),idx2(round(numel(idx2)/2)),33+cap ) / 100];
%                 end
%             end
% 
% 
%         end
% 
%         SAND2T{REGION} = [SAND2];
%         SILT2T{REGION} = [SILT2];
%         CLAY2T{REGION} = [CLAY2];
%         BULK2T{REGION} = [BULK2];
%         CARB2T{REGION} = [CARB2];
% 
%         SAND1T{REGION} = SAND1;
%         SILT1T{REGION} = SILT1;
%         CLAY1T{REGION} = CLAY1;
%         CARB1T{REGION} = CARB1;
% 
%         % % ALL Poligon
%         % in = inpolygon(SL1cx,SL1cy,polX,polY);
%         % SAND=imresize( (SL1(:,:,3)),0.1 ); SILT=imresize( (SL1(:,:,9)),0.1 ); CLAY=imresize( (SL1(:,:,15)),0.1 );
%         % SAND2 = SAND.*in; SAND2 = reshape(SAND2,[numel(SAND2),1]); SAND2=SAND2(SAND2 > 0); mean(SAND2), std(SAND2)
%         % SILT2 = SILT.*in; SILT2 = reshape(SILT2,[numel(SILT2),1]); SILT2=SILT2(SILT2 > 0); mean(SILT2), std(SILT2)
%         % CLAY2 = CLAY.*in; CLAY2 = reshape(CLAY2,[numel(CLAY2),1]); CLAY2=CLAY2(CLAY2 > 0); mean(CLAY2), std(CLAY2)
% 
%     end
% 
% 
% 
%      for REGION = 1 : 5
%         F1(1,REGION) = mean(SAND1T{REGION});
%         F1(2,REGION) = std(SAND1T{REGION});
%         F11(1,REGION) = mean(SAND2T{REGION});
%         F11(2,REGION) = std(SAND2T{REGION});
% 
%         F2(1,REGION) = mean(SILT1T{REGION});
%         F2(2,REGION) = std(SILT1T{REGION});
%         F22(1,REGION) = mean(SILT2T{REGION});
%         F22(2,REGION) = std(SILT2T{REGION});
% 
%         F3(1,REGION) = mean(CLAY1T{REGION});
%         F3(2,REGION) = std(CLAY1T{REGION});
%         F33(1,REGION) = mean(CLAY2T{REGION});
%         F33(2,REGION) = std(CLAY2T{REGION});
% 
%         F4(1,REGION) = mean(CARB1T{REGION});
%         F4(2,REGION) = std(CARB1T{REGION});
%         F44(1,REGION) = mean(CARB2T{REGION});
%         F44(2,REGION) = std(CARB2T{REGION});
%      end
% 
%         figure
%         subplot(4,1,1), 
%         errorbar([1:1:5],F1(1,:),F1(2,:),"k", "LineWidth" , 2), hold on,
%         errorbar([1:1:5],F11(1,:),F11(2,:),"r"), hold on, plot([1:1:5],F11(1,:), "r*"),  plot([1:1:5],F1(1,:), "k*") 
%         ylabel("SAND g/Kg"), grid on, xlim([0.8 5.2]), legend('Soil sample DB','Satellite DB')
% 
%         subplot(4,1,2),
%         errorbar([1:1:5],F2(1,:),F2(2,:),"k", "LineWidth" , 2), hold on, plot([1:1:5],F2(1,:), "k*") 
%         errorbar([1:1:5],F22(1,:),F22(2,:),"r"), hold on, plot([1:1:5],F22(1,:), "r*") 
%         ylabel("SILT g/Kg"), grid on, xlim([0.8 5.2])
% 
%         subplot(4,1,3), 
%         errorbar([1:1:5],F3(1,:),F3(2,:),"k", "LineWidth" , 2), hold on, plot([1:1:5],F3(1,:), "k*") 
%         errorbar([1:1:5],F33(1,:),F33(2,:),"r"), hold on, plot([1:1:5],F33(1,:), "r*") 
%         ylabel("CLAY g/Kg"), grid on, xlim([0.8 5.2])
% 
%         subplot(4,1,4),
%         errorbar([1:1:5],F4(1,:),F4(2,:),"k", "LineWidth" , 2), hold on, plot([1:1:5],F4(1,:), "k*") 
%         errorbar([1:1:5],F44(1,:),F44(2,:),"r"), hold on, plot([1:1:5],F44(1,:), "r*") 
%         ylabel("Organic Carbon"), grid on, xlim([0.8 5.2])
% 
% 
%         xlabel("Ziguinchor                               Sedhiou                               Kolda                               Kedougou                               Tambacunda"), grid on
%         % figure ,plot(X,Y, 'k.'), legend('Soil sample')
% 

    Senegal = shaperead('SEN2.shp');  load('SenegalR.mat'); 
    R=[15, 11, 7, 4, 13, 6, 5, 3];
    for i=1:8
        polig = Senegal(R(i));
        polX=polig.X; polY=polig.Y;
        plot( polig.X, polig.Y, 'k-', 'LineWidth', 1), hold on
    end, xlabel("Longitude"), ylabel("Latitude"), grid on

legend('Grid target', 'Satellite match')

end