Ndata = 1633:3097;
rowNos = 1:3;
figure
subplot(3,1,1)
patch(resultstruct.boxx(rowNos,Ndata),resultstruct.boxy(rowNos,Ndata), resultstruct.data(Ndata));
axis image
shading flat
colorbar
title('Data')

subplot(3,1,2)
patch(resultstruct.boxx(rowNos,Ndata),resultstruct.boxy(rowNos,Ndata), resultstruct.synth(Ndata))
axis image
shading flat
colorbar
title('Synthetic')

subplot(3,1,3)
patch(resultstruct.boxx(rowNos,Ndata),resultstruct.boxy(rowNos,Ndata), resultstruct.data(Ndata)-resultstruct.synth(Ndata))
axis image
shading flat
colorbar
title('Data Misfit')
