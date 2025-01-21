function [soilTexture, SLLL, SDUL, SSAT, SSKS ] = SOILtype(sand, silt, clay)

    soilTexture =  "NI";
    if ( clay >= 40 && sand <= 45 && silt < 40 ) 
        soilTexture = "Clay";
        SS = 12;
    end
    
    if (clay >= 40  &&  silt >= 40)
        soilTexture = "Silty Clay";
        SS = 11;
    end
    
    if(clay >= 35 && sand > 45)
        soilTexture = "Sandy Clay";
        SS = 10;
    end
    
    if(clay >= 27 && clay < 40 && sand <= 20)
        soilTexture = "Silty Clay LOAM";
        SS = 9;
    end
    
    if (clay >= 27  && clay < 40  &&  sand > 20  &&  sand <= 45)
        soilTexture = "Clay LOAM";
        SS = 8;
    end
    
    if (clay >= 20  &&  clay < 35 &&  silt < 28  &&  sand > 45)
        soilTexture = "Sandy Clay LOAM";
        SS = 7;
    end
    
    if(silt >= 80  &&  clay < 12)
        soilTexture = "Silt";
        SS = 6;
    end
    
    if ((silt>=50 && clay>=12 && clay<27) || (silt >=50 && silt<80 && clay<12) )
        soilTexture = "Silt LOAM";
        SS = 5;
    end
    
    if (clay>=7 && clay<27 && silt>=28 && silt<50 && sand<=52 )
        soilTexture = "LOAM";
        SS = 4;
    end
    
    if ( (clay>=7 && clay<20 && sand>52 && silt + 2*clay>=30) || (clay<7 && silt<50 && silt+2*clay>=30)) 
        soilTexture = "Sandy LOAM";
        SS = 3;
    end 
    
    if( (1.5*clay >= 10) && ( (silt+2*clay)<30) )
        soilTexture = "Loamy Sand";
        SS = 2;
    end     
    
    if(silt + (1.5*clay) < 10)
        soilTexture = "Sand";
        SS = 1;
    end  

    if ( clay == 0 && sand == 0 && silt == 00 ) 
        soilTexture =  "NI";
        SS = 0;
    end

    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %% Clay
if soilTexture == "Clay"
    SLLL = 0.18;  % lower limit of extractable soil water (Wilting Point)
    SDUL = 0.40;  % Drained upper limit (FIELD CAPACITY)
    SSAT = 0.48;  % Saturated upper limit (SATURATION)
    SSKS = 0.06;  % Saturated Hydraulic Conductivity
end 
%% Silty Clay
if soilTexture ==  "Silty Clay"
    SLLL = 0.15;  % lower limit of extractable soil water (Wilting Point)
    SDUL = 0.36;  % Drained upper limit (FIELD CAPACITY)
    SSAT = 0.47;  % Saturated upper limit (SATURATION)
    SSKS = 0.09;  % Saturated Hydraulic Conductivity
end 
%% Sandy Clay
if soilTexture ==  "Sandy Clay"
    SLLL = 0.15;  % lower limit of extractable soil water (Wilting Point)
    SDUL = 0.35;  % Drained upper limit (FIELD CAPACITY)
    SSAT = 0.42;  % Saturated upper limit (SATURATION)
    SSKS = 0.12;  % Saturated Hydraulic Conductivity
end 
%% Silty Clay LOAM
 if soilTexture == "Silty Clay LOAM"
    SLLL = 0.14;  % lower limit of extractable soil water (Wilting Point)
    SDUL = 0.35;  % Drained upper limit (FIELD CAPACITY)
    SSAT = 0.46;  % Saturated upper limit (SATURATION)
    SSKS = 0.15;  % Saturated Hydraulic Conductivity
end 
%% Clay LOAM
if soilTexture == "Clay LOAM"
    SLLL = 0.15;  % lower limit of extractable soil water (Wilting Point)
    SDUL = 0.35;  % Drained upper limit (FIELD CAPACITY)
    SSAT = 0.46;  % Saturated upper limit (SATURATION)
    SSKS = 0.23;  % Saturated Hydraulic Conductivity
end 
%% Sandy Clay LOAM
if soilTexture == "Sandy Clay LOAM" 
    SLLL = 0.12;  % lower limit of extractable soil water (Wilting Point)
    SDUL = 0.30;  % Drained upper limit (FIELD CAPACITY)
    SSAT = 0.42;  % Saturated upper limit (SATURATION)
    SSKS = 0.43;  % Saturated Hydraulic Conductivity
end 
%% Silt
if soilTexture ==  "Silt"
    SLLL = 0.12;  % lower limit of extractable soil water (Wilting Point)
    SDUL = 0.35;  % Drained upper limit (FIELD CAPACITY)
    SSAT = 0.45;  % Saturated upper limit (SATURATION)
    SSKS = 0.68;  % Saturated Hydraulic Conductivity
end 
%% Silt Loam
if soilTexture == "Silt LOAM"
    SLLL = 0.09;  % lower limit of extractable soil water (Wilting Point)
    SDUL = 0.34;  % Drained upper limit (FIELD CAPACITY)
    SSAT = 0.45;  % Saturated upper limit (SATURATION)
    SSKS = 0.68;  % Saturated Hydraulic Conductivity
end 
%% Loam
if soilTexture == "LOAM"  
    SLLL = 0.09;  % lower limit of extractable soil water (Wilting Point)
    SDUL = 0.37;  % Drained upper limit (FIELD CAPACITY)
    SSAT = 0.45;  % Saturated upper limit (SATURATION)
    SSKS = 1.32;  % Saturated Hydraulic Conductivity
end 
%% Sandy Loam
if soilTexture == "Sandy LOAM"
    SLLL = 0.07;  % lower limit of extractable soil water (Wilting Point)
    SDUL = 0.22;  % Drained upper limit (FIELD CAPACITY)
    SSAT = 0.43;  % Saturated upper limit (SATURATION)
    SSKS = 2.59;  % Saturated Hydraulic Conductivity
end 
%% Loamy sand
if soilTexture == "Loamy Sand"
    SLLL = 0.06;  % lower limit of extractable soil water (Wilting Point)
    SDUL = 0.22;  % Drained upper limit (FIELD CAPACITY)
    SSAT = 0.41;  % Saturated upper limit (SATURATION)
    SSKS = 6.11;  % Saturated Hydraulic Conductivity
end 
%% Sand
if soilTexture == "Sand"
    SLLL = 0.04;  % lower limit of extractable soil water (Wilting Point)
    SDUL = 0.10;  % Drained upper limit (FIELD CAPACITY)
    SSAT = 0.39;  % Saturated upper limit (SATURATION)
    SSKS = 21.0;  % Saturated Hydraulic Conductivity
end 

%% Sand
if soilTexture == "NI"
    SLLL = -99;  % lower limit of extractable soil water (Wilting Point)
    SDUL = -99;  % Drained upper limit (FIELD CAPACITY)
    SSAT = -99;  % Saturated upper limit (SATURATION)
    SSKS = -99;  % Saturated Hydraulic Conductivity
end 

end