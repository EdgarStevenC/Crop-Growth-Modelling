function [TD] = SENgraph2(var,unit, STATS, VM)



STATS(2,2:end) = 1;
STATS(1,:) = log(STATS(1,:));
STATS(isnan(STATS)) = 0;
STATS(isinf(STATS) & STATS == -Inf) = 0;
STATS(isinf(STATS)) = 0;

% Create t_axes
f1 = figure('Units','normalized','Position',[0.0102    0.2863    0.5199    0.5831]);   %.2,.1,.52,.72]);
TD = STaylorDiag(STATS);

VM = max(STATS(1,:))*1.1;
TD.set('SLim',[0,VM]);

% Color list
colorList =[0.0000    0.0000    0.5625
            0.0000    0.0000    1.0000
            0.0000    0.5000    1.0000
            0.0000    1.0000    1.0000
            0.5000    1.0000    0.5000
            1.0000    1.0000    0.0000
            1.0000    0.6471    0.0000
            1.0000    0.0000    0.0000
            0.8000    0.0000    0.0000
            0.5000    0.0000    0.0000
            0.2500    0.0000    0.0000];
MarkerType={'o'}; % ,'diamond','pentagram','^','v'
% Plot
for i = 1:size(STATS,2)
    TD.SPlot(STATS(1,i),STATS(2,i),STATS(3,i),'Marker',MarkerType{1},'MarkerSize',13,'Color',colorList(i,:),'MarkerFaceColor',colorList(i,:));
end

% Legend
NameList = {'P1', 'P2O', 'P2R', 'P5', 'G1', 'G2', 'G3', 'PHINT', 'THOT', 'TCLDP', 'TCLDF'};
lg = legend(NameList,'FontSize',13,'FontName','Times New Roman')
lg.Position = [0.9024    0.5168    0.0917    0.4764]; %      0.8636    0.5898    0.0917    0.2982];

for i = 1:size(STATS,2)
    TD.SText(STATS(1,i),STATS(2,i),STATS(3,i),"   "+string(NameList{i}),'FontWeight','bold',...
    'FontSize',14,'FontName','Times New Roman',...
    'VerticalAlignment','middle','HorizontalAlignment','left');
end

TD.set('CTickValues',[.1,.2,.3,.4,.5,.6,.7,.8,.9,.95,.99])
TD.set('CGrid','Color',[0,0,.8],'LineStyle',':','LineWidth',.8);
TD.set('CTickLabel','Color',[0,0,.8],'FontWeight','bold')
TD.set('CLabel','Color',[0,0,.8],'FontWeight','bold')
TD.set('CAxis','Color',[0,0,.8],'LineWidth',2)

TD.SLabel.String = unit ;
TD.CLabel.String = 'RSI'; % Relative Sensitivity Index (RSI)





text(TD.SLim(2),TD.SLim(2),var,'Color',[.77,.6,.18],...
    'VerticalAlignment','bottom','HorizontalAlignment','right',...
    'FontSize',23,'FontName','Times New Roman','FontWeight','bold')

TD.set('RGrid','Color',[1,1,1],'LineWidth',1.5)
TD.set('RTickLabel','Color',[1,1,1],'FontWeight','bold')

exportgraphics(f1, ['RESULTS/', var, '.png'], 'Resolution', 300);  % 300 dpi
savefig(f1, ['RESULTS/', var, '.fig']);

end