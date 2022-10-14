function[] = plot_result_fs(fileName, index)

infoValues = load(fileName);
cmin = -20;
cmax = 20;
xmin = 500000;
xmax = 600000;
ymin = 3600000;
ymax = 3700000;


Ndata = index;
rowNos = 1:3;
figure
subplot(3,1,1)
patch(infoValues.resultstruct.boxx(rowNos,Ndata),infoValues.resultstruct.boxy(rowNos,Ndata), infoValues.resultstruct.data(Ndata).*100);
axis image
shading flat
c = colorbar;
c.Label.String = 'LOS displacement (cm)';
title('Data')
caxis([cmin cmax])
set(gca,'xLim',[xmin xmax])
set(gca,'yLim',[ymin ymax])
box on
set(gca,'fontsize',10)


subplot(3,1,2)
patch(infoValues.resultstruct.boxx(rowNos,Ndata),infoValues.resultstruct.boxy(rowNos,Ndata), infoValues.resultstruct.synth(Ndata).*100)
axis image
shading flat
c = colorbar;
c.Label.String = 'LOS displacement (cm)';
title('Model')
caxis([cmin cmax])
set(gca,'xLim',[xmin xmax])
set(gca,'yLim',[ymin ymax])
box on
set(gca,'fontsize',10)


subplot(3,1,3)
patch(infoValues.resultstruct.boxx(rowNos,Ndata),infoValues.resultstruct.boxy(rowNos,Ndata), (infoValues.resultstruct.data(Ndata)-infoValues.resultstruct.synth(Ndata)).*100)
axis image
shading flat
c = colorbar;
c.Label.String = 'LOS displacement (cm)';
title('Residual')
caxis([cmin cmax])
set(gca,'xLim',[xmin xmax])
set(gca,'yLim',[ymin ymax])
box on
set(gca,'fontsize',10)

