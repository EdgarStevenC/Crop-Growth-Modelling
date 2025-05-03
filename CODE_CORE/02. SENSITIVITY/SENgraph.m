function [] = SENgraph(j, dP1, dP2O, dP2R, dP5, dG1, dG2, dG3,dPHINT,dTHOT,dTCLDP,dTCLDF,uP1,uP2O,uP2R,uP5,uG1,uG2,uG3,uPHINT,uTHOT,uTCLDP,uTCLDF)
hold on
    plot(mean(dP1(j,:)), mean(uP1(j,:)), 'r*'),  plot(mean(dP1(j,:)), mean(uP1(j,:)), 'ko'),           text(mean(dP1(j,:)),  mean(uP1(j,:)),  'P1'), hold on
      errorbar(mean(dP1(j,:)), mean(uP1(j,:)), std(uP1(j,:)) );  
    plot(mean(dP2O(j,:)),mean(uP2O(j,:)), 'g*'), plot(mean(dP2O(j,:)),mean(uP2O(j,:)), 'ko'),          text(mean(dP2O(j,:)), mean(uP2O(j,:)), 'P20')
      errorbar(mean(dP2O(j,:)), mean(uP2O(j,:)), std(uP2O(j,:)) );   
    plot(mean(dP2R(j,:)),mean(uP2R(j,:)), 'b*'), plot(mean(dP2R(j,:)),mean(uP2R(j,:)), 'ko'),          text(mean(dP2R(j,:)), mean(uP2R(j,:)), 'P2R')
      errorbar(mean(dP2R(j,:)), mean(uP2R(j,:)), std(uP2R(j,:)) );  

    plot(mean(dP5(j,:)), mean(uP5(j,:)), 'c*'),  plot(mean(dP5(j,:)), mean(uP5(j,:)), 'ko'),           text(mean(dP5(j,:)), mean(uP5(j,:)), 'P5')
      errorbar(mean(dP5(j,:)), mean(uP5(j,:)), std(uP5(j,:)) );  
    plot(mean(dG1(j,:)), mean(uG1(j,:)), 'm*'),  plot(mean(dG1(j,:)), mean(uG1(j,:)), 'ko'),           text(mean(dG1(j,:)), mean(uG1(j,:)), 'G1')
      errorbar(mean(dG1(j,:)), mean(uG1(j,:)), std(uG1(j,:)) );  
    plot(mean(dG2(j,:)), mean(uG2(j,:)), 'y*'),  plot(mean(dG2(j,:)), mean(uG2(j,:)), 'ko'),           text(mean(dG2(j,:)), mean(uG2(j,:)), 'G2')
      errorbar(mean(dG2(j,:)), mean(uG2(j,:)), std(uG2(j,:)) );  

    plot(mean(dG3(j,:)),    mean(uG3(j,:)), 'r*'),     plot(mean(dG3(j,:)),    mean(uG3(j,:)), 'co'),         text(mean(dG3(j,:)),    mean(uG3(j,:)),    'G3')
    plot(mean(dPHINT(j,:)), mean(uPHINT(j,:)), 'g*'),  plot(mean(dPHINT(j,:)), mean(uPHINT(j,:)), 'co'),      text(mean(dPHINT(j,:)), mean(uPHINT(j,:)), 'PHINT')
    plot(mean(dTHOT(j,:)),  mean(uTHOT(j,:)), 'b*'),   plot(mean(dTHOT(j,:)),  mean(uTHOT(j,:)), 'co'),       text(mean(dTHOT(j,:)),  mean(uTHOT(j,:)),  'THOT')
    plot(mean(dTCLDP(j,:)), mean(uTCLDP(j,:)), 'm*'),  plot(mean(dTCLDP(j,:)), mean(uTCLDP(j,:)), 'co'),      text(mean(dTCLDP(j,:)), mean(uTCLDP(j,:)), 'TCLDP')
    plot(mean(dTCLDF(j,:)), mean(uTCLDF(j,:)), 'k*'),  plot(mean(dTCLDF(j,:)), mean(uTCLDF(j,:)), 'co'),      text(mean(dTCLDF(j,:)), mean(uTCLDF(j,:)), 'TCLDF')

end