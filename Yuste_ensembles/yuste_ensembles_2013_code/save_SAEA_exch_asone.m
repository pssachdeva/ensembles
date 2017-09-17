unique_SA_rep02 = length(unique(id_sa_ea_rep02(:,1)));
unique_EA_rep02 = length(unique(id_sa_ea_rep02(:,2)));

unique_SA_rep03 = length(unique([unique(id_sa01_ea02_rep03(:,1));unique(id_sa02_ea01_rep03(:,1:2))]));
unique_EA_rep03 = length(unique([unique(id_sa01_ea02_rep03(:,2:end));unique(id_sa02_ea01_rep03(:,3:end))]));

unique_SA_rep04 = length(unique(id_sa_ea_rep04(:,1:2)));
unique_EA_rep04 = length(unique(id_sa_ea_rep04(:,3:4)));

unique_SA_rep05 = length(unique([unique(id_sa02_ea03_rep05(:,1:2));unique(id_sa03_ea02_rep05(:,1:3))]));
unique_EA_rep05 = length(unique([unique(id_sa02_ea03_rep05(:,3:end));unique(id_sa03_ea02_rep05(:,4:end))]));

unique_SA_rep05 = length(unique([unique(id_sa02_ea03_rep05(:,1:2));id_sa03_ea02_rep05(:,1:3)']));
unique_EA_rep05 = length(unique([unique(id_sa02_ea03_rep05(:,3:end));id_sa03_ea02_rep05(:,4:end)']));

unique_SA_rep06 = length(unique(id_sa_ea_rep06(:,1:3)));
unique_EA_rep06 = length(unique(id_sa_ea_rep06(:,4:6)));

unique_SA_rep06 = 0;
unique_EA_rep06 = 0;

unique_SA_rep07 = length(unique([unique(id_sa03_ea04_rep07(:,1:3));unique(id_sa04_ea03_rep07(:,1:4))]));
unique_EA_rep07 = length(unique([unique(id_sa03_ea04_rep07(:,4:end));unique(id_sa04_ea03_rep07(:,5:end))]));

unique_SA_rep07 = length(unique([unique(id_sa03_ea04_rep07(:,1:3));id_sa04_ea03_rep07(:,1:4)']));
unique_EA_rep07 = length(unique([unique(id_sa03_ea04_rep07(:,4:end));id_sa04_ea03_rep07(:,5:end)']));

unique_SA_rep07 = length(unique([id_sa03_ea04_rep07(:,1:3)';unique(id_sa04_ea03_rep07(:,1:4))]));
unique_EA_rep07 = length(unique([id_sa03_ea04_rep07(:,4:end)';unique(id_sa04_ea03_rep07(:,5:end))]));

unique_SA_rep07 = length(unique(id_sa03_ea04_rep07(:,1:3)));
unique_EA_rep07 = length(unique(id_sa03_ea04_rep07(:,4:end)));

unique_SA_rep07 = length(unique(id_sa04_ea03_rep07(:,1:4)));
unique_EA_rep07 = length(unique(id_sa04_ea03_rep07(:,5:end)));

unique_SA_rep07 = 0;
unique_EA_rep07 = 0;

if ~isempty(id_sa_ea_rep08)
unique_SA_rep08 = length(unique(id_sa_ea_rep08(:,1:4)));
unique_EA_rep08 = length(unique(id_sa_ea_rep08(:,5:8)));
else
unique_SA_rep08 = 0;   
unique_EA_rep08 = 0;
end
%%
[~,nframes] = size(foopsilogical_evoked(:,synframes_evoked));
uni02_EA = unique_EA_rep02/nframes*100;
uni03_EA = unique_EA_rep03/nframes*100;
uni04_EA = unique_EA_rep04/nframes*100;
uni05_EA = unique_EA_rep05/nframes*100;
uni06_EA = unique_EA_rep06/nframes*100;
uni07_EA = unique_EA_rep07/nframes*100;
uni08_EA = unique_EA_rep08/nframes*100;
unirep_EA = [uni02_EA,uni03_EA,uni04_EA,uni05_EA,uni06_EA,uni07_EA,uni08_EA];

[~,nframes] = size(foopsilogical_spon);
uni02_SA = unique_SA_rep02/nframes*100;
uni03_SA = unique_SA_rep03/nframes*100;
uni04_SA = unique_SA_rep04/nframes*100;
uni05_SA = unique_SA_rep05/nframes*100;
uni06_SA = unique_SA_rep06/nframes*100;
uni07_SA = unique_SA_rep07/nframes*100;
uni08_SA = unique_SA_rep08/nframes*100;
unirep_SA = [uni02_SA,uni03_SA,uni04_SA,uni05_SA,uni06_SA,uni07_SA,uni08_SA];

%%
save('overlap_exch_out_10','id_sa_ea_rep02',...
    'id_sa01_ea02_rep03','id_sa02_ea01_rep03','id_sa_ea_rep04',...
    'id_sa02_ea03_rep05','id_sa03_ea02_rep05','id_sa_ea_rep06',...
    'id_sa03_ea04_rep07','id_sa04_ea03_rep07','id_sa_ea_rep08',...
    'unirep_EA','unirep_SA')

%% for overlap_1
cell_sa01_ea02_rep03 = cell(1,1);
cell_sa02_ea01_rep03 = cell(1,1);
cell_sa02_ea03_rep05 = cell(1,1);
cell_sa03_ea02_rep05 = cell(1,1);
cell_sa03_ea04_rep07 = cell(1,1);
cell_sa04_ea03_rep07 = cell(1,1);
cell_rep02 = cell(1,1);
cell_rep04 = cell(1,1);
cell_rep06 = cell(1,1);
cell_rep08 = cell(1,1);

i = 1;
cell_sa01_ea02_rep03{i} = id_sa01_ea02_rep03;
cell_sa02_ea01_rep03{i} = id_sa02_ea01_rep03;
cell_sa02_ea03_rep05{i} = id_sa02_ea03_rep05;
cell_sa03_ea02_rep05{i} = id_sa03_ea02_rep05;
cell_sa03_ea04_rep07{i} = id_sa03_ea04_rep07;
cell_sa04_ea03_rep07{i} = id_sa04_ea03_rep07;
cell_rep02{i} = id_sa_ea_rep02;
cell_rep04{i} = id_sa_ea_rep04;
cell_rep06{i} = id_sa_ea_rep06;
cell_rep08{i} = id_sa_ea_rep08;
cell_EA = unirep_EA;
cell_SA = unirep_SA;

all_id_sa01_ea02_rep03 = cell_sa01_ea02_rep03;
all_id_sa02_ea01_rep03 = cell_sa02_ea01_rep03;
all_id_sa02_ea03_rep05 = cell_sa02_ea03_rep05;
all_id_sa03_ea02_rep05 = cell_sa03_ea02_rep05;
all_id_sa03_ea04_rep07 = cell_sa03_ea04_rep07;
all_id_sa04_ea03_rep07 = cell_sa04_ea03_rep07;
all_id_sa_ea_rep02 = cell_rep02;
all_id_sa_ea_rep04 = cell_rep04;
all_id_sa_ea_rep06 = cell_rep06;
all_id_sa_ea_rep08 = cell_rep08;
all_unirep_EA = cell_EA;
all_unirep_SA = cell_SA;
%% for overlap_2 to end

i = 1;
cell_sa01_ea02_rep03{i} = id_sa01_ea02_rep03;
cell_sa02_ea01_rep03{i} = id_sa02_ea01_rep03;
cell_sa02_ea03_rep05{i} = id_sa02_ea03_rep05;
cell_sa03_ea02_rep05{i} = id_sa03_ea02_rep05;
cell_sa03_ea04_rep07{i} = id_sa03_ea04_rep07;
cell_sa04_ea03_rep07{i} = id_sa04_ea03_rep07;
cell_rep02{i} = id_sa_ea_rep02;
cell_rep04{i} = id_sa_ea_rep04;
cell_rep06{i} = id_sa_ea_rep06;
cell_rep08{i} = id_sa_ea_rep08;
cell_EA = unirep_EA;
cell_SA = unirep_SA;

all_id_sa01_ea02_rep03 = [all_id_sa01_ea02_rep03;cell_sa01_ea02_rep03];
all_id_sa02_ea01_rep03 = [all_id_sa02_ea01_rep03;cell_sa02_ea01_rep03];
all_id_sa02_ea03_rep05 = [all_id_sa02_ea03_rep05;cell_sa02_ea03_rep05];
all_id_sa03_ea02_rep05 = [all_id_sa03_ea02_rep05;cell_sa03_ea02_rep05];
all_id_sa03_ea04_rep07 = [all_id_sa03_ea04_rep07;cell_sa03_ea04_rep07];
all_id_sa04_ea03_rep07 = [all_id_sa04_ea03_rep07;cell_sa04_ea03_rep07];
all_id_sa_ea_rep02 = [all_id_sa_ea_rep02;cell_rep02];
all_id_sa_ea_rep04 = [all_id_sa_ea_rep04;cell_rep04];
all_id_sa_ea_rep06 = [all_id_sa_ea_rep06;cell_rep06];
all_id_sa_ea_rep08 = [all_id_sa_ea_rep08;cell_rep08];
all_unirep_EA = [all_unirep_EA;cell_EA];
all_unirep_SA = [all_unirep_SA;cell_SA];

%% at the end
id_sa01_ea02_rep03 = all_id_sa01_ea02_rep03;
id_sa02_ea01_rep03 = all_id_sa02_ea01_rep03;
id_sa02_ea03_rep05 = all_id_sa02_ea03_rep05;
id_sa03_ea02_rep05 = all_id_sa03_ea02_rep05;
id_sa03_ea04_rep07 = all_id_sa03_ea04_rep07;
id_sa04_ea03_rep07 = all_id_sa04_ea03_rep07;
id_sa_ea_rep02 = all_id_sa_ea_rep02;
id_sa_ea_rep04 = all_id_sa_ea_rep04;
id_sa_ea_rep06 = all_id_sa_ea_rep06;
id_sa_ea_rep08 = all_id_sa_ea_rep08;
unirep_EA = all_unirep_EA;
unirep_SA = all_unirep_SA;

%%
save('count_SAEA_exch_shuffled_10','id_sa_ea_rep02',...
    'id_sa01_ea02_rep03','id_sa02_ea01_rep03','id_sa_ea_rep04',...
    'id_sa02_ea03_rep05','id_sa03_ea02_rep05','id_sa_ea_rep06',...
    'id_sa03_ea04_rep07','id_sa04_ea03_rep07','id_sa_ea_rep08',...
    'unirep_EA','unirep_SA')


