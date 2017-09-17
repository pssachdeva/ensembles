uni02 = length(unique(rep02));
uni03 = length(unique(rep03));
uni04 = length(unique(rep04));
uni05 = length(unique(rep05));
% uni06 = length(unique(rep06));
% uni07 = length(unique(rep07));

[~,nframes] = size(foopsilogical(:,synframes));
uni02 = length(unique(rep02))/nframes*100;
uni03 = length(unique(rep03))/nframes*100;
uni04 = length(unique(rep04))/nframes*100;
uni05 = length(unique(rep05))/nframes*100;
% uni06 = length(unique(rep06))/nframes*100;
% uni07 = length(unique(rep07))/nframes*100;
unirep = [uni02,uni03,uni04,uni05];


save('perframe_rep','unirep')
% unirep = [uni02,uni03,uni04,uni05, NaN, NaN];
%%
uni01 = sig_cc_synframes_unique;
uni02 = unique(rep02);
uni03 = unique(rep03);
uni04 = unique(rep04);
numrep = [length(uni01),length(uni01),length(uni02),length(uni02),length(uni03),length(uni03),length(uni04)];
save('unique_num_rep','numrep')

%%
figure, plot(2:7,unirep,'LineWidth',4,'color',[153/255,153/255,153/255]), hold on
errorbar(2:7,mean(fper),std(fper),'LineWidth',2,'color',[153/255,153/255,153/255], 'LineStyle','--')
plot(2:7,unirep,'LineWidth',4,'color',[255/255,102/255,255/255])
errorbar(2:7,mean(fper),std(fper),'LineWidth',2,'color',[255/255,102/255,255/255], 'LineStyle','--')
plot(2:7,unirep,'LineWidth',4,'color',[102/255,153/255,255/255])
errorbar(2:7,mean(fper),std(fper),'LineWidth',2,'color',[102/255,153/255,255/255], 'LineStyle','--'), hold off




