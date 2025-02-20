function[] = plot_result_fault_slip_dist(fileName)


infoValues = load(fileName);

figure
patch([infoValues.resultstruct.patch_new1.yfault], [infoValues.resultstruct.patch_new1.zfault], infoValues.resultstruct.slip(1:length(infoValues.resultstruct.patch_new))')
axis image
set(gca,'ydir', 'reverse')
c = colorbar;
c.Label.String = 'cm';
colormap('jet') 
title('Final Slip Distribution')
xlabel('Along strike (m)')
ylabel('Along dip (m)')
%set(gca,'xTick',[0:1000:16820])