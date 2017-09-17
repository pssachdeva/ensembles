unique_SA_rep02 = length(unique(id_sa_ea_rep02(:,1)));
unique_EA_rep02 = length(unique(id_sa_ea_rep02(:,2)));
unique_SA_rep03 = length(unique([unique(id_sa01_ea02_rep03(:,1));unique(id_sa02_ea01_rep03(:,1:2))]));
unique_EA_rep03 = length(unique([unique(id_sa01_ea02_rep03(:,2:end));unique(id_sa02_ea01_rep03(:,3:end))]));

if ~isempty(id_sa_ea_rep04)
    unique_SA_rep04 = length(unique(id_sa_ea_rep04(:,1:2)));
    unique_EA_rep04 = length(unique(id_sa_ea_rep04(:,3:4)));
else
    unique_SA_rep04 = 0;
    unique_EA_rep04 = 0;
end

if ~isempty(id_sa02_ea03_rep05)
    unique_SA_rep05_1 = unique(id_sa02_ea03_rep05(:,1:2));
    unique_EA_rep05_1 = unique(id_sa02_ea03_rep05(:,3:end));
else
    unique_SA_rep05_1 = [];
    unique_EA_rep05_1 = [];
end

if size(unique_SA_rep05_1,2)>1
    unique_SA_rep05_1 = unique_SA_rep05_1';
else
    unique_SA_rep05_1 = unique_SA_rep05_1;
end
if size(unique_EA_rep05_1,2)>1
    unique_EA_rep05_1 = unique_EA_rep05_1';
else
    unique_EA_rep05_1 = unique_EA_rep05_1;
end

if ~isempty(id_sa03_ea02_rep05)
    unique_SA_rep05_2 = unique(id_sa03_ea02_rep05(:,1:3));
    unique_EA_rep05_2 = unique(id_sa03_ea02_rep05(:,4:end));
else
    unique_SA_rep05_2 = [];
    unique_EA_rep05_2 = [];
end

if size(unique_SA_rep05_2,2)>1
    unique_SA_rep05_2 = unique_SA_rep05_2';
else
    unique_SA_rep05_2 = unique_SA_rep05_2;
end
if size(unique_EA_rep05_2,2)>1
    unique_EA_rep05_2 = unique_EA_rep05_2';
else
    unique_EA_rep05_2 = unique_EA_rep05_2;
end
unique_SA_rep05 = length(unique([unique_SA_rep05_1;unique_SA_rep05_2]));
unique_EA_rep05 = length(unique([unique_EA_rep05_1;unique_EA_rep05_2]));

if ~isempty(id_sa_ea_rep06)
    unique_SA_rep06 = length(unique(id_sa_ea_rep06(:,1:3)));
    unique_EA_rep06 = length(unique(id_sa_ea_rep06(:,4:6)));
else
    unique_SA_rep06 = 0;
    unique_EA_rep06 = 0;
end

if ~isempty(id_sa03_ea04_rep07)
    unique_SA_rep07_1 = unique(id_sa03_ea04_rep07(:,1:3));
    unique_EA_rep07_1 = unique(id_sa03_ea04_rep07(:,4:end));
else
    unique_SA_rep07_1 = [];
    unique_EA_rep07_1 = [];
end

if size(unique_SA_rep07_1,2)>1
    unique_SA_rep07_1 = unique_SA_rep07_1';
else
    unique_SA_rep07_1 = unique_SA_rep07_1;
end
if size(unique_EA_rep07_1,2)>1
    unique_EA_rep07_1 = unique_EA_rep07_1';
else
    unique_EA_rep07_1 = unique_EA_rep07_1;
end

if ~isempty(id_sa04_ea03_rep07)
    unique_SA_rep07_2 = unique(id_sa04_ea03_rep07(:,1:4));
    unique_EA_rep07_2 = unique(id_sa04_ea03_rep07(:,5:end));
else
    unique_SA_rep07_2 = [];
    unique_EA_rep07_2 = [];
end

if size(unique_SA_rep07_2,2)>1
    unique_SA_rep07_2 = unique_SA_rep07_2';
else
    unique_SA_rep07_2 = unique_SA_rep07_2;
end
if size(unique_EA_rep07_2,2)>1
    unique_EA_rep07_2 = unique_EA_rep07_2';
else
    unique_EA_rep07_2 = unique_EA_rep07_2;
end
unique_SA_rep07 = length(unique([unique_SA_rep07_1;unique_SA_rep07_2]));
unique_EA_rep07 = length(unique([unique_EA_rep07_1;unique_EA_rep07_2]));

if ~isempty(id_sa_ea_rep08)
    unique_SA_rep08 = length(unique(id_sa_ea_rep08(:,1:4)));
    unique_EA_rep08 = length(unique(id_sa_ea_rep08(:,5:8)));
else
    unique_SA_rep08 = 0;
    unique_EA_rep08 = 0;
end

 %% load unique_num_rep
uni_EA_rep = [unique_EA_rep02,unique_EA_rep03,unique_EA_rep04,unique_EA_rep05,unique_EA_rep06,unique_EA_rep07,unique_EA_rep08];
per_EA_rep = (uni_EA_rep./numrep)*100;
save('EASA_per_corEA_rep','per_EA_rep');

%%
[~,nframes] = size(foopsilogical(:,synframes));
uni02_EA = unique_EA_rep02/nframes*100;
uni03_EA = unique_EA_rep03/nframes*100;
uni04_EA = unique_EA_rep04/nframes*100;
uni05_EA = unique_EA_rep05/nframes*100;
uni06_EA = unique_EA_rep06/nframes*100;
uni07_EA = unique_EA_rep07/nframes*100;
uni08_EA = unique_EA_rep08/nframes*100;
unirep_EA = [uni02_EA,uni03_EA,uni04_EA,uni05_EA,uni06_EA,uni07_EA,uni08_EA];

% unirep_EA = [uni02_EA,uni03_EA,uni04_EA,uni05_EA,uni06_EA,NaN,NaN];

%%
figure, 
plot(2:8,unirep_EA,'LineWidth',4,'color',[255/255,102/255,255/255]), 
hold on
errorbar(2:8,mean(unirep_EA_s),std(unirep_EA_s),'LineWidth',2,'color',[255/255,102/255,255/255], 'LineStyle','--')
plot(2:8,unirep_EA,'LineWidth',4,'color',[102/255,153/255,255/255])
errorbar(2:8,mean(unirep_EA_s),std(unirep_EA_s),'LineWidth',2,'color',[102/255,153/255,255/255], 'LineStyle','--'), hold off


