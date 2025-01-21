function [] = SHOWsuelos(m,LON2, LAT2)

if m == 1
    %% {'sand'; 'silt'; 'clay'; 'BULK'; 'COARSE'; 'OrganicCarbon';"N";"PH" }
    load('SOILFET2.mat')
    SOLDB1 = readtable('DBSOILV2.xlsx'); %% SODAGRI DB - variables
    Senegal = shaperead('SEN2.shp');  load('SenegalR.mat'); 
    R=[15, 11 , 7, 4, 13, 6, 5, 3];
    for i=1:5
        polig = Senegal(R(i));
        polX=polig.X; polY=polig.Y;
        % plot( polig.X, polig.Y, 'k-', 'LineWidth', 1), hold on
        %% SOIL DB1 - SODAGRID
        in = inpolygon(LON2,LAT2,polX,polY);
        SAND1T = SOLDB1.x_Sand(in); 
        SILT1T = SOLDB1.x_Silt(in); 
        CLAY1T = SOLDB1.x_Clay(in); 
        CARB1T = SOLDB1.T_C(in); 
        NIT1T  = SOLDB1.N(in); 

        LON1 = SOLDB1.LON(in); LAT1 = SOLDB1.LAT(in);
        %% SOIL DB2 - Satellite
        FET = SOILFET2(in,:);
        SAND2T = FET(:,3).*100; 
        SILT2T = FET(:,4).*100; 
        CLAY2T = FET(:,5).*100; 
        CARB2T = FET(:,8);
        NIT2T =  FET(:,9)./10; 

        REGION = i;
        F1(1,REGION) = mean(SAND1T);
        F1(2,REGION) = std(SAND1T);
        F11(1,REGION) = mean(SAND2T);
        F11(2,REGION) = std(SAND2T);

        F2(1,REGION) = mean(SILT1T);
        F2(2,REGION) = std(SILT1T);
        F22(1,REGION) = mean(SILT2T);
        F22(2,REGION) = std(SILT2T);

        F3(1,REGION) = mean(CLAY1T);
        F3(2,REGION) = std(CLAY1T);
        F33(1,REGION) = mean(CLAY2T);
        F33(2,REGION) = std(CLAY2T);

        F4(1,REGION) = mean(CARB1T);
        F4(2,REGION) = std(CARB1T);
        F44(1,REGION) = mean(CARB2T);
        F44(2,REGION) = std(CARB2T);

        F5(1,REGION) = mean(NIT1T);
        F5(2,REGION) = std(NIT1T);
        F55(1,REGION) = mean(NIT2T);
        F55(2,REGION) = std(NIT2T);


    end, xlabel("Longitude"), ylabel("Latitude"), grid on

        figure
        subplot(5,1,1), 
        errorbar([1:1:5],F1(1,:),F1(2,:),"k", "LineWidth" , 2), hold on,
        errorbar([1:1:5],F11(1,:),F11(2,:),"r"), hold on, plot([1:1:5],F11(1,:), "r*"),  plot([1:1:5],F1(1,:), "k*") 
        ylabel("SAND g/Kg"), grid on, xlim([0.8 5.2]), legend('Soil sample DB','Satellite DB')

        subplot(5,1,2),
        errorbar([1:1:5],F2(1,:),F2(2,:),"k", "LineWidth" , 2), hold on, plot([1:1:5],F2(1,:), "k*") 
        errorbar([1:1:5],F22(1,:),F22(2,:),"r"), hold on, plot([1:1:5],F22(1,:), "r*") 
        ylabel("SILT g/Kg"), grid on, xlim([0.8 5.2])

        subplot(5,1,3), 
        errorbar([1:1:5],F3(1,:),F3(2,:),"k", "LineWidth" , 2), hold on, plot([1:1:5],F3(1,:), "k*") 
        errorbar([1:1:5],F33(1,:),F33(2,:),"r"), hold on, plot([1:1:5],F33(1,:), "r*") 
        ylabel("CLAY g/Kg"), grid on, xlim([0.8 5.2])

        subplot(5,1,4),
        errorbar([1:1:5],F4(1,:),F4(2,:),"k", "LineWidth" , 2), hold on, plot([1:1:5],F4(1,:), "k*") 
        errorbar([1:1:5],F44(1,:),F44(2,:),"r"), hold on, plot([1:1:5],F44(1,:), "r*") 
        ylabel("Organic Carbon"), grid on, xlim([0.8 5.2])

        subplot(5,1,5),
        errorbar([1:1:5],F5(1,:), F5(2,:),"k", "LineWidth" , 2), hold on, plot([1:1:5],F5(1,:), "k*") 
        errorbar([1:1:5],F55(1,:),F55(2,:),"r"), hold on, plot([1:1:5],F55(1,:), "r*") 
        ylabel("N"), grid on, xlim([0.8 5.2])


        xlabel("Ziguinchor                               Sedhiou                               Kolda                               Kedougou                               Tambacunda"), grid on
        % figure ,plot(X,Y, 'k.'), legend('Soil sample')
end

end